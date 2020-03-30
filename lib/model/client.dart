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

    return Client.fromMap(storage, data['id'], data);
  }

  factory Client.fromMap(
      Storage storage, String id, Map<String, dynamic> data) {
    final c = Client(storage, id);
    c.name = data['name'];
    (data["sheets"].cast<String>() ?? []).forEach((String id) {
      final sheet = storage.loadTimesheet(id);
      if (sheet != null) {
        c.timesheets.add(sheet);
      } else {
        c.timesheets.add(Timesheet(storage, id));
      }
    });

    c._sortSheets();

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
    return timesheets.firstWhere((t) => !t.archived, orElse: () {
      final t = Timesheet.generate(storage);
      addSheet(t);
      return t;
    });
  }

  bool get hasTimesheets {
    return timesheets.isNotEmpty;
  }

  @action
  Future<dynamic> addSheet(Timesheet timesheet) async {
    timesheets.add(timesheet);
    _sortSheets();

    await storage.saveClient(this);
    await storage.saveTimesheet(timesheet);
  }

  @action
  Future<bool> setName(String newName) {
    name = newName;

    return storage.saveClient(this);
  }

  @action
  finishSheet(Timesheet timesheet) async {
    final sheet = timesheets.firstWhere((t) => t.id == timesheet.id);

    if (sheet != null) {
      await sheet.archive();
      final ts = Timesheet.generate(storage);
      addSheet(ts);
      _sortSheets();
    }
  }

  @override
  String toString() {
    return "$name";
  }

  _sortSheets() {
    timesheets.sort((Timesheet a, Timesheet b) {
      if (a.last != null && b.last != null) {
        return a.last.compareTo(b.last);
      }

      return 0;
    });
    timesheets.sort((Timesheet a, Timesheet b) {
      if (a.last != null) {
        return a.archived == false ? -1 : 1;
      }

      return 0;
    });
  }

  String toJson() {
    return jsonEncode(toMap());
  }

  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "name": name,
      "sheets": timesheets.map((t) => t.id).toList(),
    };
  }
}
