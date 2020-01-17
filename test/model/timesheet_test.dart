import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:timesheet_flutter/model/time.dart';
import 'package:timesheet_flutter/model/timesheet.dart';

import '../test_storage.dart';

void main() {
  test('create', () async {
    expect(Timesheet.generate(storage()).runtimeType, Timesheet);
  });

  test('Stringable', () async {
    final sheet = storage().sheet();

    expect(sheet.toString(),
        "1981-05-25T00:00:00.000 1979-06-26T00:00:00.000 3:00:00.000000");
  });

  group('total time', () {
    test('without times', () async {
      final sheet = storage().emptySheet();

      expect(sheet.total, Duration(hours: 0));
    });

    test('with times', () async {
      final sheet = storage().sheet();

      expect(sheet.total, Duration(hours: 3));
    });
  });

  group('time range', () {
    test('without times', () async {
      final sheet = storage().emptySheet();

      expect(sheet.start, null);
      expect(sheet.last, null);
    });

    test('newest date', () async {
      final sheet = storage().sheet();

      expect(sheet.start, DateTime(1981, 5, 25));
    });

    test('oldest date', () async {
      final sheet = storage().sheet();

      expect(sheet.last, DateTime(1979, 6, 26));
    });
  });

  test('archiving', () async {
    final sheet = storage().sheet();

    expect(sheet.archived, false);

    sheet.archive();

    expect(sheet.archived, true);
  });

  group('adding/removing times', () {
    test('add time', () async {
      final sheet = storage().emptySheet();

      expect(sheet.total, Duration());

      sheet.editableTime = storage().robertTime();

      sheet.saveTime();

      expect(sheet.start, DateTime(1981, 5, 25));
      expect(sheet.last, DateTime(1981, 5, 25));
      expect(sheet.total, Duration(minutes: 90));

      expect(sheet.isNewtime, true);

      sheet.archive();

      try {
        sheet.saveTime();
        fail("saving times should have failed");
      } catch (e) {}
    });

    test('remove time', () async {
      final sheet = storage().sheet();

      sheet.removeTime(sheet.times.first);

      expect(sheet.start, DateTime(1979, 6, 26));
      expect(sheet.last, DateTime(1979, 6, 26));
      expect(sheet.total, Duration(minutes: 90));

      sheet.archive();

      try {
        sheet.removeTime(sheet.times.first);
        fail("removing times should have failed");
      } catch (e) {}
    });

    test('remove unknown time', () async {
      final sheet = storage().sheet();

      expect(sheet.total, Duration(hours: 3));

      sheet.removeTime(storage().randomTime());

      expect(sheet.total, Duration(hours: 3));
    });

    test('remove when times is empty', () async {
      final sheet = storage().emptySheet();

      expect(sheet.total, Duration());

      final time = Time();
      time.date = DateTime(1979, 6, 26);
      time.start = TimeOfDay(hour: 12, minute: 0);
      time.end = TimeOfDay(hour: 13, minute: 30);

      sheet.removeTime(storage().randomTime());

      expect(sheet.total, Duration());
    });

    test('newTime', () async {
      final sheet = storage().sheet();
      expect(sheet.total, Duration(hours: 3));

      expect(sheet.isNewtime, true);

      sheet.setCurrentTime(sheet.times.first);
      expect(sheet.isNewtime, false);

      sheet.saveTime();
      expect(sheet.isNewtime, true);
      expect(sheet.total, Duration(hours: 3));

      sheet.archive();

      try {
        sheet.setCurrentTime(sheet.times.first);
        fail("editing times should have failed");
      } catch (e) {}
    });
  });

  group('JSON serializable', () {
    test("empty", () async {
      final sheet = storage().emptySheet();

      expect(sheet.toJson(), '{"id":"1337","archived":false,"times":[]}');
    });

    test("archived", () async {
      final sheet = storage().emptySheet();
      sheet.archive();

      expect(sheet.toJson(), '{"id":"1337","archived":true,"times":[]}');

      final newSheet = Timesheet.fromString(storage(), sheet.toJson());
      expect(newSheet.archived, true);
    });

    test("normal", () async {
      final sheet = storage().sheet();

      expect(sheet.toJson(),
          '{"id":"1337","archived":false,"times":[{"description":"","start":"1981-05-25T12:00","end":"1981-05-25T13:30","pause":0,"date":"1981-05-25T00:00:00.000"},{"description":"","start":"1979-06-26T12:00","end":"1979-06-26T13:30","pause":0,"date":"1979-06-26T00:00:00.000"}]}');

      final newSheet = Timesheet.fromString(storage(), sheet.toJson());
      expect(sheet.toJson(), newSheet.toJson());
    });
  });
}
