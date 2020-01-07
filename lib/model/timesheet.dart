import 'dart:convert';

import 'package:mobx/mobx.dart';
import 'package:timesheet_flutter/model/local_storage.dart';
import 'package:timesheet_flutter/model/time.dart';

part 'timesheet.g.dart';

class Timesheet extends TimesheetBase with _$Timesheet {
  Timesheet(storage) : super(storage);

  static Timesheet fromString(Storage storage, String serialized) {
    final data = jsonDecode(serialized);

    final t = Timesheet(storage);
    t.archived = data['archived'];

    (data['times'] as List<String>).forEach((dynamic serializedTime) {
      t.times.add(Time.fromMap(serializedTime));
    });

    return t;
  }
}

abstract class TimesheetBase with Store {
  final Storage storage;

  TimesheetBase(this.storage);

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
    if (times.isEmpty) {
      return null;
    }
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
  archive() {
    archived = true;

    autorun((_) async {
      await storage.saveTimesheet(this);
    });
  }

  @action
  setCurrentTime(Time time) {
    editableTime = time;
  }

  @action
  void addTime() {
    times.add(editableTime);
    times.sort((a, b) => b.date.compareTo(a.date));
    editableTime = Time();

    autorun((_) async {
      await storage.saveTimesheet(this);
    });
  }

  String toString() {
    return jsonEncode(
      {
        "archived": archived,
        "times": times
            .map(
              (Time t) => jsonEncode(
                {
                  "description": t.description,
                  "start": "1970-01-01T${t.start.hour}:${t.start.minute}",
                  "end": "1970-01-01T${t.end.hour}:${t.end.minute}",
                  "break": t.pause.inSeconds,
                  "date": t.date.toIso8601String(),
                },
              ),
            )
            .toList(),
      },
    );
  }
}
