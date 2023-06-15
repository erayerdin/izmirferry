// Copyright (c) 2023 Eray Erdin
//
// This Source Code Form is subject to the terms of the Mozilla Public
// License, v. 2.0. If a copy of the MPL was not distributed with this
// file, You can obtain one at http://mozilla.org/MPL/2.0/.

import 'dart:convert';
import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:izmirferry/ferry/data/converters/station/station.converter.dart';
import 'package:izmirferry/ferry/data/models/station/station.model.dart';

void main() {
  test('izdeniz', () async {
    final rawData = await File('assets/test/end_stations.json').readAsString();
    final List data = json.decode(rawData);
    final Map<String, dynamic> datum = data.first;

    final Converter<Map<String, dynamic>, Station> converter =
        IzdenizStationConverter();
    final station = converter.convert(datum);

    expect(station.id, 2);
    expect(station.name, 'Karşıyaka');
  });
}
