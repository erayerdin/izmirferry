// Copyright (c) 2023 Eray Erdin
//
// This Source Code Form is subject to the terms of the Mozilla Public
// License, v. 2.0. If a copy of the MPL was not distributed with this
// file, You can obtain one at http://mozilla.org/MPL/2.0/.

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:izmirferry/ferry/data/models/station/station.model.dart';
import 'package:izmirferry/ferry/logic/station/station_bloc.dart';

class DrawerComponent extends StatelessWidget {
  const DrawerComponent({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: _backgroundImage(context),
          fit: BoxFit.cover,
          colorFilter: const ColorFilter.mode(
            Colors.white,
            BlendMode.color,
          ),
          opacity: 0.2,
        ),
      ),
      child: const SafeArea(child: Text('hello')),
    );
  }

  AssetImage _backgroundImage(BuildContext context) {
    final Station? endStation =
        context.read<StationBloc>().currentParams['endStation'];

    return AssetImage(
      endStation?.backgroundAssetPath ?? 'assets/locations/izmir.jpg',
    );
  }
}
