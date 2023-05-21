// Copyright (c) 2023 Eray Erdin
//
// This Source Code Form is subject to the terms of the Mozilla Public
// License, v. 2.0. If a copy of the MPL was not distributed with this
// file, You can obtain one at http://mozilla.org/MPL/2.0/.

import 'package:dio/dio.dart';
import 'package:dio_cache_interceptor/dio_cache_interceptor.dart';
import 'package:get_it/get_it.dart';

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
      ..interceptors.add(
        GetIt.I.get<DioCacheInterceptor>(),
      ),
  );
}
