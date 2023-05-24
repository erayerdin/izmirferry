// ignore_for_file: public_member_api_docs, sort_constructors_first
// Copyright (c) 2023 Eray Erdin
//
// This Source Code Form is subject to the terms of the Mozilla Public
// License, v. 2.0. If a copy of the MPL was not distributed with this
// file, You can obtain one at http://mozilla.org/MPL/2.0/.

import 'package:awesome_extensions/awesome_extensions.dart';
import 'package:collection/collection.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:izmirferry/ferry/constants.dart';
import 'package:izmirferry/ferry/data/models/station/station.model.dart';
import 'package:url_launcher/url_launcher_string.dart';

class StationsMenuComponent extends StatelessWidget {
  final List<Station> stations;
  final Station? selectedStation;
  final bool isLocationButtonOnRight;
  final void Function(Station station) onChanged;

  const StationsMenuComponent({
    Key? key,
    required this.stations,
    this.selectedStation,
    required this.isLocationButtonOnRight,
    required this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (stations.isEmpty) {
      return const Text('no_station_found').tr().textStyle(
            context.textTheme.bodyMedium?.copyWith(color: Colors.white),
          );
    }

    final locationUrl = selectedStation?.locationUrl;
    final locationButton = locationUrl == null
        ? const SizedBox()
        : IconButton(
            onPressed: () async {
              await launchUrlString(locationUrl);
            },
            icon: const Icon(Icons.map, color: Colors.white),
          );

    return Row(
      children: [
        if (!isLocationButtonOnRight) locationButton,
        DropdownButtonHideUnderline(
          child: DropdownButton2<int>(
            isExpanded: true,
            iconStyleData: const IconStyleData(
              iconEnabledColor: Colors.white,
              iconDisabledColor: Colors.white,
            ),
            dropdownStyleData: const DropdownStyleData(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
            ),
            items: stations
                .map(
                  (s) => DropdownMenuItem(
                    value: s.id,
                    child: Text(s.name).textStyle(
                      context.textTheme.bodyMedium
                          ?.copyWith(color: Colors.white),
                    ),
                  ),
                )
                .toList(),
            value: stations
                    .firstWhereOrNull((s) => s.id == selectedStation?.id)
                    ?.id ??
                stations.first.id,
            onChanged: (value) {
              final station = allStation.firstWhere((s) => s.id == value);
              onChanged(station);
            },
          ),
        ).expanded(),
        if (isLocationButtonOnRight) locationButton,
      ],
    );
  }
}
