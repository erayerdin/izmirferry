// Copyright (c) 2023 Eray Erdin
//
// This Source Code Form is subject to the terms of the Mozilla Public
// License, v. 2.0. If a copy of the MPL was not distributed with this
// file, You can obtain one at http://mozilla.org/MPL/2.0/.

import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:http_mock_adapter/http_mock_adapter.dart';
import 'package:izmirferry/ferry/data/providers/schedule/schedule.provider.dart';
import 'package:izmirferry/shared/locator.dart';

void main() {
  group('izdeniz schedule provider >>', () {
    late ScheduleProvider provider;

    setUpAll(() async {
      initLocatorForTests();

      final Dio dio = GetIt.I.get();
      final dioAdapter = DioAdapter(dio: dio);

      dioAdapter.onGet(
        'https://www.izdeniz.com.tr/tr/HareketSaatleri/1/1/1',
        (server) async {
          final file = File('test_assets/schedules_sample.html');
          final source = await file.readAsString();

          return server.reply(200, source);
        },
      );

      provider = GetIt.I.get();
    });

    test(
      'get schedules',
      () async {
        final schedules = (await provider.getSchedules(
          startStationId: 1,
          endStationId: 1,
          dayId: 1,
        ))
            .toList();

        final firstElm = schedules.first;
        final lastElm = schedules.last;

        expect(firstElm, '08:25');
        expect(lastElm, '23:10');
      },
    );
  });
}
