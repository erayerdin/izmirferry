// Copyright (c) 2023 Eray Erdin
//
// This Source Code Form is subject to the terms of the Mozilla Public
// License, v. 2.0. If a copy of the MPL was not distributed with this
// file, You can obtain one at http://mozilla.org/MPL/2.0/.

import 'package:auto_route/auto_route.dart';
import 'package:awesome_extensions/awesome_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:izmirferry/ferry/constants.dart';
import 'package:izmirferry/ferry/data/models/station/station.model.dart';
import 'package:izmirferry/ferry/logic/station/station_bloc.dart';
import 'package:izmirferry/shared/constants.dart';
import 'package:izmirferry/shared/presentation/pages/home/app_bar.component.dart';
import 'package:izmirferry/shared/presentation/pages/home/days_menu.component.dart';
import 'package:izmirferry/shared/presentation/pages/home/schedules_list.component.dart';
import 'package:izmirferry/shared/presentation/pages/home/stations_menu.component.dart';

@RoutePage()
class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final stationBloc = StationBloc(
      scheduleRepository: GetIt.I.get(),
      stationRepository: GetIt.I.get(),
    );

    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => stationBloc
            ..add(
              StationEvent.load(
                startStation: allStation.firstWhere((s) => s.id == 1),
                endStation: allStation.firstWhere((s) => s.id == 2),
                day: DateTime.now().dayValue,
              ),
            ),
        ),
      ],
      child: Scaffold(
        body: OrientationBuilder(
          builder: (context, orientation) {
            return orientation == Orientation.portrait
                ? Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      _Header(orientation: orientation),
                      const _Body().paddingOnly(left: 16, right: 16).expanded(),
                    ],
                  )
                : Row(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      _Header(orientation: orientation),
                      const _Body().paddingOnly(left: 16, right: 16).expanded(),
                    ],
                  );
          },
        ),
      ),
    );
  }
}

class _Header extends StatelessWidget {
  final Orientation orientation;

  const _Header({
    Key? key,
    required this.orientation,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final StationBloc stationBloc = context.read();
    final shimmer = Shimmer.fromColors(
      baseColor: Colors.blue[300]!,
      highlightColor: Colors.blue[100]!,
      child: Container(
        height: 50,
        decoration: BoxDecoration(
          color: Colors.blue[200],
          borderRadius: BorderRadius.circular(8),
        ),
      ).paddingAll(2),
    );

    return BlocBuilder<StationBloc, StationState>(
      builder: (context, state) => AppBarComponent(
        orientation: orientation,
        imagePath: state.map(
          loading: (state) => 'assets/locations/izmir.jpg',
          loaded: (state) {
            final StationBloc bloc = context.read();
            final Station endStation = bloc.currentParams['endStation'];
            return endStation.backgroundAssetPath ??
                'assets/locations/izmir.png';
          },
        ),
        children: [
          state.map(
            loading: (state) => shimmer,
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
          Row(
            children: [
              32.widthBox,
              const Icon(Icons.arrow_downward, color: Colors.white)
                  .paddingOnly(top: 8, bottom: 8)
                  .expanded(),
            ],
          ),
          state.map(
            loading: (state) => shimmer,
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
          state.map(
            loading: (state) => shimmer,
            loaded: (state) => DaysMenuComponent(
              selectedDay: stationBloc.currentParams['day'],
              onChanged: (day) {
                stationBloc.add(StationEvent.changeDay(day));
              },
            ),
          ),
        ],
      ).expanded(),
    );
  }
}

class _Body extends StatelessWidget {
  const _Body();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<StationBloc, StationState>(
      builder: (context, state) => state.map(
        loading: (state) => const CircularProgressIndicator().toCenter(),
        loaded: (state) => SchedulesListComponent(
          schedules: state.schedules.toList(),
        ),
      ),
    );
  }
}
