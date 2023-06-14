// Copyright (c) 2023 Eray Erdin
//
// This Source Code Form is subject to the terms of the Mozilla Public
// License, v. 2.0. If a copy of the MPL was not distributed with this
// file, You can obtain one at http://mozilla.org/MPL/2.0/.

import 'dart:convert';

import 'package:izmirferry/favorite/data/models/favorite/favorite.model.dart';
import 'package:izmirferry/favorite/data/providers/favorite/favorite.provider.dart';
import 'package:izmirferry/ferry/data/models/station/station.model.dart';
import 'package:izmirferry/shared/constants.dart';
import 'package:izmirferry/shared/logger.dart';

abstract class FavoriteRepository with DataLoggy {
  Future<int> add({
    required Station startStation,
    required Station endStation,
    Day? day,
  });

  /// returns id if present
  Future<int?> check({
    required Station startStation,
    required Station endStation,
    Day? day,
  });

  Future<Iterable<Favorite>> list();

  Future<void> delete(Favorite favorite);
}

class SqliteFavoriteRepository extends FavoriteRepository {
  SqliteFavoriteRepository({
    required FavoriteProvider favoriteProvider,
    required Converter<Map<String, dynamic>, Favorite> rowToInstanceConverter,
  }) {
    _favoriteProvider = favoriteProvider;
    _rowToInstanceConverter = rowToInstanceConverter;
  }

  late FavoriteProvider _favoriteProvider;
  late Converter<Map<String, dynamic>, Favorite> _rowToInstanceConverter;

  @override
  Future<int> add({
    required Station startStation,
    required Station endStation,
    Day? day,
  }) async {
    loggy.debug('Adding favorite...');
    loggy.trace('start station: $startStation');
    loggy.trace('end station: $endStation');
    loggy.trace('day: $day');

    return await _favoriteProvider.add(
      startStationId: startStation.id,
      endStationId: endStation.id,
      dayId: day?.id,
    );
  }

  @override
  Future<int?> check({
    required Station startStation,
    required Station endStation,
    Day? day,
  }) async {
    loggy.debug('Checking favorite...');
    loggy.trace('start station: $startStation');
    loggy.trace('end station: $endStation');
    loggy.trace('day: $day');

    return await _favoriteProvider.check(
      startStationId: startStation.id,
      endStationId: endStation.id,
      dayId: day?.id,
    );
  }

  @override
  Future<void> delete(Favorite favorite) async {
    loggy.debug('Deleting favorite...');
    loggy.trace('favorite: $favorite');

    await _favoriteProvider.delete(favorite.id);
  }

  @override
  Future<Iterable<Favorite>> list() async {
    loggy.debug('Listing all favorites...');

    final entries = await _favoriteProvider.list();
    return entries.map(_rowToInstanceConverter.convert);
  }
}
