// Copyright (c) 2023 Eray Erdin
//
// This Source Code Form is subject to the terms of the Mozilla Public
// License, v. 2.0. If a copy of the MPL was not distributed with this
// file, You can obtain one at http://mozilla.org/MPL/2.0/.

import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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

mixin LogicLoggy implements LoggyType {
  @override
  Loggy<LogicLoggy> get loggy =>
      Loggy<LogicLoggy>('Logic Loggy - $runtimeType');
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

class LoggyBlocObserver extends BlocObserver with LogicLoggy {
  @override
  void onCreate(BlocBase<dynamic> bloc) {
    loggy.debug('Creating bloc: $bloc');
    super.onCreate(bloc);
  }

  @override
  void onEvent(Bloc<dynamic, dynamic> bloc, Object? event) {
    loggy.debug('Bloc is on event: $bloc');
    loggy.trace('Event: $event');
    super.onEvent(bloc, event);
  }

  @override
  void onChange(BlocBase<dynamic> bloc, Change<dynamic> change) {
    loggy.debug('Bloc is on change: $bloc');
    loggy.trace('Change: $change');
    super.onChange(bloc, change);
  }

  @override
  void onTransition(
    Bloc<dynamic, dynamic> bloc,
    Transition<dynamic, dynamic> transition,
  ) {
    loggy.debug('Bloc is on transition: $bloc');
    loggy.trace('Transition: $transition');
    super.onTransition(bloc, transition);
  }

  @override
  void onError(BlocBase<dynamic> bloc, Object error, StackTrace stackTrace) {
    loggy.debug('Bloc is on error: $bloc');
    loggy.trace('Error: $error');
    loggy.trace('Stacktrace: $stackTrace');
    loggy.error('Error: $error');
    loggy.error('Stacktrace: $stackTrace');
    super.onError(bloc, error, stackTrace);
  }

  @override
  void onClose(BlocBase<dynamic> bloc) {
    loggy.debug('Bloc is on close: $bloc');
    super.onClose(bloc);
  }
}
