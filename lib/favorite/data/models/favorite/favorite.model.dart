// Copyright (c) 2023 Eray Erdin
//
// This Source Code Form is subject to the terms of the Mozilla Public
// License, v. 2.0. If a copy of the MPL was not distributed with this
// file, You can obtain one at http://mozilla.org/MPL/2.0/.

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:izmirferry/ferry/data/models/station/station.model.dart';
import 'package:izmirferry/shared/constants.dart';

part 'favorite.model.freezed.dart';

@freezed
class Favorite with _$Favorite {
  const Favorite._();
  const factory Favorite({
    required Station startStation,
    required Station endStation,
    required Day? day,
  }) = _Favorite;
}
