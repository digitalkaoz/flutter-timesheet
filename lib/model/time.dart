import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';

part 'time.g.dart';

// This is the class used by rest of your codebase
class Time extends TimeBase with _$Time {
  static Time fromMap(Map<String, dynamic> serializedTime) {
    final time = Time();
    time.description = serializedTime['description'];
    time.start =
        TimeOfDay.fromDateTime(DateTime.parse(serializedTime['start']));
    time.end = TimeOfDay.fromDateTime(DateTime.parse(serializedTime['end']));
    time.pause = Duration(seconds: serializedTime['pause']);
    time.date = DateTime.parse(serializedTime['date']);

    return time;
  }
}

// The store-class
abstract class TimeBase with Store {
  @observable
  String description = '';

  @observable
  TimeOfDay start;

  @observable
  TimeOfDay end;

  @observable
  Duration pause = Duration();

  @observable
  DateTime date = DateTime.now();

  @computed
  Duration get total {
    if (date == null || start == null || end == null) {
      return Duration();
    }

    final DateTime startTime =
        DateTime(date.year, date.month, date.day, start.hour, start.minute);
    final DateTime endTime =
        DateTime(date.year, date.month, date.day, end.hour, end.minute);

    return endTime.subtract(pause).difference(startTime);
  }

  @computed
  bool get valid {
    return date != null && start != null && end != null && pause != null;
  }

  @override
  String toString() {
    return "$date $total";
  }
}
