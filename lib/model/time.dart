import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mobx/mobx.dart';

part 'time.g.dart';

class Time extends TimeBase with _$Time {
  Time() : super();

  factory Time.fromString(String serializedTime) {
    final data = jsonDecode(serializedTime);

    return Time.fromMap(data);
  }

  factory Time.fromMap(Map<String, dynamic> data) {
    final time = Time();
    time.description = data['description'];
    time.start = TimeOfDay.fromDateTime(DateTime.parse(data['start']));
    time.end = TimeOfDay.fromDateTime(DateTime.parse(data['end']));
    time.pause = Duration(seconds: data['pause']);
    time.date = DateTime.parse(data['date']);

    return time;
  }
}

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
    final DateTime endTime = DateTime(date.year, date.month,
        start.hour <= end.hour ? date.day : date.day + 1, end.hour, end.minute);

    return endTime.subtract(pause).difference(startTime);
  }

  @computed
  bool get valid {
    return date != null && start != null && end != null && pause != null;
  }

  @override
  String toString() {
    return "$description: $date $total";
  }

  Map<String, dynamic> toMap() {
    DateTime endDate =
        end.hour < start.hour ? date.add(Duration(days: 1)) : date;

    return {
      "description": description,
      "start":
          "${DateFormat('yyyy-MM-dd').format(date)}T${start.hour.toString().padLeft(2, '0')}:${start.minute.toString().padLeft(2, '0')}",
      "end":
          "${DateFormat('yyyy-MM-dd').format(endDate)}T${end.hour.toString().padLeft(2, '0')}:${end.minute.toString().padLeft(2, '0')}",
      "pause": pause.inSeconds,
      "date": date.toIso8601String(),
    };
  }

  String toJson() {
    return jsonEncode(toMap());
  }
}
