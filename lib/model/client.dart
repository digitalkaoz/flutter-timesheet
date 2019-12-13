import 'package:mobx/mobx.dart';
import 'package:timesheet_flutter/model/timesheet.dart';

part 'client.g.dart';

class Client = ClientBase with _$Client;

abstract class ClientBase with Store {
  ClientBase(this.name);

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
  }

  @action
  void finishSheet(Timesheet timesheet) {
    timesheets.insert(0, Timesheet());
    timesheet.archived = true;
  }
}
