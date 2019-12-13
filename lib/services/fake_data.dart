import 'dart:math';

import 'package:flutter/material.dart';
import 'package:timesheet_flutter/model/clients.dart';
import 'package:timesheet_flutter/model/timesheet.dart';

import '../model/client.dart';
import '../model/time.dart';

Clients fakeData() {
  Clients clients = Clients();

  clients.addClient(generateClient('foo'));
  clients.addClient(generateClient('bar'));

  return clients;
}

Client generateClient(String name) {
  Client c = Client(name);
  c.addSheet(generateTimesheet());
  c.addSheet(generateTimesheet());
  c.addSheet(generateTimesheet());

  return c;
}

Timesheet generateTimesheet() {
  Timesheet t = Timesheet();
  t.archived = Random().nextBool();

  t.editableTime = generateTime();
  t.addTime();
  t.editableTime = generateTime();
  t.addTime();
  t.editableTime = generateTime();
  t.addTime();
  t.editableTime = generateTime();
  t.addTime();
  t.editableTime = generateTime();
  t.addTime();

  return t;
}

Time generateTime() {
  try {
    int addedMinutes = Random().nextInt(240);
    int pauseMinutes = Random().nextInt(addedMinutes - 1);

    Time t = Time();
    t.description = "someting ${t.hashCode}";
    t.date = DateTime.now().subtract(
        Duration(days: Random().nextInt(Random().nextBool() ? 30 : 5)));
    t.pause = Duration(minutes: pauseMinutes);
    t.start = TimeOfDay.fromDateTime(
        t.date.subtract(Duration(minutes: addedMinutes)));
    t.end = TimeOfDay.fromDateTime(t.date.add(Duration(minutes: addedMinutes)));

    return t;
  } catch (e) {
    return generateTime();
  }
}
