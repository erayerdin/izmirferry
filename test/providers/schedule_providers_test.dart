// Copyright (c) 2023 Eray Erdin
//
// This Source Code Form is subject to the terms of the Mozilla Public
// License, v. 2.0. If a copy of the MPL was not distributed with this
// file, You can obtain one at http://mozilla.org/MPL/2.0/.

import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:izmirferry/ferry/data/providers/schedule/schedule.provider.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

@GenerateNiceMocks([MockSpec<Dio>()])
import 'schedule_providers_test.mocks.dart';

void main() {
  group('izdeniz', () {
    late Dio mockClient;
    late ScheduleProvider provider;

    setUp(() {
      mockClient = MockDio();
      provider = IzdenizScheduleProvider(client: mockClient);
    });

    test('-- get schedules', () async {
      when(
        mockClient.get(
          'https://www.izdeniz.com.tr/tr/HareketSaatleri/1/2/1',
          options: anyNamed("options"),
        ),
      ).thenAnswer((realInvocation) async {
        final responseBody =
            await File('assets/test/schedule_page.html').readAsString();
        return Response<String>(
          requestOptions: RequestOptions(),
          data: responseBody,
        );
      });

      final schedules = await provider.getSchedules(
        startStationId: 1,
        endStationId: 2,
        dayId: 1,
      );

      expect(schedules.first, '07:20');
    });
  });
}
