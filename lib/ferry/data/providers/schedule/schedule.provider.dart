// Copyright (c) 2023 Eray Erdin
//
// This Source Code Form is subject to the terms of the Mozilla Public
// License, v. 2.0. If a copy of the MPL was not distributed with this
// file, You can obtain one at http://mozilla.org/MPL/2.0/.

import 'package:dio/dio.dart';
import 'package:html/parser.dart';
import 'package:izmirferry/shared/logger.dart';

abstract class ScheduleProvider with DataLoggy {
  Future<Iterable<String>> getSchedules({
    required int startStationId,
    required int endStationId,
    required int dayId,
  });

  Future<Iterable<Map<String, dynamic>>> getEndStations({
    required int startStationId,
    required int dayId,
  });
}

class IzdenizScheduleProvider extends ScheduleProvider {
  late Dio _client;

  IzdenizScheduleProvider({required Dio client}) {
    _client = client;
  }

  @override
  Future<Iterable<String>> getSchedules({
    required int startStationId,
    required int endStationId,
    required int dayId,
  }) async {
    loggy.debug('Getting schedules...');
    loggy.trace('start station id: $startStationId');
    loggy.trace('end station id: $endStationId');
    loggy.trace('day id: $dayId');

    final url =
        'https://www.izdeniz.com.tr/tr/HareketSaatleri/$startStationId/$endStationId/$dayId';

    final Response<String> response = await _client.get(url);

    final dom = parse(response.data);

    final tableRows = dom.getElementsByTagName('td');
    final hourRows = tableRows
        .where((element) => element.className == '\\"sefertd\\"')
        .toList();

    return hourRows.map((e) => e.text.replaceAll('\\n', '').trim());
  }

  @override
  Future<Iterable<Map<String, dynamic>>> getEndStations({
    required int startStationId,
    required int dayId,
  }) async {
    loggy.debug('Getting end stations...');
    loggy.trace('start station id: $startStationId');
    loggy.trace('day id: $dayId');

    final Response<List<Map<String, dynamic>>> response = await _client.post(
      'https://www.izdeniz.com.tr/tr/IskeleGuncelle',
      data: {
        'kalkisIskele': startStationId,
        'GunTipi': dayId,
      },
      options: Options(contentType: Headers.formUrlEncodedContentType),
    );

    return response.data!;
  }
}
