// Copyright (c) 2023 Eray Erdin
//
// This Source Code Form is subject to the terms of the Mozilla Public
// License, v. 2.0. If a copy of the MPL was not distributed with this
// file, You can obtain one at http://mozilla.org/MPL/2.0/.

import 'dart:convert';

import 'package:izmirferry/favorite/data/models/favorite/favorite.model.dart';
import 'package:izmirferry/ferry/constants.dart';
import 'package:izmirferry/shared/constants.dart';
import 'package:izmirferry/shared/logger.dart';
import 'package:tuple/tuple.dart';

typedef FavoriteEntry = Tuple5<int, int, int, int?, DateTime>;

class FavoriteRowToTupleConverter extends Converter<SqliteRow, FavoriteEntry>
    with DataLoggy {
  @override
  FavoriteEntry convert(SqliteRow input) {
    loggy.debug('Converting row to favorite entry...');
    loggy.trace('row: $input');

    return Tuple5(
      input['id'] as int,
      input['startStationId'] as int,
      input['endStationId'] as int,
      input['dayId'] as int?,
      input['lastUpdated'] as DateTime,
    );
  }
}

class FavoriteEntryToInstanceConverter
    extends Converter<FavoriteEntry, Favorite> with DataLoggy {
  @override
  Favorite convert(FavoriteEntry input) {
    loggy.debug('Converting favorite entry to instance...');
    loggy.trace('entry: $input');

    return Favorite(
      id: input.item1,
      startStation: allStation.firstWhere((s) => s.id == input.item2),
      endStation: allStation.firstWhere((s) => s.id == input.item3),
      day: Day.values.firstWhere((d) => d.id == input.item4),
      lastUpdate: input.item5,
    );
  }
}

class FavoriteRowToInstanceConverter
    extends Converter<Map<String, dynamic>, Favorite> with DataLoggy {
  @override
  Favorite convert(Map<String, dynamic> input) {
    loggy.debug('Converting favorite row to instance...');
    loggy.trace('row: $input');

    return Favorite(
      id: input['id'],
      startStation: input['startStation'],
      endStation: input['endStation'],
      day: input['day'],
      lastUpdate: input['lastUpdate'],
    );
  }
}
