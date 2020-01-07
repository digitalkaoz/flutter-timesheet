import 'package:mobx/mobx.dart';
import 'package:timesheet_flutter/model/client.dart';
import 'package:timesheet_flutter/model/local_storage.dart';

part 'clients.g.dart';

class Clients extends ClientsBase with _$Clients {
  Clients(storage) : super(storage);
}

abstract class ClientsBase with Store {
  final Storage storage;

  ClientsBase(this.storage);

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
  Future<void> load() async {
    clients = ObservableList.of(await storage.load());
  }

  @action
  void setCurrent(Client client) {
    currentIndex = clients.indexOf(client);

    autorun((_) async {
      await storage.setCurrentClient(client);
    });
  }

  @action
  void addClient(Client client) {
    clients.add(client);

    autorun((_) async {
      await storage.addClient(client);
    });
  }

  @action
  void removeClient(Client client) {
    clients.remove(client);
    if (currentIndex != 0) {
      currentIndex = currentIndex - 1;
    }

    autorun((_) async {
      await storage.deleteClient(client);
    });
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
