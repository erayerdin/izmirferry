// Copyright (c) 2023 Eray Erdin
//
// This Source Code Form is subject to the terms of the Mozilla Public
// License, v. 2.0. If a copy of the MPL was not distributed with this
// file, You can obtain one at http://mozilla.org/MPL/2.0/.

import 'package:auto_route/auto_route.dart';
import 'package:awesome_extensions/awesome_extensions.dart';
import 'package:collection/collection.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it_future_builder/get_it_future_builder.dart';
import 'package:izmirferry/favorite/data/models/favorite/favorite.model.dart';
import 'package:izmirferry/favorite/logic/favorite/favorite_bloc.dart';
import 'package:izmirferry/ferry/constants.dart';
import 'package:izmirferry/ferry/data/repositories/schedule/schedule.repository.dart';
import 'package:izmirferry/ferry/data/repositories/station/station.repository.dart';
import 'package:izmirferry/ferry/logic/station/station_bloc.dart';
import 'package:izmirferry/shared/constants.dart';
import 'package:izmirferry/shared/extensions/time.dart';
import 'package:izmirferry/shared/presentation/pages/home/app_bar.component.dart';
import 'package:izmirferry/shared/presentation/pages/home/bottom_bar.component.dart';
import 'package:izmirferry/shared/presentation/pages/home/drawer.component.dart';
import 'package:izmirferry/shared/presentation/pages/home/schedules_list.component.dart';

@RoutePage()
class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetItFutureBuilder2<ScheduleRepository, StationRepository>(
      loading: (context) => Scaffold(
        body: const CircularProgressIndicator().toCenter(),
      ),
      ready: (context, scheduleRepo, stationRepo) => MultiBlocProvider(
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
        ],
        child: Scaffold(
          appBar: PreferredSize(
            preferredSize: Size(context.width, 64),
            child: const AppBarComponent(),
          ),
          bottomNavigationBar: const BottomBarComponent(),
          drawer: const Drawer(
            elevation: 4,
            child: DrawerComponent(),
          ),
          body: const _Body().paddingOnly(left: 16, right: 16),
          floatingActionButton: BlocBuilder<FavoriteBloc, FavoriteState>(
            builder: (context, state) {
              return state.map(
                loading: (state) => const SizedBox(),
                listed: (state) => state.favorites.isEmpty
                    ? const SizedBox()
                    : FloatingActionButton(
                        onPressed: () async {
                          await _pickFavorite(
                            context,
                            favorites: state.favorites.toList(growable: false),
                          );
                        },
                        child: const Icon(Icons.favorite),
                      ),
                added: (state) => const SizedBox(),
                deleted: (state) => const SizedBox(),
              );
            },
          ),
        ),
      ),
    );
  }

  Future<void> _pickFavorite(
    BuildContext context, {
    required List<Favorite> favorites,
  }) async {
    final Favorite? favorite = await showModalBottomSheet(
      context: context,
      builder: (context) => ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: favorites.length,
        itemBuilder: (context, index) {
          final favorite = favorites[index];
          final startStationName = favorite.startStation.name;
          final endStationName = favorite.endStation.name;
          final dayName = favorite.day?.name.tr() ?? 'always_today'.tr();

          return ListTile(
            title: Row(
              children: [
                Text(startStationName),
                const Icon(Icons.arrow_forward).paddingOnly(left: 8, right: 8),
                Text(endStationName),
              ],
            ),
            subtitle: Text(dayName),
            onTap: () {
              context.pop(result: favorite);
            },
          );
        },
      ),
    );

    if (favorite != null) {
      final startStation = favorite.startStation;
      final endStation = favorite.endStation;
      final day = favorite.day ?? DateTime.now().dayValue;
      final StationBloc stationBloc = context.read();

      stationBloc.add(
        StationEvent.load(
          startStation: startStation,
          endStation: endStation,
          day: day,
        ),
      );
    }
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
