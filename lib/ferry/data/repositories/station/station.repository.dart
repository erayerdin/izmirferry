// Copyright (c) 2023 Eray Erdin
//
// This Source Code Form is subject to the terms of the Mozilla Public
// License, v. 2.0. If a copy of the MPL was not distributed with this
// file, You can obtain one at http://mozilla.org/MPL/2.0/.

import 'dart:convert';

import 'package:izmirferry/ferry/data/models/station/station.model.dart';
import 'package:izmirferry/ferry/data/providers/station/station.provider.dart';
import 'package:izmirferry/shared/constants.dart';
import 'package:izmirferry/shared/logger.dart';

abstract class StationRepository with DataLoggy {
  Future<Iterable<Station>> getEndStations({
    required Station startStation,
    required Day day,
  });
}

class IzdenizStationRepository extends StationRepository {
  late StationProvider _stationProvider;
  late Converter<Map<String, dynamic>, Station> _rawToStationConverter;

  IzdenizStationRepository({
    required StationProvider stationProvider,
    required Converter<Map<String, dynamic>, Station> rawToStationConverter,
  }) {
    _stationProvider = stationProvider;
    _rawToStationConverter = rawToStationConverter;
  }

  @override
  Future<Iterable<Station>> getEndStations({
    required Station startStation,
    required Day day,
  }) async {
    loggy.debug('Getting end stations...');
    loggy.trace('start station: $startStation');
    loggy.trace('day: $day');

    final rawStations = await _stationProvider.getEndStations(
      startStationId: startStation.id,
      dayId: day.id,
    );

    return rawStations.map((e) => _rawToStationConverter.convert(e));
  }
}
