// Copyright (c) 2023 Eray Erdin
//
// This Source Code Form is subject to the terms of the Mozilla Public
// License, v. 2.0. If a copy of the MPL was not distributed with this
// file, You can obtain one at http://mozilla.org/MPL/2.0/.

import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:loggy/loggy.dart';

const LogLevel traceLevel = LogLevel('trace', 1);

extension LogLevelExtension on Loggy {
  void trace(dynamic message, [Object? error, StackTrace? stackTrace]) =>
      log(traceLevel, message, error, stackTrace);
}

mixin DataLoggy implements LoggyType {
  @override
  Loggy<DataLoggy> get loggy => Loggy<DataLoggy>('Data Loggy - $runtimeType');
}

class CrashlyticsPrinter extends LoggyPrinter {
  late FirebaseCrashlytics _crashlytics;

  CrashlyticsPrinter({required FirebaseCrashlytics crashlytics}) {
    _crashlytics = crashlytics;
  }

  static final Map<LogLevel, String> _levelPrefixes = <LogLevel, String>{
    traceLevel: '🔢 ',
    LogLevel.debug: '⌨️ ',
    LogLevel.info: '🗨️ ',
    LogLevel.warning: '⚠️ ',
    LogLevel.error: '🔥 ',
  };

  // For undefined log levels
  static const String _defaultPrefix = '🤔 ';

  @override
  void onLog(LogRecord record) {
    final String time = record.time.toIso8601String().split('T')[1];
    final String callerFrame =
        record.callerFrame == null ? '-' : '(${record.callerFrame?.location})';
    final String logLevel =
        record.level.toString().replaceAll('Level.', '').toUpperCase();

    final String prefix = levelPrefix(record.level) ?? _defaultPrefix;

    _crashlytics.log('$prefix$time $logLevel $callerFrame ${record.message}');

    if (record.level == LogLevel.error) {
      _crashlytics.recordError(record.error, record.stackTrace);
    }
  }

  /// Get prefix for level
  String? levelPrefix(LogLevel level) {
    return _levelPrefixes[level];
  }
}
