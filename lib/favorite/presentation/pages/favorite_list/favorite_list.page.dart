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
import 'package:izmirferry/favorite/data/models/favorite/favorite.model.dart';
import 'package:izmirferry/favorite/logic/favorite/favorite_bloc.dart';
import 'package:izmirferry/favorite/presentation/pages/favorite_list/add_favorite_dialog.component.dart';
import 'package:izmirferry/favorite/presentation/pages/favorite_list/favorite_card.component.dart';
import 'package:lottie/lottie.dart';

@RoutePage()
class FavoriteListPage extends StatelessWidget {
  const FavoriteListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('favorites').tr(),
        backgroundColor: Colors.blue,
      ),
      body: BlocBuilder<FavoriteBloc, FavoriteState>(
        builder: (context, state) {
          return state.map(
            loading: (state) => const CircularProgressIndicator().toCenter(),
            listed: (state) {
              final favorites = state.favorites.toList(growable: false);

              if (favorites.isEmpty) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    LottieBuilder.network(
                      'https://assets3.lottiefiles.com/packages/lf20_VONtwhL250.json',
                      width: 256,
                      height: 256,
                    ),
                    const Text('no_favorites_found')
                        .textStyle(context.headlineSmall)
                        .textAlignment(TextAlign.center)
                        .tr(),
                  ],
                );
              }

              return ListView.separated(
                separatorBuilder: (context, index) => 8.heightBox,
                padding: const EdgeInsets.all(16),
                itemBuilder: (context, index) {
                  final favorite = favorites[index];
                  return FavoriteCardComponent(favorite: favorite);
                },
                itemCount: favorites.length,
              );
            },
            added: (state) => const CircularProgressIndicator().toCenter(),
            deleted: (state) => const CircularProgressIndicator().toCenter(),
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
    );
  }

  Future<void> _addFavoriteDialog(BuildContext context) async {
    final Favorite? favorite = await showDialog(
      context: context,
      builder: (context) => const Dialog(child: AddFavoriteDialogComponent()),
    );

    if (favorite != null) {
      final FavoriteBloc favoriteBloc = context.read();
      favoriteBloc.add(FavoriteEvent.add(favorite));
    }
  }
}
