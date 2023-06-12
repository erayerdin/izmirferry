// Copyright (c) 2023 Eray Erdin
//
// This Source Code Form is subject to the terms of the Mozilla Public
// License, v. 2.0. If a copy of the MPL was not distributed with this
// file, You can obtain one at http://mozilla.org/MPL/2.0/.

import 'package:auto_route/auto_route.dart';
import 'package:awesome_extensions/awesome_extensions.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it_future_builder/get_it_future_builder.dart';
import 'package:izmirferry/favorite/data/repository/favorite/favorite.repository.dart';
import 'package:izmirferry/favorite/logic/favorite/favorite_bloc.dart';
import 'package:izmirferry/ferry/constants.dart';
import 'package:izmirferry/ferry/data/repositories/schedule/schedule.repository.dart';
import 'package:izmirferry/ferry/data/repositories/station/station.repository.dart';
import 'package:izmirferry/ferry/logic/station/station_bloc.dart';
import 'package:izmirferry/shared/constants.dart';
import 'package:izmirferry/shared/extensions/time.dart';
import 'package:izmirferry/shared/presentation/pages/home/app_bar.component.dart';
import 'package:izmirferry/shared/presentation/pages/home/bottom_bar.component.dart';
import 'package:izmirferry/shared/presentation/pages/home/schedules_list.component.dart';

@RoutePage()
class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetItFutureBuilder3<ScheduleRepository, StationRepository,
        FavoriteRepository>(
      loading: (context) => Scaffold(
        body: const CircularProgressIndicator().toCenter(),
      ),
      ready: (context, scheduleRepo, stationRepo, favoriteRepo) =>
          MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => StationBloc(
              scheduleRepository: scheduleRepo,
              stationRepository: stationRepo,
            )..add(
                StationEvent.load(
                  startStation: allStation.firstWhere((s) => s.id == 1),
                  endStation: allStation.firstWhere((s) => s.id == 2),
                  day: DateTime.now().dayValue,
                ),
              ),
          ),
          BlocProvider(
            create: (context) => FavoriteBloc(favoriteRepository: favoriteRepo),
          ),
        ],
        child: Scaffold(
          appBar: PreferredSize(
            preferredSize: Size(context.width, 64),
            child: const AppBarComponent(),
          ),
          body: const _Body().paddingOnly(left: 16, right: 16),
          bottomNavigationBar: const BottomBarComponent(),
        ),
      ),
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
        loaded: (state) {
          final now = DateTime.now();

          final schedules = state.schedules.toList(growable: false);
          final nowTimeVal = now.timeRepr.timeValue;
          final nextSchedule = schedules.firstWhereOrNull(
            (e) => e.timeValue > nowTimeVal,
          );

          final Day stateDay = context.read<StationBloc>().currentParams['day'];
          final today = now.dayValue;

          return SchedulesListComponent(
            startStation: state.startStation,
            endStation: context.read<StationBloc>().currentParams['endStation'],
            day: state.day,
            schedules: schedules,
            nextSchedule: stateDay == today ? nextSchedule : null,
          );
        },
      ),
    );
  }
}
