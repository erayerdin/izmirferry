// Copyright (c) 2023 Eray Erdin
//
// This Source Code Form is subject to the terms of the Mozilla Public
// License, v. 2.0. If a copy of the MPL was not distributed with this
// file, You can obtain one at http://mozilla.org/MPL/2.0/.

import 'package:loggy/loggy.dart';

const LogLevel _traceLevel = LogLevel('trace', 1);

extension LogLevelExtension on Loggy {
  void trace(dynamic message, Object? error, StackTrace? stackTrace) =>
      log(_traceLevel, message, error, stackTrace);
}

mixin DataLoggy implements LoggyType {
  @override
  Loggy<DataLoggy> get loggy => Loggy<DataLoggy>('Data Loggy - $runtimeType');
}
