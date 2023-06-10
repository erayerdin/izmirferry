// Copyright (c) 2023 Eray Erdin
//
// This Source Code Form is subject to the terms of the Mozilla Public
// License, v. 2.0. If a copy of the MPL was not distributed with this
// file, You can obtain one at http://mozilla.org/MPL/2.0/.

import 'dart:convert';

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
