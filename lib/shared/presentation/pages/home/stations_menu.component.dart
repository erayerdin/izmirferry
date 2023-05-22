// Copyright (c) 2023 Eray Erdin
//
// This Source Code Form is subject to the terms of the Mozilla Public
// License, v. 2.0. If a copy of the MPL was not distributed with this
// file, You can obtain one at http://mozilla.org/MPL/2.0/.

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:izmirferry/ferry/data/models/station/station.model.dart';

class StationsMenuComponent extends StatelessWidget {
  final List<Station> stations;

  const StationsMenuComponent({
    Key? key,
    required this.stations,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (stations.isEmpty) {
      return const Text('no_station_found').tr();
    }

    return DropdownButton<int>(
      isExpanded: true,
      items: stations
          .map((s) => DropdownMenuItem(
                value: s.id,
                child: Text(s.name),
              ))
          .toList(),
      value: stations.first.id,
      onChanged: (value) {},
    );
  }
}