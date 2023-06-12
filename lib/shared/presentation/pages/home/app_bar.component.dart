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

class AppBarComponent extends StatelessWidget {
  const AppBarComponent({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<StationBloc, StationState>(
      builder: (context, state) => AppBar(
        leading: IconButton(
          onPressed: () {
            Scaffold.of(context).openDrawer();
          },
          icon: const Icon(Icons.menu, color: Colors.white),
        ),
        title: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset(
              'assets/icon/icon.png',
              color: Colors.white,
              height: 16 * 3,
            ).paddingOnly(right: 16),
            Text(
              'izmir_ferry',
              style: context.bodyLarge
                  ?.copyWith(color: Colors.white, fontSize: 24),
            ).tr(),
          ],
        ),
        centerTitle: true,
        flexibleSpace: Container(
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 5,
                blurRadius: 7,
                offset: const Offset(0, 3), // changes position of shadow
              ),
            ],
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Colors.blue[300]!,
                Colors.blue[700]!,
              ],
            ),
            image: DecorationImage(
              image: AssetImage(
                state.map(
                  loading: (state) => 'assets/locations/izmir.jpg',
                  loaded: (state) =>
                      (context.read<StationBloc>().currentParams['endStation']
                              as Station?)
                          ?.backgroundAssetPath ??
                      'assets/locations/izmir.png',
                ),
              ),
              fit: BoxFit.cover,
              opacity: 0.2,
            ),
          ),
        ),
      ),
    );
  }
}
