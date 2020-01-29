import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:timesheet_flutter/model/time.dart';

void main() {
  group('total time', () {
    test('normal', () async {
      final time = Time();

      time.start = TimeOfDay(hour: 12, minute: 0);
      time.end = TimeOfDay(hour: 13, minute: 30);
      expect(time.total.inMinutes, Duration(hours: 1, minutes: 30).inMinutes);
    });

    test('day overlapping', () async {
      final time = Time();

      time.start = TimeOfDay(hour: 23, minute: 0);
      time.end = TimeOfDay(hour: 0, minute: 30);
      expect(time.total.inMinutes, Duration(hours: 1, minutes: 30).inMinutes);
    });

    test('same hour', () async {
      final time = Time();

      time.start = TimeOfDay(hour: 12, minute: 0);
      time.end = TimeOfDay(hour: 12, minute: 30);
      expect(time.total.inMinutes, Duration(minutes: 30).inMinutes);
    });

    test('same time', () async {
      final time = Time();

      time.start = TimeOfDay(hour: 12, minute: 0);
      time.end = TimeOfDay(hour: 12, minute: 0);
      expect(time.total.inMinutes, Duration(minutes: 0).inMinutes);
    });
  });

  test("validation", () async {
    final time = Time();

    expect(time.valid, false);

    time.start = TimeOfDay(hour: 12, minute: 0);
    time.end = TimeOfDay(hour: 12, minute: 0);

    expect(time.valid, true);
  });

  test("Stringable", () async {
    final time = Time();

    time.description = "foo";
    time.date = DateTime(1981, 5, 25);
    time.start = TimeOfDay(hour: 12, minute: 0);
    time.end = TimeOfDay(hour: 13, minute: 0);

    expect(time.toString(), "foo: 1981-05-25 00:00:00.000 1:00:00.000000");
  });

  group('JSON serializable', () {
    test("normal", () async {
      final time = Time();

      time.description = 'foo';
      time.date = DateTime(1981, 5, 25);
      time.start = TimeOfDay(hour: 12, minute: 0);
      time.end = TimeOfDay(hour: 14, minute: 0);

      expect(time.toJson(),
          '{"description":"foo","start":"1981-05-25T12:00","end":"1981-05-25T14:00","pause":0,"date":"1981-05-25T00:00:00.000"}');

      final newTime = Time.fromString(time.toJson());
      expect(time.toJson(), newTime.toJson());
    });

    test("day overlapping", () async {
      final time = Time();

      time.description = 'foo';
      time.date = DateTime(1981, 5, 25);
      time.start = TimeOfDay(hour: 23, minute: 0);
      time.end = TimeOfDay(hour: 1, minute: 0);

      expect(time.toJson(),
          '{"description":"foo","start":"1981-05-25T23:00","end":"1981-05-26T01:00","pause":0,"date":"1981-05-25T00:00:00.000"}');

      final newTime = Time.fromString(time.toJson());
      expect(time.toJson(), newTime.toJson());
    });
  });
}
