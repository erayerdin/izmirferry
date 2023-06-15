// Copyright (c) 2023 Eray Erdin
//
// This Source Code Form is subject to the terms of the Mozilla Public
// License, v. 2.0. If a copy of the MPL was not distributed with this
// file, You can obtain one at http://mozilla.org/MPL/2.0/.

import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:izmirferry/favorite/data/converters/favorite.converters.dart';
import 'package:izmirferry/favorite/data/models/favorite/favorite.model.dart';
import 'package:izmirferry/shared/constants.dart';

void main() {
  test('row to instance', () {
    final row = {
      'id': 1,
      'startStationId': 1,
      'endStationId': 1,
      'dayId': 1,
      'lastUpdate': DateTime(2023).toIso8601String(),
    };

    final Converter<Map<String, dynamic>, Favorite> converter =
        FavoriteRowToInstanceConverter();
    final favorite = converter.convert(row);

    expect(favorite.id, 1);
    expect(favorite.startStation.id, 1);
    expect(favorite.endStation.id, 1);
    expect(favorite.day, Day.monday);
    expect(favorite.lastUpdate, DateTime(2023));
  });
}
