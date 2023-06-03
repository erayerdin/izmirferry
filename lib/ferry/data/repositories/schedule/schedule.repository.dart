// Copyright (c) 2023 Eray Erdin
//
// This Source Code Form is subject to the terms of the Mozilla Public
// License, v. 2.0. If a copy of the MPL was not distributed with this
// file, You can obtain one at http://mozilla.org/MPL/2.0/.

import 'package:izmirferry/ferry/data/models/station/station.model.dart';
import 'package:izmirferry/ferry/data/providers/schedule/schedule.provider.dart';
import 'package:izmirferry/shared/constants.dart';
import 'package:izmirferry/shared/logger.dart';

abstract class ScheduleRepository with DataLoggy {
  Future<Iterable<String>> getSchedules({
    required Station startStation,
    required Station endStation,
    required Day day,
  });
}

class IzdenizScheduleRepository extends ScheduleRepository {
  late ScheduleProvider _scheduleProvider;

  IzdenizScheduleRepository({required ScheduleProvider scheduleProvider}) {
    _scheduleProvider = scheduleProvider;
  }

  @override
  Future<Iterable<String>> getSchedules({
    required Station startStation,
    required Station endStation,
    required Day day,
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
