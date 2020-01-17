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

    final t = Timesheet(storage, data['id']);
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

    return !times.contains(editableTime);
  }

  @action
  removeTime(Time time) {
    if (archived) {
      throw Exception('Timesheet already archived');
    }
    times.remove(time);

    autorun((_) async {
      await storage.saveTimesheet(this);
    });
  }

  @action
  archive() {
    archived = true;

    autorun((_) async {
      await storage.saveTimesheet(this);
    });
  }

  @action
  setCurrentTime(Time time) {
    if (archived) {
      throw Exception('Timesheet already archived');
    }

    editableTime = time;
  }

  @action
  saveTime() {
    if (archived) {
      throw Exception('Timesheet already archived');
    }

    if (isNewtime) {
      times.add(editableTime);
    } else {
      times.replaceRange(
        times.indexOf(editableTime),
        times.indexOf(editableTime) + 1,
        [editableTime],
      );
    }

    times.sort((a, b) => b.date.compareTo(a.date));
    editableTime = Time();

    autorun((_) async {
      await storage.saveTimesheet(this);
    });
  }

  @override
  String toString() {
    return "${start != null ? start.toIso8601String() : ""} ${last != null ? last.toIso8601String() : ""} $total";
  }

  String toJson() {
    return jsonEncode(
      {
        "id": id,
        "archived": archived,
        "times": times.map((Time t) => t.toMap()).toList(),
      },
    );
  }
}
