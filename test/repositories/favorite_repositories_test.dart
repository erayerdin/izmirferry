// Copyright (c) 2023 Eray Erdin
//
// This Source Code Form is subject to the terms of the Mozilla Public
// License, v. 2.0. If a copy of the MPL was not distributed with this
// file, You can obtain one at http://mozilla.org/MPL/2.0/.

import 'package:clock/clock.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:izmirferry/favorite/data/converters/favorite.converters.dart';
import 'package:izmirferry/favorite/data/models/favorite/favorite.model.dart';
import 'package:izmirferry/favorite/data/providers/favorite/favorite.provider.dart';
import 'package:izmirferry/favorite/data/repository/favorite/favorite.repository.dart';
import 'package:izmirferry/ferry/constants.dart';
import 'package:izmirferry/shared/constants.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

@GenerateNiceMocks([MockSpec<FavoriteProvider>()])
import 'favorite_repositories_test.mocks.dart';

void main() {
  group('sqlite', () {
    late FavoriteProvider mockProvider;
    late FavoriteRepository repository;
    late Favorite favorite;

    setUpAll(() {
      mockProvider = MockFavoriteProvider();
      repository = SqliteFavoriteRepository(
        favoriteProvider: mockProvider,
        rowToInstanceConverter: FavoriteRowToInstanceConverter(),
      );

      favorite = withClock(
        Clock.fixed(DateTime(2023)),
        () => Favorite(
          id: 1,
          startStation: allStation.firstWhere((s) => s.id == 1),
          endStation: allStation.firstWhere((s) => s.id == 1),
          day: Day.monday,
          lastUpdate: clock.now(),
        ),
      );
    });

    test('-- add', () async {
      await repository.add(favorite);
      verify(
        mockProvider.add(
          startStationId: favorite.startStation.id,
          endStationId: favorite.endStation.id,
          dayId: favorite.day?.id,
        ),
      );
    });

    test('-- delete', () async {
      await repository.delete(favorite);
      verify(mockProvider.delete(favorite.id));
    });

    test('list', () async {
      when(mockProvider.list()).thenAnswer(
        (realInvocation) async => [
          {
            'id': 1,
            'startStationId': 1,
            'endStationId': 2,
            'dayId': null,
            'lastUpdate': DateTime(2023).toIso8601String(),
          },
          {
            'id': 2,
            'startStationId': 2,
            'endStationId': 1,
            'dayId': Day.wednesday.id,
            'lastUpdate': DateTime(2023).toIso8601String(),
          },
        ],
      );

      final favorites = (await repository.list()).toList(growable: false);
      final firstFave = favorites[0];
      final secondFave = favorites[1];

      expect(favorites.length, 2);

      expect(firstFave.id, 1);
      expect(firstFave.startStation.id, 1);
      expect(firstFave.endStation.id, 2);
      expect(firstFave.day, null);
      expect(firstFave.lastUpdate, DateTime(2023));

      expect(secondFave.id, 2);
      expect(secondFave.startStation.id, 2);
      expect(secondFave.endStation.id, 1);
      expect(secondFave.day, Day.wednesday);
      expect(secondFave.lastUpdate, DateTime(2023));
    });
  });
}
