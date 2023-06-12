// Copyright (c) 2023 Eray Erdin
//
// This Source Code Form is subject to the terms of the Mozilla Public
// License, v. 2.0. If a copy of the MPL was not distributed with this
// file, You can obtain one at http://mozilla.org/MPL/2.0/.

import 'package:awesome_extensions/awesome_extensions.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:izmirferry/favorite/presentation/components/favorite_list_dialog/favorite_list_dialog.component.dart';
import 'package:izmirferry/ferry/data/models/station/station.model.dart';
import 'package:izmirferry/ferry/logic/station/station_bloc.dart';
import 'package:izmirferry/shared/presentation/components/circular_icon_button/circular_icon_button.component.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:url_launcher/url_launcher_string.dart';

class AppBarComponent extends StatelessWidget {
  const AppBarComponent({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<StationBloc, StationState>(
      builder: (context, state) => AppBar(
        leading: Image.asset(
          'assets/icon/icon.png',
          color: Colors.white,
          height: 16 * 3,
        ).paddingOnly(left: 16),
        title: Text(
          'izmir_ferry',
          style: context.bodyLarge?.copyWith(color: Colors.white, fontSize: 24),
        ).tr(),
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
        actions: [
          PopupMenuButton(
            color: Colors.white,
            itemBuilder: (context) => [
              PopupMenuItem(
                value: 'favorites',
                child: const Text('favorites').tr(),
              ),
              PopupMenuItem(
                value: 'about',
                child: const Text('about').tr(),
              ),
            ],
            onSelected: (val) async {
              switch (val) {
                case 'about':
                  await _showAboutDialog(context);
                case 'favorites':
                  await showDialog(
                    context: context,
                    builder: (context) => const Dialog(
                      child: FavoriteListDialogComponent(),
                    ),
                  );
              }
            },
          ),
        ],
      ),
    );
  }

  Future<void> _showAboutDialog(BuildContext context) async {
    final packageInfo = await PackageInfo.fromPlatform();

    // ignore: use_build_context_synchronously
    showAboutDialog(
      context: context,
      applicationIcon: Image.asset(
        'assets/icon/icon.png',
        width: 32,
      ),
      applicationName: 'izmir_ferry'.tr(),
      applicationVersion: packageInfo.version,
      children: [
        const Text(
          'izmir_ferry_short_description',
          textAlign: TextAlign.center,
        ).tr(),
        16.heightBox,
        Wrap(
          alignment: WrapAlignment.center,
          runSpacing: 8.0,
          spacing: 8.0,
          children: [
            CircularIconButton(
              onPressed: () async {
                await launchUrlString(
                  'https://github.com/erayerdin/izmirferry/',
                  mode: LaunchMode.externalApplication,
                );
              },
              fillColor: Colors.black,
              child: const Icon(
                Icons.developer_mode,
                color: Colors.white,
              ),
            ),
            CircularIconButton(
              onPressed: () async {
                await launchUrlString(
                  'https://t.me/erayerdin',
                  mode: LaunchMode.externalApplication,
                );
              },
              fillColor: const Color(0xff0088cc),
              child: const FaIcon(
                FontAwesomeIcons.telegram,
                color: Colors.white,
              ),
            ),
            CircularIconButton(
              onPressed: () async {
                await launchUrlString(
                  'https://twitter.com/_erayerdin',
                  mode: LaunchMode.externalApplication,
                );
              },
              fillColor: const Color(0xff1da1f2),
              child: const FaIcon(
                FontAwesomeIcons.twitter,
                color: Colors.white,
              ),
            ),
            CircularIconButton(
              onPressed: () async {
                await launchUrlString(
                  'https://www.linkedin.com/in/erayerdin/',
                  mode: LaunchMode.externalApplication,
                );
              },
              fillColor: const Color(0xff0a66c2),
              child: const FaIcon(
                FontAwesomeIcons.linkedinIn,
                color: Colors.white,
              ),
            ),
            CircularIconButton(
              onPressed: () async {
                await launchUrlString(
                  'https://www.youtube.com/@_schwm',
                  mode: LaunchMode.externalApplication,
                );
              },
              fillColor: const Color(0xffff0000),
              child: const FaIcon(
                FontAwesomeIcons.youtube,
                color: Colors.white,
              ),
            ),
            CircularIconButton(
              onPressed: () async {
                await launchUrlString(
                  'https://www.instagram.com/_erayerdin/',
                  mode: LaunchMode.externalApplication,
                );
              },
              fillColor: const Color(0xffc13584),
              child: const FaIcon(
                FontAwesomeIcons.instagram,
                color: Colors.white,
              ),
            ),
            CircularIconButton(
              onPressed: () async {
                await launchUrlString(
                  'https://stackoverflow.com/users/2926992/eray-erdin',
                );
              },
              fillColor: const Color(0xfff48024),
              child: const FaIcon(
                FontAwesomeIcons.stackOverflow,
                color: Colors.white,
              ),
            ),
            CircularIconButton(
              onPressed: () async {
                await launchUrlString(
                  'https://github.com/erayerdin/',
                  mode: LaunchMode.externalApplication,
                );
              },
              fillColor: Colors.black,
              child: const FaIcon(
                FontAwesomeIcons.github,
                color: Colors.white,
              ),
            ),
            CircularIconButton(
              onPressed: () async {
                await launchUrlString(
                  'mailto:eraygezer.94@gmail.com',
                  mode: LaunchMode.externalApplication,
                );
              },
              fillColor: Colors.white,
              child: const Icon(
                Icons.mail,
                color: Colors.black,
              ),
            ),
          ],
        )
      ],
    );
  }
}
