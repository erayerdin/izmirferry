// Copyright (c) 2023 Eray Erdin
//
// This Source Code Form is subject to the terms of the Mozilla Public
// License, v. 2.0. If a copy of the MPL was not distributed with this
// file, You can obtain one at http://mozilla.org/MPL/2.0/.

import 'package:chips_choice/chips_choice.dart';
import 'package:flexi_chip/flexi_chip.dart';
import 'package:flutter/material.dart';
import 'package:izmirferry/shared/constants.dart';

class DaysMenuComponent extends StatelessWidget {
  final Day? selectedDay;
  final void Function(Day day) onChanged;

  const DaysMenuComponent({
    Key? key,
    this.selectedDay,
    required this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChipsChoice<Day>.single(
      value: selectedDay,
      onChanged: (value) {
        final day = Day.values.firstWhere((d) => d == value);
        onChanged(day);
      },
      choiceItems: C2Choice.listFrom(
          source: Day.values,
          value: (i, v) => v,
          label: (i, v) => v.localizedName,
          style: (i, v) {
            if (v == selectedDay) {
              return const FlexiChipStyle(
                backgroundColor: Colors.blue,
                backgroundOpacity: 1,
                foregroundColor: Colors.white,
                elevation: 4,
              );
            } else {
              return const FlexiChipStyle(
                backgroundColor: Colors.white,
                backgroundOpacity: 1,
                foregroundColor: Colors.blue,
                elevation: 4,
              );
            }
          }),
      wrapped: true,
      alignment: WrapAlignment.center,
    );
  }
}
