// Copyright (c) 2023 Eray Erdin
//
// This Source Code Form is subject to the terms of the Mozilla Public
// License, v. 2.0. If a copy of the MPL was not distributed with this
// file, You can obtain one at http://mozilla.org/MPL/2.0/.

import 'dart:convert';

import 'package:izmirferry/favorite/data/converters/favorite.converters.dart';
import 'package:izmirferry/shared/constants.dart';
import 'package:izmirferry/shared/logger.dart';
import 'package:sqflite/sqflite.dart';
import 'package:tuple/tuple.dart';

typedef _Entries = Iterable<Tuple5<int, int, int, int?, DateTime>>;

abstract class FavoriteProvider with DataLoggy {
  Future<int> add({
    required int startStationId,
    required int endStationId,
    int? dayId,
  });

  /// returns id if present
  Future<int?> check({
    required int startStationId,
    required int endStationId,
    required int? dayId,
  });

  /// Args in order: id, start station id, end station id, day id (nullable), last updated
  Future<_Entries> list();

  Future<void> delete(int id);
}

class SqliteFavoriteProvider extends FavoriteProvider {
  SqliteFavoriteProvider({
    required Database database,
    required Converter<SqliteRow, FavoriteEntry> rowToTupleConverter,
  }) {
    _database = database;
    _rowToTupleConverter = rowToTupleConverter;
  }

  late Database _database;
  late Converter<SqliteRow, FavoriteEntry> _rowToTupleConverter;

  @override
  Future<int> add({
    required int startStationId,
    required int endStationId,
    int? dayId,
  }) async {
    loggy.debug('Adding to favorite...');
    loggy.trace('start station id: $startStationId');
    loggy.trace('end station id: $endStationId');
    loggy.trace('day id: $dayId');

    return await _database.insert('favorites', {
      'startStationId': startStationId,
      'endStationId': endStationId,
      'dayId': dayId,
      'lastUpdate': DateTime.now().toIso8601String(),
    });
  }

  @override
  Future<int?> check({
    required int startStationId,
    required int endStationId,
    required int? dayId,
  }) async {
    loggy.debug('Checking favorite...');
    loggy.trace('start station id: $startStationId');
    loggy.trace('end station id: $endStationId');
    loggy.trace('day id: $dayId');

    final rows = await _database.query(
      'favorites',
      where: 'startSessionId = ?, endStationId = ?, dayId = ?',
      whereArgs: [startStationId, endStationId, dayId],
    );

    if (rows.length > 1) {
      loggy.warning('Favorite check has returned more than two items.');
    }

    final row = rows.firstOrNull;
    return row?['id'] as int?;
  }

  @override
  Future<void> delete(int id) async {
    loggy.debug('Deleting favorite...');
    loggy.trace('id: $id');

    await _database.delete('favorites', where: 'id = ?', whereArgs: [id]);
  }

  @override
  Future<_Entries> list() async {
    loggy.debug('Listing all favorites...');

    final data = await _database.query('favorites');
    return data.map(_rowToTupleConverter.convert);
  }
}
