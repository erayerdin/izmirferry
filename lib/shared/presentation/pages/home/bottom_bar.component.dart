// Copyright (c) 2023 Eray Erdin
//
// This Source Code Form is subject to the terms of the Mozilla Public
// License, v. 2.0. If a copy of the MPL was not distributed with this
// file, You can obtain one at http://mozilla.org/MPL/2.0/.

import 'package:awesome_extensions/awesome_extensions.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:izmirferry/ferry/constants.dart';
import 'package:izmirferry/ferry/data/models/station/station.model.dart';
import 'package:izmirferry/ferry/logic/station/station_bloc.dart';
import 'package:izmirferry/shared/constants.dart';

class BottomBarComponent extends StatelessWidget {
  const BottomBarComponent({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<StationBloc, StationState>(
      builder: (context, state) {
        final StationBloc stationBloc = context.read();

        final Station startStation = stationBloc.currentParams['startStation'];
        final Station? endStation = stationBloc.currentParams['endStation'];
        final Day day = stationBloc.currentParams['day'];

        return Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Colors.blue[300]!,
                Colors.blue[700]!,
              ],
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              state.map(
                loading: (state) => _buildStationSelectorWidget(
                  context,
                  stations: allStation,
                  selectedStation: startStation,
                  isStart: true,
                ).applyShimmer(),
                loaded: (state) => _buildStationSelectorWidget(
                  context,
                  stations: allStation,
                  selectedStation: startStation,
                  isStart: true,
                ),
              ),
              const Icon(Icons.arrow_forward, color: Colors.white),
              state.map(
                loading: (state) => _buildStationSelectorWidget(
                  context,
                  stations: [],
                  selectedStation: stationBloc.currentParams['endStation'],
                  isStart: false,
                ).applyShimmer(),
                loaded: (state) => _buildStationSelectorWidget(
                  context,
                  stations: state.endStations.toList(),
                  selectedStation: endStation,
                  isStart: false,
                ),
              ),
              Text(
                '@',
                style: context.bodyMedium?.copyWith(color: Colors.white),
              ),
              state.map(
                loading: (state) =>
                    _buildDaySelectorWidget(context, day).applyShimmer(),
                loaded: (state) => _buildDaySelectorWidget(context, day),
              ),
            ],
          ).paddingAll(16),
        );
      },
    );
  }

  Widget _buildStationSelectorWidget(
    BuildContext context, {
    required List<Station> stations,
    required Station? selectedStation,
    required bool isStart,
  }) {
    return BlocBuilder<StationBloc, StationState>(
      builder: (context, state) => GestureDetector(
        onTap: state.map(
          loading: (state) => null,
          loaded: (state) => () async {
            final Station? station = await showModalBottomSheet(
              context: context,
              builder: (context) => _buildStationListWidget(
                context,
                stations: stations,
                isStart: isStart,
              ),
              elevation: 4,
              showDragHandle: true,
              useSafeArea: true,
            );

            if (station != null) {
              final StationBloc stationBloc = context.read();
              stationBloc.add(
                isStart
                    ? StationEvent.changeStartStation(station)
                    : StationEvent.changeEndStation(station),
              );
            }
          },
        ),
        child: Text(
          selectedStation?.name ?? '???',
          style: context.bodyMedium?.copyWith(color: Colors.white),
        ),
      ),
    );
  }

  Widget _buildDaySelectorWidget(BuildContext context, Day day) {
    return BlocBuilder<StationBloc, StationState>(
      builder: (context, state) {
        return GestureDetector(
          onTap: state.map(
            loading: (state) => null,
            loaded: (state) => () async {
              final Day? day = await showModalBottomSheet(
                context: context,
                builder: (context) => _buildDayListWidget(context),
                elevation: 4,
                showDragHandle: true,
                useSafeArea: true,
              );

              if (day != null) {
                final StationBloc stationBloc = context.read();
                stationBloc.add(StationEvent.changeDay(day));
              }
            },
          ),
          child: Text(
            day.localizedName,
            style: context.bodyMedium?.copyWith(color: Colors.white),
          ),
        );
      },
    );
  }

  Widget _buildStationListWidget(
    BuildContext context, {
    required List<Station> stations,
    required bool isStart,
  }) {
    return Column(
      children: [
        const Text('choose_a_station').tr(),
        ListView.builder(
          itemBuilder: (context, index) => ListTile(
            title: GestureDetector(
              onTap: () {
                context.pop(result: stations[index]);
              },
              child: Text(stations[index].name),
            ),
          ),
          itemCount: stations.length,
        ).expanded(),
      ],
    ).paddingAll(16);
  }

  Widget _buildDayListWidget(BuildContext context) {
    return Column(
      children: [
        const Text('choose_a_day').tr(),
        ListView.builder(
          itemBuilder: (context, index) => ListTile(
            title: GestureDetector(
              onTap: () {
                context.pop(result: Day.values[index]);
              },
              child: Text(Day.values[index].localizedName),
            ),
          ),
          itemCount: Day.values.length,
        ).expanded(),
      ],
    ).paddingAll(16);
  }
}
