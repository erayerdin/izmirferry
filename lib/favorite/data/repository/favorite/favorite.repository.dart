// Copyright (c) 2023 Eray Erdin
//
// This Source Code Form is subject to the terms of the Mozilla Public
// License, v. 2.0. If a copy of the MPL was not distributed with this
// file, You can obtain one at http://mozilla.org/MPL/2.0/.

import 'dart:convert';

import 'package:izmirferry/favorite/data/models/favorite/favorite.model.dart';
import 'package:izmirferry/favorite/data/providers/favorite/favorite.provider.dart';
import 'package:izmirferry/shared/constants.dart';
import 'package:izmirferry/shared/logger.dart';

abstract class FavoriteRepository with DataLoggy {
  Future<int> add(Favorite favorite);

  // TODO add check method to check if a favorite entry exists

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
  Future<int> add(Favorite favorite) async {
    loggy.debug('Adding favorite...');
    loggy.trace('favorite: $favorite');

    return await _favoriteProvider.add(
      startStationId: favorite.startStation.id,
      endStationId: favorite.endStation.id,
      dayId: favorite.day?.id,
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
