import 'dart:math';

import 'package:flutter/material.dart';
import 'package:mockito/mockito.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:timesheet_flutter/model/client.dart';
import 'package:timesheet_flutter/model/persistence/null_storage.dart';
import 'package:timesheet_flutter/model/time.dart';
import 'package:timesheet_flutter/model/timesheet.dart';

class MockPrefs extends Mock implements SharedPreferences {}

class MockStorage extends Mock implements NullStorage {
  Time robertTime() {
    final time = Time();
    time.date = DateTime(1981, 5, 25);
    time.start = TimeOfDay(hour: 12, minute: 0);
    time.end = TimeOfDay(hour: 13, minute: 30);

    return time;
  }

  Time silkeTime() {
    final time = Time();
    time.date = DateTime(1979, 6, 26);
    time.start = TimeOfDay(hour: 12, minute: 0);
    time.end = TimeOfDay(hour: 13, minute: 30);

    return time;
  }

  Time randomTime() {
    final time = Time();
    time.date = DateTime(Random().nextInt(2020), 6, 26);
    time.start = TimeOfDay(hour: Random().nextInt(23), minute: 0);
    time.end = TimeOfDay(hour: Random().nextInt(23), minute: 30);

    return time;
  }

  Timesheet emptySheet([String id = "1337"]) {
    return Timesheet(this, id);
  }

  Timesheet sheet([String id = "1337"]) {
    final sheet = Timesheet(this, id);
    sheet.times.add(robertTime());
    sheet.times.add(silkeTime());

    return sheet;
  }

  Client emptyClient([String id = "4711"]) {
    return Client(this, id);
  }

  Client client([String id = "4711"]) {
    final client = Client(this, id);
    client.addSheet(sheet());

    return client;
  }
}

MockStorage storage() {
  return new MockStorage();
}
