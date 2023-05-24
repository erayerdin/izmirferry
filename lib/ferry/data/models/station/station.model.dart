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
        return 'assets/locations/konak.jpg';
      case 2:
        return 'assets/locations/karsiyaka.jpg';
      case 3:
        return 'assets/locations/bostanli.jpg';
      case 4:
        return 'assets/locations/pasaport.jpg';
      case 5:
        return 'assets/locations/alsancak.jpg';
      case 6:
        return 'assets/locations/goztepe.jpg';
      case 7:
        return 'assets/locations/uckuyular.jpg';
      case 1019:
        return 'assets/locations/karantina.jpg';
    }
    return null;
  }
}
