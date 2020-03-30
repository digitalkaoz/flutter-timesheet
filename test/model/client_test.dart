import 'package:flutter_test/flutter_test.dart';
import 'package:timesheet_flutter/model/client.dart';

import '../test_storage.dart';

void main() {
  test('create', () async {
    expect(storage().client().runtimeType, Client);
  });

  test('Stringable', () async {
    final client = storage().client();
    client.setName("foo");

    expect(client.toString(), "foo");
  });

  group('sheets', () {
    test('add', () async {
      final sheet = storage().sheet();
      final client = storage().emptyClient();
      expect(client.hasTimesheets, false);

      client.addSheet(sheet);
      expect(client.hasTimesheets, true);
      expect(client.currentTimesheet, client.timesheets.first);
    });

    test('finish', () async {
      final client = storage().client();
      final sheet = client.timesheets.first;

      await client.finishSheet(sheet);

      expect(sheet.archived, true);
      expect(client.timesheets.first != sheet, true);
      expect(client.timesheets.first.archived, false);
    });
  });

  group("JSON serializable", () {
    test('empty', () async {
      final client = storage().emptyClient();

      expect(client.toJson(), '{"id":"4711","name":"","sheets":[]}');
    });

    test('normal', () async {
      final client = storage().client();
      final sheet = client.timesheets.first;

      expect(client.toJson(), '{"id":"4711","name":"","sheets":["1337"]}');

      final newClient = Client.fromString(storage(), client.toJson());

      expect(newClient.timesheets.first.id, sheet.id);
      expect(client.toJson(), newClient.toJson());
    });
  });
}
