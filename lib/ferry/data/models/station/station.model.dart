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

  String? get backgroundAssetPath {
    switch (id) {
      case 1:
        return 'assets/locations/konak.png';
      case 2:
        return 'assets/locations/karsiyaka.png';
      case 3:
        return 'assets/locations/bostanli.png';
      case 4:
        return 'assets/locations/pasaport.png';
      case 5:
        return 'assets/locations/alsancak.png';
      case 6:
        return 'assets/locations/goztepe.png';
      case 7:
        return 'assets/locations/uckuyular.png';
      case 1019:
        return 'assets/locations/karantina.png';
    }
    return null;
  }
}
