// Copyright (c) 2023 Eray Erdin
//
// This Source Code Form is subject to the terms of the Mozilla Public
// License, v. 2.0. If a copy of the MPL was not distributed with this
// file, You can obtain one at http://mozilla.org/MPL/2.0/.

import 'package:freezed_annotation/freezed_annotation.dart';

part 'station.model.freezed.dart';

@freezed
class Station with _$Station {
  const Station._();
  const factory Station({
    required int id,
    required String name,
  }) = _Station;
}
