import 'dart:convert';

import 'package:mobx/mobx.dart';
import 'package:timesheet_flutter/model/persistence/local_storage.dart';
import 'package:timesheet_flutter/model/time.dart';
import 'package:uuid/uuid.dart';

part 'timesheet.g.dart';

class Timesheet extends TimesheetBase with _$Timesheet {
  Timesheet(Storage storage, String id) : super(storage, id);

  factory Timesheet.fromString(Storage storage, String serialized) {
    final data = jsonDecode(serialized);

    return Timesheet.fromMap(storage, data['id'], data);
  }

  factory Timesheet.fromMap(
      Storage storage, String id, Map<String, dynamic> data) {
    final t = Timesheet(storage, id);
    t.archived = data['archived'];

    (data['times'].cast<Map<String, dynamic>>() ?? [])
        .forEach((serializedTime) {
      t.times.add(Time.fromMap(serializedTime));
    });

    return t;
  }

  factory Timesheet.generate(Storage storage) {
    return Timesheet(storage, Uuid().v4());
  }
}

abstract class TimesheetBase with Store {
  final Storage storage;
  final String id;

  TimesheetBase(this.storage, this.id);

  @observable
  ObservableList<Time> times = ObservableList<Time>();

  @observable
  bool archived = false;

  @observable
  Time editableTime = Time();

  Time oldTime;

  @computed
  DateTime get start {
    if (times.isEmpty) {
      return null;
    }

    return times.first.date;
  }

  @computed
  DateTime get last {
    if (times.isEmpty) {
      return null;
    }
    return times.last.date;
  }

  @computed
  Duration get total {
    var sum = Duration.zero;

    times.forEach((Time time) {
      sum += time.total;
    });

    return sum;
  }

  @computed
  bool get isNewtime {
    if (times.isEmpty) {
      return true;
    }

    return !times.contains(oldTime != null ? oldTime : editableTime);
  }

  @action
  Future<bool> removeTime(Time time) {
    if (archived) {
      throw Exception('Timesheet already archived');
    }
    times.remove(time);

    return storage.saveTimesheet(this);
  }

  @action
  Future<bool> archive() {
    archived = true;

    return storage.saveTimesheet(this);
  }

  @action
  setCurrentTime(Time time) {
    if (archived) {
      throw Exception('Timesheet already archived');
    }

    if (time == null) {
      oldTime = null;
      editableTime = Time();
    } else {
      oldTime = time;
      editableTime = Time.fromMap(time.toMap());
    }
  }

  @action
  void setOldTime(Time time) {
    oldTime = time;
  }

  @action
  Future<dynamic> saveTime() {
    if (archived) {
      throw Exception('Timesheet already archived');
    }

    if (isNewtime) {
      times.add(editableTime);
      oldTime = null;
    } else {
      times.replaceRange(
        times.indexOf(oldTime),
        times.indexOf(oldTime) + 1,
        [editableTime],
      );
      oldTime = null;
    }

    times.sort((a, b) => b.date.compareTo(a.date));

    return storage.saveTimesheet(this).then((value) => editableTime = Time());
  }

  @override
  String toString() {
    return "Timesheet<$id> : ${start != null ? start.toIso8601String() : ""} ${last != null ? last.toIso8601String() : ""} $total";
  }

  String toJson() {
    return jsonEncode(toMap());
  }

  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "archived": archived,
      "times": times.map((Time t) => t.toMap()).toList(),
    };
  }
}
