// Copyright (c) 2023 Eray Erdin
//
// This Source Code Form is subject to the terms of the Mozilla Public
// License, v. 2.0. If a copy of the MPL was not distributed with this
// file, You can obtain one at http://mozilla.org/MPL/2.0/.

import 'package:dio/dio.dart';
import 'package:dio_cache_interceptor/dio_cache_interceptor.dart';
import 'package:flutter_loggy_dio/flutter_loggy_dio.dart';
import 'package:get_it/get_it.dart';
import 'package:izmirferry/ferry/data/providers/schedule/schedule.provider.dart';

void initLocator() {
  //-----//
  // Dio //
  //-----//
  GetIt.I.registerLazySingleton<DioCacheInterceptor>(
    () => DioCacheInterceptor(
      options: CacheOptions(
        store: MemCacheStore(),
      ),
    ),
  );

  GetIt.I.registerLazySingleton<Dio>(
    () => Dio()
      ..interceptors.addAll(
        [GetIt.I.get<DioCacheInterceptor>(), LoggyDioInterceptor()],
      ),
  );

  //-----------//
  // Providers //
  //-----------//
  GetIt.I.registerLazySingleton<ScheduleProvider>(
    () => IzdenizScheduleProvider(client: GetIt.I.get()),
  );
}

void initLocatorForTests() {
  initLocator();

  GetIt.I.unregister<Dio>();
  GetIt.I.registerLazySingleton<Dio>(() => Dio());
}