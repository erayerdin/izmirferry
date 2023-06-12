// Copyright (c) 2023 Eray Erdin
//
// This Source Code Form is subject to the terms of the Mozilla Public
// License, v. 2.0. If a copy of the MPL was not distributed with this
// file, You can obtain one at http://mozilla.org/MPL/2.0/.

import 'package:awesome_extensions/awesome_extensions.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:izmirferry/favorite/logic/favorite/favorite_bloc.dart';

class FavoriteListComponent extends StatelessWidget {
  const FavoriteListComponent({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FavoriteBloc, FavoriteState>(
      builder: (context, state) => state.map(
        loading: (state) => const CircularProgressIndicator().toCenter(),
        listed: (state) {
          final favorites = state.favorites.toList();

          return favorites.isEmpty
              ? const Text('no_favorites_found').tr().toCenter()
              : ListView.builder(
                  itemCount: favorites.length,
                  itemBuilder: (context, index) {
                    final favorite = favorites[index];

                    return Text(favorite.startStation.name);
                  },
                  shrinkWrap: true,
                ).expanded();
        },
        added: (state) => const CircularProgressIndicator(),
        deleted: (state) => const CircularProgressIndicator(),
      ),
    );
  }
}
