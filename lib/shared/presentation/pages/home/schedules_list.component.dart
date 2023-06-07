// Copyright (c) 2023 Eray Erdin
//
// This Source Code Form is subject to the terms of the Mozilla Public
// License, v. 2.0. If a copy of the MPL was not distributed with this
// file, You can obtain one at http://mozilla.org/MPL/2.0/.

import 'package:awesome_extensions/awesome_extensions.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:izmirferry/ferry/data/models/station/station.model.dart';
import 'package:izmirferry/ferry/logic/station/station_bloc.dart';
import 'package:izmirferry/shared/constants.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

class SchedulesListComponent extends StatelessWidget {
  final Station startStation;
  final Station endStation;
  final Day day;
  final List<String> schedules;
  final String? nextSchedule;
  final _itemScrollController = ItemScrollController();

  SchedulesListComponent({
    Key? key,
    required this.startStation,
    required this.endStation,
    required this.day,
    required this.schedules,
    this.nextSchedule,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (schedules.isEmpty) {
      return const Text('no_schedules_found').tr().toCenter();
    }

    WidgetsBinding.instance.addPostFrameCallback((_) {
      final today = DateTime.now().dayValue;
      final Day stateDay = context.read<StationBloc>().currentParams['day'];

      if (today == stateDay && nextSchedule != null) {
        final scrollIndex = schedules.indexOf(nextSchedule!);
        _itemScrollController.scrollTo(index: scrollIndex, duration: 2.seconds);
      }
    });

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        ScrollablePositionedList.separated(
          itemScrollController: _itemScrollController,
          itemBuilder: (context, index) {
            final schedule = schedules[index];
            return Text(
              schedule,
              style: schedule == nextSchedule
                  ? context.textTheme.displayLarge?.copyWith(color: Colors.blue)
                  : context.textTheme.displayLarge,
            ).toCenter();
          },
          separatorBuilder: (context, index) => 8.heightBox,
          itemCount: schedules.length,
          padding: const EdgeInsets.all(16),
        ).expanded(),
      ],
    );
  }
}
