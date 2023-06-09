// ignore_for_file: public_member_api_docs, sort_constructors_first
// Copyright (c) 2023 Eray Erdin
//
// This Source Code Form is subject to the terms of the Mozilla Public
// License, v. 2.0. If a copy of the MPL was not distributed with this
// file, You can obtain one at http://mozilla.org/MPL/2.0/.

import 'package:awesome_extensions/awesome_extensions.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:izmirferry/ferry/data/models/station/station.model.dart';
import 'package:izmirferry/shared/presentation/components/circular_icon_button/circular_icon_button.component.dart';
import 'package:url_launcher/url_launcher_string.dart';

class StationsMenuComponent extends StatelessWidget {
  final List<Station> stations;
  final Station? selectedStation;
  final void Function(Station station) onChanged;

  const StationsMenuComponent({
    Key? key,
    required this.stations,
    this.selectedStation,
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
        : CircularIconButton(
            onPressed: () async {
              await launchUrlString(
                locationUrl,
                mode: LaunchMode.externalApplication,
              );
            },
            size: 32,
            child: const Icon(Icons.location_on, size: 16, color: Colors.blue),
          );

    return Row(
      children: [
        locationButton,
        ElevatedButton(
          onPressed: () async {
            final station = await _showStationsList(context);

            if (station != null) {
              onChanged(station);
            }
          },
          child: selectedStation == null
              ? const Text('choose_a_station').tr()
              : Text(selectedStation!.name),
        ).expanded(),
      ],
    );
  }

  Future<Station?> _showStationsList(BuildContext context) async {
    return showModalBottomSheet<Station?>(
      context: context,
      constraints: BoxConstraints(maxHeight: context.height / 3),
      builder: (context) => stations.isEmpty
          ? const Text('no_stations_found').tr().paddingAll(8)
          : Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'choose_a_station',
                  style: context.titleLarge,
                ).tr(),
                ListView.builder(
                  shrinkWrap: true,
                  itemCount: stations.length,
                  itemBuilder: (context, index) {
                    final station = stations[index];
                    return ListTile(
                      title: Text(station.name).toCenter(),
                      onTap: () {
                        context.pop(result: station);
                      },
                    );
                  },
                ).flexible()
              ],
            ).paddingAll(8),
    );
  }
}
