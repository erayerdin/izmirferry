// Copyright (c) 2023 Eray Erdin
//
// This Source Code Form is subject to the terms of the Mozilla Public
// License, v. 2.0. If a copy of the MPL was not distributed with this
// file, You can obtain one at http://mozilla.org/MPL/2.0/.

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
