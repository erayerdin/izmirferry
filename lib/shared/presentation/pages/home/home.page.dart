// Copyright (c) 2023 Eray Erdin
//
// This Source Code Form is subject to the terms of the Mozilla Public
// License, v. 2.0. If a copy of the MPL was not distributed with this
// file, You can obtain one at http://mozilla.org/MPL/2.0/.

import 'package:auto_route/auto_route.dart';
import 'package:awesome_extensions/awesome_extensions.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:izmirferry/ferry/constants.dart';
import 'package:izmirferry/ferry/logic/station/station_bloc.dart';
import 'package:izmirferry/shared/constants.dart';
import 'package:izmirferry/shared/presentation/pages/home/days_menu.component.dart';
import 'package:izmirferry/shared/presentation/pages/home/schedules_list.component.dart';
import 'package:izmirferry/shared/presentation/pages/home/stations_menu.component.dart';

@RoutePage()
class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final progressIndicator =
        const LinearProgressIndicator().paddingOnly(top: 16, bottom: 16);
    final stationBloc = StationBloc(scheduleRepository: GetIt.I.get());

    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => stationBloc
            ..add(
              StationEvent.load(
                startStation: allStation.firstWhere((s) => s.id == 1),
                endStation: allStation.firstWhere((s) => s.id == 2),
                day: Days.monday,
              ),
            ),
        ),
      ],
      child: Scaffold(
        appBar: AppBar(title: const Text("izmir_ferry").tr()),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            BlocBuilder<StationBloc, StationState>(
              builder: (context, state) => state.map(
                loading: (state) => progressIndicator,
                loaded: (state) => StationsMenuComponent(
                  stations: allStation,
                  selectedStation: stationBloc.currentParams['startStation'],
                  onChanged: (station) {
                    stationBloc.add(
                      StationEvent.changeStartStation(station),
                    );
                  },
                ),
              ),
            ),
            BlocBuilder<StationBloc, StationState>(
              builder: (context, state) => state.map(
                loading: (state) => progressIndicator,
                loaded: (state) => StationsMenuComponent(
                  stations: state.endStations.toList(),
                  selectedStation: stationBloc.currentParams['endStation'],
                  onChanged: (station) {
                    stationBloc.add(
                      StationEvent.changeEndStation(station),
                    );
                  },
                ),
              ),
            ),
            BlocBuilder<StationBloc, StationState>(
              builder: (context, state) => state.map(
                loading: (state) => progressIndicator,
                loaded: (state) => DaysMenuComponent(
                  selectedDay: stationBloc.currentParams['day'],
                  onChanged: (day) {
                    stationBloc.add(StationEvent.changeDay(day));
                  },
                ),
              ),
            ),
            BlocBuilder<StationBloc, StationState>(
              builder: (context, state) => state.map(
                loading: (state) =>
                    const CircularProgressIndicator().toCenter(),
                loaded: (state) => SchedulesListComponent(
                  schedules: state.schedules.toList(),
                ),
              ),
            ).expanded(),
          ],
        ).paddingAll(16),
      ),
    );
  }
}
