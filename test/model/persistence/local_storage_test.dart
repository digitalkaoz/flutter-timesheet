import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:timesheet_flutter/model/client.dart';
import 'package:timesheet_flutter/model/persistence/local_storage.dart';

import '../../test_storage.dart';

void main() {
  group('current client', () {
    test("persist", () async {
      final p = MockPrefs();
      final s = LocalStorage(p);
      final c = storage().client();

      when(p.setString('current', c.id)).thenAnswer((_) => Future.value(true));
      final result = await s.setCurrentClient(c);

      verify(p.setString("current", c.id)).called(1);
      expect(result, true);
    });

    test("load", () async {
      final p = MockPrefs();
      final s = LocalStorage(p);
      final c = storage().client();

      when(p.getString('current')).thenReturn(c.id);
      final result = s.getCurrentClient();

      verify(p.getString("current")).called(1);
      expect(result, c.id);
    });
  });

  group('clients', () {
    test('save first client', () async {
      final p = MockPrefs();
      final s = LocalStorage(p);
      final c = storage().client();

      await s.saveClient(c);

      verify(p.setStringList('clients', [c.toJson()]));
    });

    test('save', () async {
      final p = MockPrefs();
      final s = LocalStorage(p);
      final c = storage().client();
      final c2 = storage().client("foo");

      when(p.getStringList('clients')).thenReturn([c.toJson()]);

      await s.saveClient(c2);

      verify(p.setStringList('clients', [c.toJson(), c2.toJson()]));
    });

    test('remove on empty list', () async {
      final p = MockPrefs();
      final s = LocalStorage(p);
      final c = storage().emptyClient();

      when(p.getStringList('clients')).thenReturn([]);
      await s.deleteClient(c);

      verify(p.setStringList('clients', []));
    });

    test('remove', () async {
      final p = MockPrefs();
      final s = LocalStorage(p);
      final c = storage().emptyClient();

      when(p.getStringList('clients')).thenReturn([c.toJson()]);

      await s.deleteClient(c);

      verify(p.setStringList('clients', []));
    });

    test('remove unknown', () async {
      final p = MockPrefs();
      final s = LocalStorage(p);
      final c = storage().emptyClient();
      final c2 = Client.generate(s);

      when(p.remove('timesheet_${c2.timesheets.first.id}'))
          .thenAnswer((_) => Future.value(true));
      when(p.getStringList('clients')).thenReturn([c.toJson()]);

      await s.deleteClient(c2);

      verify(p.setStringList('clients', [c.toJson()]));
    });
  });

  group('timesheets', () {
    test('save', () async {
      final p = MockPrefs();
      final s = LocalStorage(p);
      final sheet = storage().sheet();

      await s.saveTimesheet(sheet);

      verify(p.setString('timesheet_${sheet.id}', sheet.toJson()));
    });

    test('load unknown', () async {
      final p = MockPrefs();
      final s = LocalStorage(p);

      final newSheet = s.loadTimesheet("lolcat");

      expect(newSheet, null);
    });

    test('load', () async {
      final p = MockPrefs();
      final s = LocalStorage(p);
      final sheet = storage().sheet();

      when(p.getString('timesheet_${sheet.id}')).thenReturn(sheet.toJson());

      final newSheet = s.loadTimesheet(sheet.id);

      expect(newSheet.toJson(), sheet.toJson());
    });
  });

  group('load', () {
    test('empty', () async {
      final p = MockPrefs();
      final s = LocalStorage(p);

      final result = s.load();

      expect(result, []);
    });

    test('normal', () async {
      final p = MockPrefs();
      final s = LocalStorage(p);
      final c = storage().client();

      when(p.getStringList('clients')).thenReturn([c.toJson()]);

      final result = s.load();

      expect(result.length, 1);
      expect(result.first.toJson(), c.toJson());
    });
  });
}
