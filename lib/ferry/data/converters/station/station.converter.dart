// Copyright (c) 2023 Eray Erdin
//
// This Source Code Form is subject to the terms of the Mozilla Public
// License, v. 2.0. If a copy of the MPL was not distributed with this
// file, You can obtain one at http://mozilla.org/MPL/2.0/.

import 'dart:convert';

import 'package:izmirferry/ferry/data/models/station/station.model.dart';
import 'package:izmirferry/shared/logger.dart';

class IzdenizStationConverter extends Converter<Map<String, dynamic>, Station>
    with DataLoggy {
  @override
  Station convert(Map<String, dynamic> input) {
    loggy.debug('Converting İzdeniz data to Station...');
    loggy.trace('input: $input');

    return Station(
      id: input['IskeleId'],
      name: input['Adi'],
    );
  }
}
