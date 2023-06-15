// Copyright (c) 2023 Eray Erdin
//
// This Source Code Form is subject to the terms of the Mozilla Public
// License, v. 2.0. If a copy of the MPL was not distributed with this
// file, You can obtain one at http://mozilla.org/MPL/2.0/.

import 'package:flutter_test/flutter_test.dart';
import 'package:izmirferry/ferry/constants.dart';
import 'package:izmirferry/ferry/data/repositories/schedule/schedule.repository.dart';
import 'package:izmirferry/ferry/data/repositories/station/station.repository.dart';
import 'package:izmirferry/ferry/logic/station/station_bloc.dart';
import 'package:izmirferry/shared/constants.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

@GenerateNiceMocks([
  MockSpec<StationRepository>(),
  MockSpec<ScheduleRepository>(),
])
import 'station_bloc_test.mocks.dart';

void main() {
  late StationRepository mockStationRepo;
  late ScheduleRepository mockScheduleRepo;
  late StationBloc bloc;
  late StationEvent loadEvent;
  late StationState loadedState;

  setUp(() {
    mockStationRepo = MockStationRepository();
    mockScheduleRepo = MockScheduleRepository();
    bloc = StationBloc(
      scheduleRepository: mockScheduleRepo,
      stationRepository: mockStationRepo,
    );
    loadEvent = StationEvent.load(
      startStation: allStation.first,
      endStation: allStation.first,
      day: Day.monday,
    );
    loadedState = StationState.loaded(
      startStation: allStation.first,
      endStations: [allStation.first],
      day: Day.monday,
      schedules: ["09:00", "09:30"],
    );

    when(
      mockScheduleRepo.getSchedules(
        startStation: allStation.first,
        endStation: allStation.first,
        day: Day.monday,
      ),
    ).thenAnswer((realInvocation) async => ["09:00", "09:30"]);
    when(
      mockStationRepo.getEndStations(
        startStation: allStation.first,
        day: Day.monday,
      ),
    ).thenAnswer((realInvocation) async => [allStation.first]);
  });

  test('initial state', () {
    expect(bloc.state, const StationState.loading());
  });

  test('load', () async {
    bloc.add(loadEvent);

    await expectLater(
      bloc.stream,
      emitsInOrder([
        const StationState.loading(),
        loadedState,
      ]),
    );
  });

  test('change start station', () async {
    bloc.add(loadEvent);
    bloc.add(StationEvent.changeStartStation(allStation.first));

    await expectLater(
      bloc.stream,
      emitsInOrder([
        const StationState.loading(),
        loadedState,
        const StationState.loading(),
        loadedState,
      ]),
    );
  });

  test('change end station', () async {
    bloc.add(loadEvent);
    bloc.add(StationEvent.changeEndStation(allStation.first));

    await expectLater(
      bloc.stream,
      emitsInOrder([
        const StationState.loading(),
        loadedState,
        const StationState.loading(),
        loadedState,
      ]),
    );
  });

  test('change day', () async {
    bloc.add(loadEvent);
    bloc.add(const StationEvent.changeDay(Day.monday));

    await expectLater(
      bloc.stream,
      emitsInOrder([
        const StationState.loading(),
        loadedState,
        const StationState.loading(),
        loadedState,
      ]),
    );
  });
}
