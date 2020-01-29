import 'dart:convert';

import 'package:mobx/mobx.dart';
import 'package:timesheet_flutter/model/persistence/local_storage.dart';
import 'package:timesheet_flutter/model/timesheet.dart';
import 'package:uuid/uuid.dart';

part 'client.g.dart';

class Client extends ClientBase with _$Client {
  Client(storage, id) : super(storage, id);

  factory Client.fromString(Storage storage, String serialized) {
    final data = jsonDecode(serialized);

    final c = Client(storage, data['id']);
    c.name = data['name'];
    (data["sheets"].cast<String>() ?? []).forEach((String id) {
      final sheet = storage.loadTimesheet(id);
      if (sheet != null) {
        c.timesheets.add(sheet);
      } else {
        c.timesheets.add(Timesheet(storage, id));
      }
    });

    return c;
  }

  factory Client.generate(Storage storage) {
    final c = Client(storage, Uuid().v4());
    c.addSheet(Timesheet.generate(storage));

    return c;
  }
}

abstract class ClientBase with Store {
  final Storage storage;
  final String id;

  ClientBase(this.storage, this.id);

  @observable
  String name = '';

  @observable
  ObservableList<Timesheet> timesheets = ObservableList<Timesheet>();

  @computed
  Timesheet get currentTimesheet {
    return timesheets.firstWhere((t) => !t.archived);
  }

  bool get hasTimesheets {
    return timesheets.isNotEmpty;
  }

  @action
  void addSheet(Timesheet timesheet) {
    timesheets.add(timesheet);
    timesheets.sort((Timesheet a, Timesheet b) {
      if (a.last != null && b.last != null) {
        return a.last.compareTo(b.last);
      }

      return 0;
    });

    autorun((_) async {
      await storage.saveClient(this);
      await storage.saveTimesheet(timesheet);
    });
  }

  @action
  setName(String newName) {
    name = newName;

    autorun((_) async {
      await storage.saveClient(this);
    });
  }

  @action
  void finishSheet(Timesheet timesheet) {
    final sheet = timesheets.firstWhere((t) => t.id == timesheet.id);

    if (sheet != null) {
      timesheets.insert(0, Timesheet.generate(storage));
      sheet.archive();
    }
  }

  @override
  String toString() {
    return "$name";
  }

  String toJson() {
    return jsonEncode(
      {
        "id": id,
        "name": name,
        "sheets": timesheets.map((t) => t.id).toList(),
      },
    );
  }
}
