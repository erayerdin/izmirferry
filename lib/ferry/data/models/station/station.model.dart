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

  String? get locationUrl {
    switch (id) {
      case 1:
        return 'https://goo.gl/maps/mdiAdiEkNoT33Zx46';
      case 2:
        return 'https://goo.gl/maps/Z24JfQgws3YvwQ4T7';
      case 3:
        return 'https://goo.gl/maps/PRN8xW7JxWcASFX9A';
      case 4:
        return 'https://goo.gl/maps/9sf3fs5gzH4JRu5V9';
      case 5:
        return 'https://goo.gl/maps/vCGu1vJJT4j3pkxHA';
      case 6:
        return 'https://goo.gl/maps/iBCM5TQBs6MQ65UT6';
      case 7:
        return 'https://goo.gl/maps/onzkRid8vTFGR4h76';
      case 1019:
        return 'https://goo.gl/maps/itfWaWUAhU1FXEY79';
    }
    return null;
  }
}
