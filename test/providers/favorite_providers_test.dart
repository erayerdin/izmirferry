// Copyright (c) 2023 Eray Erdin
//
// This Source Code Form is subject to the terms of the Mozilla Public
// License, v. 2.0. If a copy of the MPL was not distributed with this
// file, You can obtain one at http://mozilla.org/MPL/2.0/.

import 'package:clock/clock.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:izmirferry/favorite/data/providers/favorite/favorite.provider.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:sqflite/sqflite.dart';

@GenerateNiceMocks([MockSpec<Database>()])
import 'favorite_providers_test.mocks.dart';

void main() {
  group('sqlite', () {
    late MockDatabase mockDb;
    late SqliteFavoriteProvider provider;

    setUpAll(() {
      mockDb = MockDatabase();
      provider = SqliteFavoriteProvider(database: mockDb);
    });

    test('-- add (without day)', () async {
      await withClock(Clock.fixed(DateTime(2023)), () async {
        // when(mockDb.insert('favorites', any))
        //     .thenAnswer((realInvocation) async => 1);
        await provider.add(startStationId: 1, endStationId: 1);
      });
      verify(
        await mockDb.insert(
          'favorites',
          {
            'startStationId': 1,
            'endStationId': 1,
            'dayId': null,
            'lastUpdate': '2023-01-01T00:00:00.0',
          },
          nullColumnHack: null,
          conflictAlgorithm: null,
        ),
      );
    }, skip: 'See: https://stackoverflow.com/q/76477815/2926992');

    test('-- add (with day)', () async {
      await withClock(Clock.fixed(DateTime(2023)), () async {
        await provider.add(startStationId: 1, endStationId: 1, dayId: 1);
      });
      verify(
        await mockDb.insert(
          'favorites',
          {
            'startStationId': 1,
            'endStationId': 1,
            'dayId': 1,
            'lastUpdate': '2023-01-01T00:00:00.0',
          },
          nullColumnHack: null,
          conflictAlgorithm: null,
        ),
      );
    }, skip: 'See: https://stackoverflow.com/q/76477815/2926992');

    test('-- delete', () async {
      await provider.delete(1);
      verify(mockDb.delete('favorites', where: 'id = ?', whereArgs: [1]));
    });

    test('-- list', () async {
      await provider.list();
      verify(mockDb.query('favorites'));
    });
  });
}
