// Copyright (c) 2023 Eray Erdin
//
// This Source Code Form is subject to the terms of the Mozilla Public
// License, v. 2.0. If a copy of the MPL was not distributed with this
// file, You can obtain one at http://mozilla.org/MPL/2.0/.

import 'package:izmirferry/shared/logger.dart';
import 'package:loggy/loggy.dart';
import 'package:sqflite/sqflite.dart';
import 'package:tuple/tuple.dart';

abstract class FavoriteProvider {
  Future<void> add({
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
  Future<Tuple5<int, int, int, int?, DateTime>> list();

  Future<void> delete(int id);
}

class SqliteFavoriteProvider extends FavoriteProvider with DataLoggy {
  SqliteFavoriteProvider._create({required Database database}) {
    _database = database;
  }

  late Database _database;

  static Future<SqliteFavoriteProvider> init(
      {required Database database}) async {
    final loggy = Loggy('SqliteFavoriteProvider.init');
    loggy.debug('Initializing SqliteFavoriteProvider...');

    loggy.debug('Running migrations...');

    loggy.debug('Migration: Creating favorites table...');
    database.execute('''
    CREATE TABLE IF NOT EXISTS favorites (
      id INTEGER PRIMARY KEY,
      startStationId INTEGER NOT NULL,
      endStationId INTEGER NOT NULL,
      dayId INTEGER CHECK(dayId <= 7),
      lastUpdate DATETIME NOT NULL DEFAULT (strftime('%Y-%m-%d %H:%M:%S', 'now', 'utc'))
    );
    ''');

    return SqliteFavoriteProvider._create(database: database);
  }

  @override
  Future<void> add({
    required int startStationId,
    required int endStationId,
    int? dayId,
  }) {
    // TODO: implement add
    throw UnimplementedError();
  }

  @override
  Future<int?> check({
    required int startStationId,
    required int endStationId,
    required int? dayId,
  }) {
    // TODO: implement check
    throw UnimplementedError();
  }

  @override
  Future<void> delete(int id) {
    // TODO: implement delete
    throw UnimplementedError();
  }

  @override
  Future<Tuple5<int, int, int, int?, DateTime>> list() {
    // TODO: implement list
    throw UnimplementedError();
  }
}
