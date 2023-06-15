// Copyright (c) 2023 Eray Erdin
//
// This Source Code Form is subject to the terms of the Mozilla Public
// License, v. 2.0. If a copy of the MPL was not distributed with this
// file, You can obtain one at http://mozilla.org/MPL/2.0/.

import 'package:flutter_test/flutter_test.dart';
import 'package:izmirferry/favorite/data/models/favorite/favorite.model.dart';
import 'package:izmirferry/favorite/data/repository/favorite/favorite.repository.dart';
import 'package:izmirferry/favorite/logic/favorite/favorite_bloc.dart';
import 'package:izmirferry/ferry/constants.dart';
import 'package:izmirferry/shared/constants.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

@GenerateNiceMocks([MockSpec<FavoriteRepository>()])
import 'favorite_bloc_test.mocks.dart';

void main() {
  late FavoriteRepository mockRepo;
  late FavoriteBloc bloc;
  late List<Favorite> favorites;

  setUp(() {
    mockRepo = MockFavoriteRepository();
    bloc = FavoriteBloc(favoriteRepository: mockRepo);

    favorites = [
      Favorite(
        id: 1,
        startStation: allStation.firstWhere((s) => s.id == 1),
        endStation: allStation.firstWhere((s) => s.id == 2),
        day: null,
        lastUpdate: DateTime(2023),
      ),
      Favorite(
        id: 2,
        startStation: allStation.firstWhere((s) => s.id == 2),
        endStation: allStation.firstWhere((s) => s.id == 1),
        day: Day.sunday,
        lastUpdate: DateTime(2023),
      ),
    ];

    when(mockRepo.list()).thenAnswer((realInvocation) async => favorites);
  });

  test('initial state', () {
    expect(bloc.state, const FavoriteState.loading());
  });

  test('list event', () async {
    bloc.add(const FavoriteEvent.list());
    await expectLater(
      bloc.stream,
      emitsInOrder(
        [const FavoriteState.loading(), FavoriteState.listed(favorites)],
      ),
    );
  });

  test('add event', () async {
    bloc.add(FavoriteEvent.add(favorites.first));

    await expectLater(
      bloc.stream,
      emitsInOrder(
        [
          const FavoriteState.loading(),
          const FavoriteState.added(),
          const FavoriteState.loading(),
          FavoriteState.listed(favorites),
        ],
      ),
    );
  });

  test('delete event', () async {
    bloc.add(FavoriteEvent.delete(favorites.first));

    await expectLater(
      bloc.stream,
      emitsInOrder(
        [
          const FavoriteState.loading(),
          const FavoriteState.deleted(),
          const FavoriteState.loading(),
          FavoriteState.listed(favorites),
        ],
      ),
    );
  });
}
