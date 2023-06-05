// Copyright (c) 2023 Eray Erdin
//
// This Source Code Form is subject to the terms of the Mozilla Public
// License, v. 2.0. If a copy of the MPL was not distributed with this
// file, You can obtain one at http://mozilla.org/MPL/2.0/.

import 'package:awesome_extensions/awesome_extensions.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class SchedulesListComponent extends StatelessWidget {
  final List<String> schedules;
  final String? nextSchedule;

  const SchedulesListComponent({
    Key? key,
    required this.schedules,
    this.nextSchedule,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (schedules.isEmpty) {
      return const Text('no_schedules_found').tr().toCenter();
    }

    return ListView.separated(
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
    );
  }
}
