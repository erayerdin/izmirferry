// Copyright (c) 2023 Eray Erdin
//
// This Source Code Form is subject to the terms of the Mozilla Public
// License, v. 2.0. If a copy of the MPL was not distributed with this
// file, You can obtain one at http://mozilla.org/MPL/2.0/.

import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:izmirferry/ferry/data/providers/station/station.provider.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

@GenerateNiceMocks([MockSpec<Dio>()])
import 'station_providers_test.mocks.dart';

void main() {
  group('izdeniz', () {
    late Dio mockClient;
    late StationProvider provider;

    setUp(() {
      mockClient = MockDio();
      provider = IzdenizStationProvider(client: mockClient);
    });

    test('-- get end stations', () async {
      when(
        mockClient.post(
          'https://www.izdeniz.com.tr/tr/IskeleGuncelle',
          options: anyNamed("options"),
          data: {
            'kalkisIskele': 1,
            'GunTipi': 1,
          },
        ),
      ).thenAnswer((realInvocation) async {
        final responseBodyRaw =
            await File('assets/test/end_stations.json').readAsString();
        final responseBody = json.decode(responseBodyRaw);
        return Response<List<dynamic>>(
          requestOptions: RequestOptions(),
          data: responseBody,
        );
      });

      final stations = (await provider.getEndStations(
        startStationId: 1,
        dayId: 1,
      ))
          .toList();

      expect(stations, [
        {
          "IskeleId": 2,
          "Adi": "Karşıyaka",
          "KoorX": null,
          "KoorY": null,
          "Arabali_Vapur_Hatti_Mi": null,
          "Aktif_Mi": null,
          "IZD_GTFS_Sefer_Saatleri": []
        },
        {
          "IskeleId": 3,
          "Adi": "Bostanlı",
          "KoorX": null,
          "KoorY": null,
          "Arabali_Vapur_Hatti_Mi": null,
          "Aktif_Mi": null,
          "IZD_GTFS_Sefer_Saatleri": []
        }
      ]);
    });
  });
}
