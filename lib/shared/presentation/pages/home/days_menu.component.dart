// Copyright (c) 2023 Eray Erdin
//
// This Source Code Form is subject to the terms of the Mozilla Public
// License, v. 2.0. If a copy of the MPL was not distributed with this
// file, You can obtain one at http://mozilla.org/MPL/2.0/.

import 'package:flutter/material.dart';
import 'package:izmirferry/shared/constants.dart';

class DaysMenuComponent extends StatelessWidget {
  const DaysMenuComponent({super.key});

  @override
  Widget build(BuildContext context) {
    return DropdownButton(
      isExpanded: true,
      items: Days.values
          .map(
            (d) => DropdownMenuItem(value: d.id, child: Text(d.localizedName)),
          )
          .toList(),
      value: 1,
      onChanged: (value) {},
    );
  }
}
