import 'package:timesheet_flutter/model/client.dart';
import 'package:timesheet_flutter/model/persistence/local_storage.dart';
import 'package:timesheet_flutter/model/timesheet.dart';

class NullStorage implements Storage {
  @override
  Future<bool> setCurrentClient(Client client) async {
    return true;
  }

  @override
  String getCurrentClient() {
    return "current";
  }

  @override
  List<Client> load() {
    return [];
  }

  @override
  Future<bool> deleteClient(Client client) async {
    return true;
  }

  @override
  Future<bool> saveClient(Client client) async {
    return true;
  }

  @override
  Future<bool> saveTimesheet(Timesheet sheet) async {
    return true;
  }

  @override
  Timesheet loadTimesheet(String id) {
  	return null;
	}

  @override
  Future<bool> deleteTimesheet(Timesheet sheet) async {
    return true;
  }
}
