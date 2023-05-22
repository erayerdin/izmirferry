// Copyright (c) 2023 Eray Erdin
//
// This Source Code Form is subject to the terms of the Mozilla Public
// License, v. 2.0. If a copy of the MPL was not distributed with this
// file, You can obtain one at http://mozilla.org/MPL/2.0/.

import 'package:flutter/material.dart';
import 'package:izmirferry/shared/constants.dart';

class DaysMenuComponent extends StatelessWidget {
  final Days? selectedDay;
  final void Function(Days day) onChanged;

  const DaysMenuComponent({
    Key? key,
    this.selectedDay,
    required this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DropdownButton(
      isExpanded: true,
      items: Days.values
          .map(
            (d) => DropdownMenuItem(value: d.id, child: Text(d.localizedName)),
          )
          .toList(),
      value: selectedDay?.id,
      onChanged: (value) {
        final day = Days.values.firstWhere((d) => d.id == value);
        onChanged(day);
      },
    );
  }
}
