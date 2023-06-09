// Copyright (c) 2023 Eray Erdin
//
// This Source Code Form is subject to the terms of the Mozilla Public
// License, v. 2.0. If a copy of the MPL was not distributed with this
// file, You can obtain one at http://mozilla.org/MPL/2.0/.

import 'dart:convert';

import 'package:awesome_extensions/awesome_extensions.dart';
import 'package:dio/dio.dart';
import 'package:dio_cache_interceptor/dio_cache_interceptor.dart';
import 'package:dio_cache_interceptor_hive_store/dio_cache_interceptor_hive_store.dart';
import 'package:flutter_loggy_dio/flutter_loggy_dio.dart';
import 'package:get_it/get_it.dart';
import 'package:izmirferry/ferry/data/converters/station/station.converter.dart';
import 'package:izmirferry/ferry/data/models/station/station.model.dart';
import 'package:izmirferry/ferry/data/providers/schedule/schedule.provider.dart';
import 'package:izmirferry/ferry/data/providers/station/station.provider.dart';
import 'package:izmirferry/ferry/data/repositories/schedule/schedule.repository.dart';
import 'package:izmirferry/ferry/data/repositories/station/station.repository.dart';
import 'package:path_provider/path_provider.dart';

void initLocator() {
  //-----//
  // Dio //
  //-----//
  GetIt.I.registerLazySingletonAsync<DioCacheInterceptor>(
    () async {
      final appSupportDir = await getApplicationSupportDirectory();
      return DioCacheInterceptor(
        options: CacheOptions(
          store: HiveCacheStore(
            appSupportDir.path,
            hiveBoxName: 'izdeniz_client_cache',
          ),
          allowPostMethod: true,
          maxStale: 6.hours,
        ),
      );
    },
  );

  GetIt.I.registerLazySingletonAsync<Dio>(
    () async => Dio()
      ..interceptors.addAll(
        [await GetIt.I.getAsync<DioCacheInterceptor>(), LoggyDioInterceptor()],
      ),
    instanceName: 'izdeniz_client',
  );

  //-----------//
  // Providers //
  //-----------//
  GetIt.I.registerLazySingletonAsync<ScheduleProvider>(
    () async => IzdenizScheduleProvider(
      client: await GetIt.I.getAsync(instanceName: 'izdeniz_client'),
    ),
  );
  GetIt.I.registerLazySingletonAsync<StationProvider>(
    () async => IzdenizStationProvider(
      client: await GetIt.I.getAsync(instanceName: 'izdeniz_client'),
    ),
  );

  //------------//
  // Converters //
  //------------//
  GetIt.I.registerLazySingleton<Converter<Map<String, dynamic>, Station>>(
    () => IzdenizStationConverter(),
  );

  //--------------//
  // Repositories //
  //--------------//
  GetIt.I.registerLazySingletonAsync<ScheduleRepository>(
    () async =>
        IzdenizScheduleRepository(scheduleProvider: await GetIt.I.getAsync()),
  );
  GetIt.I.registerLazySingletonAsync<StationRepository>(
    () async => IzdenizStationRepository(
      stationProvider: await GetIt.I.getAsync(),
      rawToStationConverter: GetIt.I.get(),
    ),
  );
}

void initLocatorForTests() {
  initLocator();

  GetIt.I.unregister<Dio>();
  GetIt.I.registerLazySingleton<Dio>(() => Dio());
}
