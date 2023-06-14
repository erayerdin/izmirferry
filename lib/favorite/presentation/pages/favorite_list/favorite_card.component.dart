// Copyright (c) 2023 Eray Erdin
//
// This Source Code Form is subject to the terms of the Mozilla Public
// License, v. 2.0. If a copy of the MPL was not distributed with this
// file, You can obtain one at http://mozilla.org/MPL/2.0/.

import 'package:awesome_extensions/awesome_extensions.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:izmirferry/favorite/data/models/favorite/favorite.model.dart';
import 'package:izmirferry/favorite/logic/favorite/favorite_bloc.dart';

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
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(_favorite.startStation.name).textColor(Colors.white),
                  const Icon(Icons.arrow_forward, color: Colors.white),
                  Text(_favorite.endStation.name).textColor(Colors.white),
                ],
              ),
              Text(_favorite.day?.name ?? 'always_today')
                  .textColor(Colors.white)
                  .tr(),
            ],
          ),
          IconButton(
            onPressed: () async {
              await _deleteDialog(context);
            },
            icon: const Icon(
              Icons.delete,
              color: Colors.white,
            ),
          ),
        ],
      ).paddingAll(16),
    );
  }

  Future<void> _deleteDialog(BuildContext context) async {
    final bool? isConfirmed = await showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text('are_you_sure')
                  .textAlignment(TextAlign.center)
                  .textStyle(context.headlineMedium)
                  .tr()
                  .paddingOnly(bottom: 16),
              const Text('favorite_will_be_deleted')
                  .textAlignment(TextAlign.center)
                  .tr(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  TextButton(
                    onPressed: () {
                      context.pop(result: true);
                    },
                    child: const Text('yes_delete').tr(),
                  ),
                  TextButton(
                    onPressed: () {
                      context.pop(result: false);
                    },
                    child: const Text('no_keep_it').tr(),
                  ),
                ],
              ),
            ],
          ).paddingAll(16),
        );
      },
    );

    if (isConfirmed ?? false) {
      final FavoriteBloc favoriteBloc = context.read();
      favoriteBloc.add(FavoriteEvent.delete(_favorite));
    }
  }
}
