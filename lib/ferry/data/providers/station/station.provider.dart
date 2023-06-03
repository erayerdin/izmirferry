// Copyright (c) 2023 Eray Erdin
//
// This Source Code Form is subject to the terms of the Mozilla Public
// License, v. 2.0. If a copy of the MPL was not distributed with this
// file, You can obtain one at http://mozilla.org/MPL/2.0/.

import 'package:dio/dio.dart';
import 'package:izmirferry/ferry/constants.dart';
import 'package:izmirferry/shared/logger.dart';

abstract class StationProvider with DataLoggy {
  Future<Iterable<Map<String, dynamic>>> getEndStations({
    required int startStationId,
    required int dayId,
  });
}

class IzdenizStationProvider extends StationProvider {
  late Dio _client;

  IzdenizStationProvider({required Dio client}) {
    _client = client;
  }

  @override
  Future<Iterable<Map<String, dynamic>>> getEndStations({
    required int startStationId,
    required int dayId,
  }) async {
    loggy.debug('Getting end stations...');
    loggy.trace('start station id: $startStationId');
    loggy.trace('day id: $dayId');

    final Response<List<dynamic>> response = await _client.post(
      'https://www.izdeniz.com.tr/tr/IskeleGuncelle',
      data: {
        'kalkisIskele': startStationId,
        'GunTipi': dayId,
      },
      options: Options(
        contentType: Headers.formUrlEncodedContentType,
        headers: izdenizHeaders,
      ),
    );

    final data = List<Map<String, dynamic>>.from(response.data!);
    return data;
  }
}
