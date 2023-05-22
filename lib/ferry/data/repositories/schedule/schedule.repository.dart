// Copyright (c) 2023 Eray Erdin
//
// This Source Code Form is subject to the terms of the Mozilla Public
// License, v. 2.0. If a copy of the MPL was not distributed with this
// file, You can obtain one at http://mozilla.org/MPL/2.0/.

import 'dart:convert';

import 'package:izmirferry/ferry/data/models/station/station.model.dart';
import 'package:izmirferry/ferry/data/providers/schedule/schedule.provider.dart';
import 'package:izmirferry/shared/constants.dart';
import 'package:izmirferry/shared/logger.dart';

abstract class ScheduleRepository with DataLoggy {
  Future<Iterable<String>> getSchedules({
    required Station startStation,
    required Station endStation,
    required Days day,
  });

  Future<Iterable<Station>> getEndStations({
    required Station startStation,
    required Days day,
  });
}

class IzdenizScheduleRepository extends ScheduleRepository {
  late ScheduleProvider _scheduleProvider;
  late Converter<Map<String, dynamic>, Station> _rawToStationConverter;

  IzdenizScheduleRepository({
    required ScheduleProvider scheduleProvider,
    required Converter<Map<String, dynamic>, Station> rawToStationConverter,
  }) {
    _scheduleProvider = scheduleProvider;
    _rawToStationConverter = rawToStationConverter;
  }

  @override
  Future<Iterable<Station>> getEndStations({
    required Station startStation,
    required Days day,
  }) async {
    loggy.debug('Getting end stations...');
    loggy.trace('start station: $startStation');
    loggy.trace('day: $day');

    final rawStations = await _scheduleProvider.getEndStations(
      startStationId: startStation.id,
      dayId: day.id,
    );

    return rawStations.map((e) => _rawToStationConverter.convert(e));
  }

  @override
  Future<Iterable<String>> getSchedules({
    required Station startStation,
    required Station endStation,
    required Days day,
  }) async {
    loggy.debug('Getting schedules...');
    loggy.trace('start station: $startStation');
    loggy.trace('end station: $endStation');
    loggy.trace('day: $day');

    return await _scheduleProvider.getSchedules(
      startStationId: startStation.id,
      endStationId: endStation.id,
      dayId: day.id,
    );
  }
}
