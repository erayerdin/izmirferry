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

  Future<void> delete(Station station);
}

class SqliteFavoriteRepository extends FavoriteRepository {
  SqliteFavoriteRepository({
    required SqliteFavoriteProvider sqliteFavoriteProvider,
    required Converter<Map<String, dynamic>, Favorite> rowToInstanceConverter,
  }) {
    _sqliteFavoriteProvider = sqliteFavoriteProvider;
    _rowToInstanceConverter = rowToInstanceConverter;
  }

  late FavoriteProvider _sqliteFavoriteProvider;
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

    return await _sqliteFavoriteProvider.add(
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

    return await _sqliteFavoriteProvider.check(
      startStationId: startStation.id,
      endStationId: endStation.id,
      dayId: day?.id,
    );
  }

  @override
  Future<void> delete(Station station) async {
    loggy.debug('Deleting station...');
    loggy.trace('station: $station');

    await _sqliteFavoriteProvider.delete(station.id);
  }

  @override
  Future<Iterable<Favorite>> list() async {
    loggy.debug('Listing all favorites...');

    final entries = await _sqliteFavoriteProvider.list();
    return entries.map(_rowToInstanceConverter.convert);
  }
}
