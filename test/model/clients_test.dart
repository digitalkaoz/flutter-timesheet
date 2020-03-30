import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:timesheet_flutter/model/clients.dart';

import '../test_storage.dart';

void main() {
  test('current client', () async {
    final s = storage();
    final c = Clients(s);
    final client = s.client();

    when(s.saveClient(client)).thenAnswer((_) => Future.value(true));

    expect(c.current, null);
    expect(c.currentIndex, 0);
    expect(c.currentTitle, "Timesheet");

    await c.addClient(client);

    expect(c.current, client);
    expect(c.currentIndex, 0);
    expect(c.currentTitle, client.name);
  });

  test('name validation', () async {
    final c = Clients(storage());
    final client = storage().client();
    client.name = "foo";

    final client2 = storage().client();
    client2.name = "bar";

    expect(c.validateName("foo"), null);

    c.addClient(client);
    c.addClient(client2);

    expect(c.validateName("foo"), 'Client names must be unique');
    expect(c.validateName("lol"), null);
  });

  group('add/remove clients', () {
    test('add', () async {
      final c = Clients(storage());
      final client = storage().client();
      client.name = "bar";

      final client2 = storage().client();
      client2.name = "foo";

      expect(c.hasClients, false);

      c.addClient(client);
      expect(c.hasClients, true);

      c.addClient(client2);
      c.setCurrent(client2);

      expect(c.currentIndex, 1);
      expect(c.current, client2);
    });

    test('remove', () async {
      final s = storage();
      final c = Clients(s);
      final client = s.client();

      client.name = "bar";

      final client2 = s.client();
      client2.name = "foo";

      when(s.deleteClient(client2)).thenAnswer((_) => Future.value(true));

      c.addClient(client);
      c.addClient(client2);
      c.setCurrent(client2);

      expect(c.currentIndex, 1);
      expect(c.current, client2);

      c.removeClient(client2);

      expect(c.currentIndex, 0);
      expect(c.current, client);
    });
  });

  test('load from storage', () async {
    final s = storage();
    final c = Clients(s);
    final client = s.client();
    final client2 = s.client("foobar");

    when(s.load()).thenReturn([client, client2]);
    when(s.getCurrentClient()).thenReturn(client2.id);

    expect(c.hasClients, false);

    c.load();

    expect(c.hasClients, true);
    expect(c.current, client2);
    expect(c.currentIndex, 1);
  });
}
