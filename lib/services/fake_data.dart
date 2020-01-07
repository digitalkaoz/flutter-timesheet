import 'dart:math';

import 'package:flutter/material.dart';
import 'package:timesheet_flutter/model/clients.dart';
import 'package:timesheet_flutter/model/local_storage.dart';
import 'package:timesheet_flutter/model/timesheet.dart';

import '../model/client.dart';
import '../model/time.dart';

Clients fakeData(Storage storage) {
  Clients clients = Clients(storage);

  clients.addClient(generateClient(storage, 'foo'));
  clients.addClient(generateClient(storage, 'bar'));

  return clients;
}

Client generateClient(Storage storage, String name) {
  Client c = Client(storage, name);
  c.addSheet(generateTimesheet(storage));
  c.addSheet(generateTimesheet(storage));
  c.addSheet(generateTimesheet(storage));
  c.addSheet(generateTimesheet(storage));
  c.addSheet(generateTimesheet(storage));
  c.addSheet(generateTimesheet(storage));

  return c;
}

Timesheet generateTimesheet(Storage storage) {
  Timesheet t = Timesheet(storage);
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
