// Copyright (c) 2023 Eray Erdin
//
// This Source Code Form is subject to the terms of the Mozilla Public
// License, v. 2.0. If a copy of the MPL was not distributed with this
// file, You can obtain one at http://mozilla.org/MPL/2.0/.

import 'package:awesome_extensions/awesome_extensions.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it_future_builder/get_it_future_builder.dart';
import 'package:izmirferry/favorite/data/repository/favorite/favorite.repository.dart';
import 'package:izmirferry/favorite/logic/favorite/favorite_bloc.dart';
import 'package:izmirferry/favorite/presentation/components/favorite_list_dialog/favorite_list.component.dart';

class FavoriteListDialogComponent extends StatelessWidget {
  const FavoriteListDialogComponent({super.key});

  @override
  Widget build(BuildContext context) {
    return GetItFutureBuilder<FavoriteRepository>(
        loading: (context) => const CircularProgressIndicator().toCenter(),
        ready: (context, favoriteRepo) => MultiBlocProvider(
              providers: [
                BlocProvider(
                  create: (context) =>
                      FavoriteBloc(favoriteRepository: favoriteRepo)
                        ..add(const FavoriteEvent.list()),
                )
              ],
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    'your_favorites',
                    textAlign: TextAlign.center,
                    style: context.headlineMedium,
                  ).tr(),
                  const FavoriteListComponent(),
                ],
              ),
            )).paddingAll(16);
  }
}
