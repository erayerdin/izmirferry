// Copyright (c) 2023 Eray Erdin
//
// This Source Code Form is subject to the terms of the Mozilla Public
// License, v. 2.0. If a copy of the MPL was not distributed with this
// file, You can obtain one at http://mozilla.org/MPL/2.0/.

import 'package:awesome_extensions/awesome_extensions.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:izmirferry/favorite/data/models/favorite/favorite.model.dart';

class FavoriteCardComponent extends StatelessWidget {
  FavoriteCardComponent({super.key, required Favorite favorite}) {
    _favorite = favorite;
  }

  late Favorite _favorite;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(
            _favorite.endStation.backgroundAssetPath ??
                'assets/locations/izmir.jpg',
          ),
          fit: BoxFit.cover,
          colorFilter: const ColorFilter.mode(
            Colors.blue,
            BlendMode.color,
          ),
          opacity: 0.2,
        ),
        borderRadius: const BorderRadius.all(Radius.circular(16)),
        boxShadow: const [
          BoxShadow(
            color: Colors.grey,
            blurRadius: 8.0,
            spreadRadius: 0.0,
            offset: Offset(0, 2.0), // shadow direction: bottom right
          )
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Text(_favorite.startStation.name).textColor(Colors.white),
                  const Icon(Icons.arrow_forward, color: Colors.white),
                  Text(_favorite.endStation.name).textColor(Colors.white),
                ],
              ),
              IconButton(
                onPressed: () {}, // TODO tbi
                icon: const Icon(Icons.delete, color: Colors.white),
              ),
            ],
          ),
          Text(_favorite.day?.name ?? 'always_today')
              .textColor(Colors.white)
              .tr(),
        ],
      ).paddingAll(16),
    );
  }
}
