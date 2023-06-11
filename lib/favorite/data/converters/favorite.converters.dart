// Copyright (c) 2023 Eray Erdin
//
// This Source Code Form is subject to the terms of the Mozilla Public
// License, v. 2.0. If a copy of the MPL was not distributed with this
// file, You can obtain one at http://mozilla.org/MPL/2.0/.

import 'dart:convert';

import 'package:izmirferry/favorite/data/models/favorite/favorite.model.dart';
import 'package:izmirferry/shared/logger.dart';

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
