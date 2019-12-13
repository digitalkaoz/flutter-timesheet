import 'package:mobx/mobx.dart';
import 'package:timesheet_flutter/model/time.dart';

part 'timesheet.g.dart';

class Timesheet = TimesheetBase with _$Timesheet;

abstract class TimesheetBase with Store {
  @observable
  ObservableList<Time> times = ObservableList<Time>();

  @observable
  bool archived = false;

  @observable
  Time editableTime = Time();

  @computed
  DateTime get start {
    if (times.isEmpty) {
      return null;
    }

    return times.first.date;
  }

  @computed
  DateTime get last {
    if (times.isEmpty) {
      return null;
    }
    return times.last.date;
  }

  @computed
  Duration get total {
    if (times.isEmpty) {
      return null;
    }
    var sum = Duration.zero;

    times.forEach((Time time) {
      sum += time.total;
    });

    return sum;
  }

  @computed
  bool get isNewtime {
    if (times.isEmpty) {
      return true;
    }

    return !times.contains(editableTime);
  }

  @action
  setCurrentTime(Time time) {
    editableTime = time;
  }

  @action
  void addTime() {
    times.add(editableTime);
    times.sort((a, b) => a.date.compareTo(b.date));
    editableTime = Time();
  }
}
