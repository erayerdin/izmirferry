// Copyright (c) 2023 Eray Erdin
//
// This Source Code Form is subject to the terms of the Mozilla Public
// License, v. 2.0. If a copy of the MPL was not distributed with this
// file, You can obtain one at http://mozilla.org/MPL/2.0/.

import 'package:auto_route/auto_route.dart';
import 'package:awesome_extensions/awesome_extensions.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it_future_builder/get_it_future_builder.dart';
import 'package:izmirferry/favorite/data/models/favorite/favorite.model.dart';
import 'package:izmirferry/favorite/data/repository/favorite/favorite.repository.dart';
import 'package:izmirferry/favorite/logic/favorite/favorite_bloc.dart';
import 'package:izmirferry/favorite/presentation/pages/favorite_list/add_favorite_dialog.component.dart';

@RoutePage()
class FavoriteListPage extends StatelessWidget {
  const FavoriteListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetItFutureBuilder<FavoriteRepository>(
      loading: (context) => Scaffold(
        body: const CircularProgressIndicator().toCenter(),
      ),
      ready: (context, favoriteRepo) {
        return MultiBlocProvider(
          providers: [
            BlocProvider(
              create: (context) =>
                  FavoriteBloc(favoriteRepository: favoriteRepo)
                    ..add(const FavoriteEvent.list()),
            ),
          ],
          child: Scaffold(
            appBar: AppBar(
              title: const Text('favorites').tr(),
            ),
            body: BlocBuilder<FavoriteBloc, FavoriteState>(
              builder: (context, state) {
                return state.map(
                  loading: (state) =>
                      const CircularProgressIndicator().toCenter(),
                  listed: (state) {
                    final favorites = state.favorites.toList(growable: false);

                    if (favorites.isEmpty) {
                      return const Text('no_favorites_found').tr().toCenter();
                    }

                    return const Text('tbi'); // TODO tbi
                  },
                  added: (state) =>
                      const CircularProgressIndicator().toCenter(),
                  deleted: (state) =>
                      const CircularProgressIndicator().toCenter(),
                );
              },
            ),
            floatingActionButton: Builder(
                // because _addFavoriteDialog accesses FavoriteBloc,
                // which isn't injected on the top level context
                builder: (context) => FloatingActionButton(
                      onPressed: () async {
                        await _addFavoriteDialog(context);
                      },
                      child: const Icon(Icons.add),
                    )),
          ),
        );
      },
    );
  }

  Future<void> _addFavoriteDialog(BuildContext context) async {
    final Favorite? favorite = await showDialog(
      context: context,
      builder: (context) => const Dialog(child: AddFavoriteDialogComponent()),
    );

    if (favorite != null) {
      final FavoriteBloc favoriteBloc = context.read();
      favoriteBloc.add(
        FavoriteEvent.add(
          startStation: favorite.startStation,
          endStation: favorite.endStation,
          day: favorite.day,
        ),
      );
    }
  }
}
