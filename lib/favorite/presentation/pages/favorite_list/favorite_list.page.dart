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
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:izmirferry/favorite/data/models/favorite/favorite.model.dart';
import 'package:izmirferry/favorite/logic/favorite/favorite_bloc.dart';
import 'package:izmirferry/favorite/presentation/pages/favorite_list/add_favorite_dialog.component.dart';
import 'package:izmirferry/favorite/presentation/pages/favorite_list/favorite_card.component.dart';
import 'package:izmirferry/shared/constants.dart';
import 'package:loggy/loggy.dart';
import 'package:lottie/lottie.dart';

@RoutePage()
class FavoriteListPage extends StatefulWidget {
  const FavoriteListPage({super.key});

  @override
  State<FavoriteListPage> createState() => _FavoriteListPageState();
}

class _FavoriteListPageState extends State<FavoriteListPage> with UiLoggy {
  InterstitialAd? _interstitialAd;

  void loadAd() {
    InterstitialAd.load(
      adUnitId: AdmobAd.favoriteInterstitional.id,
      request: const AdRequest(),
      adLoadCallback: InterstitialAdLoadCallback(
        // Called when an ad is successfully received.
        onAdLoaded: (ad) {
          ad.fullScreenContentCallback = FullScreenContentCallback(
            onAdShowedFullScreenContent: (ad) {
              loggy.debug('Showing full screen ad: $ad');
            },
            onAdImpression: (ad) {
              loggy.debug('On ad impression: $ad');
            },
            onAdFailedToShowFullScreenContent: (ad, err) {
              loggy.debug('Full screen ad error: $ad | $err');
              loggy.error('Full screen ad error: $err');
              ad.dispose();
            },
            onAdDismissedFullScreenContent: (ad) {
              loggy.debug('Dismissing full screen ad: $ad');
              ad.dispose();
            },
            onAdClicked: (ad) {
              loggy.debug('Ad clicked: $ad');
            },
          );

          loggy.debug('$ad loaded.');
          _interstitialAd = ad;
          _interstitialAd?.show();
        },
        // Called when an ad request failed.
        onAdFailedToLoad: (LoadAdError error) {
          loggy.error('InterstitialAd failed to load: $error');
        },
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    loadAd();
  }

  @override
  void dispose() {
    super.dispose();
    _interstitialAd?.dispose();
  }

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
