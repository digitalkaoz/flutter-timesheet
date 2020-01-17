import 'dart:math';

import 'package:flutter/material.dart';
import 'package:mockito/mockito.dart';
import 'package:timesheet_flutter/model/client.dart';
import 'package:timesheet_flutter/model/persistence/null_storage.dart';
import 'package:timesheet_flutter/model/time.dart';
import 'package:timesheet_flutter/model/timesheet.dart';

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

  Timesheet emptySheet() {
    return Timesheet(this, "1337");
  }

  Timesheet sheet() {
    final sheet = Timesheet(this, "1337");
    sheet.times.add(robertTime());
    sheet.times.add(silkeTime());

    return sheet;
  }

  Client emptyClient() {
    return Client(this, "4711");
  }

  Client client() {
    final client = Client(this, "4711");
    client.addSheet(sheet());

    return client;
  }
}

MockStorage storage() {
  return new MockStorage();
}
