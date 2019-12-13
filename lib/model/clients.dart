import 'package:mobx/mobx.dart';
import 'package:timesheet_flutter/model/client.dart';

part 'clients.g.dart';

class Clients = ClientsBase with _$Clients;

abstract class ClientsBase with Store {
  @observable
  ObservableList<Client> clients = ObservableList<Client>();

  @observable
  int currentIndex = 0;

  @computed
  bool get hasClients {
    return clients.isNotEmpty;
  }

  @computed
  Client get current {
    if (clients.isEmpty) {
      return null;
    }

    return clients.elementAt(currentIndex);
  }

  @computed
  String get currentTitle {
    if (current == null) {
      return 'Timesheet';
    }

    return current.name;
  }

  @action
  void setCurrent(int index) {
    currentIndex = index;
  }

  @action
  void addClient(Client client) {
    clients.add(client);
  }

  @action
  void removeClient(Client client) {
    clients.remove(client);
    if (currentIndex != 0) {
      currentIndex = currentIndex - 1;
    }
  }

  String validateName(String value) {
    if (value.isEmpty) {
      return 'Client name cant be blank';
    }

    if (clients.isEmpty) {
      return null;
    }

    final Client client = clients.firstWhere(
        (Client client) => client.name == value,
        orElse: () => null);

    if (client != null) {
      return 'Client names must be unique';
    }

    return null;
  }
}
