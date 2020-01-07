import 'dart:convert';

import 'package:mobx/mobx.dart';
import 'package:timesheet_flutter/model/local_storage.dart';
import 'package:timesheet_flutter/model/timesheet.dart';

part 'client.g.dart';

class Client extends ClientBase with _$Client {
  Client(storage, name) : super(storage, name);

  static Client fromString(Storage storage, String serialized) {
    final data = jsonDecode(serialized);

    return Client(storage, data['name']);
  }
}

abstract class ClientBase with Store {
  final Storage storage;

  ClientBase(this.storage, this.name);

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
    });
  }

  @action
  setName(String newName) {
    String oldName = name;
    name = newName;

    autorun((_) async {
      await storage.saveClient(this, oldName);
    });
  }

  @action
  void finishSheet(Timesheet timesheet) {
    timesheets.insert(0, Timesheet(storage));
    timesheet.archive();

    autorun((_) async {
      await storage.saveTimesheet(timesheets.elementAt(0));
    });
  }

  String toString() {
    return jsonEncode(
      {
        "name": name,
      },
    );
  }
}
