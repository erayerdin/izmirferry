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
import 'package:izmirferry/ferry/data/models/station/station.model.dart';
import 'package:izmirferry/ferry/logic/station/station_bloc.dart';
import 'package:izmirferry/shared/presentation/components/circular_icon_button/circular_icon_button.component.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:url_launcher/url_launcher_string.dart';

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
      child: SafeArea(
        child: ListView(
          children: [
            const Text('izmir_ferry')
                .textStyle(context.headlineMedium)
                .textAlignment(TextAlign.center)
                .tr()
                .paddingOnly(top: 16, bottom: 16),
            const Text('izmir_ferry_short_description')
                .textStyle(context.titleMedium)
                .textAlignment(TextAlign.center)
                .tr()
                .paddingOnly(bottom: 16),
            ListTile(
              leading: const Icon(Icons.favorite),
              title: const Text('favorites').tr(),
              onTap: () {
                // TODO tbi
                throw UnimplementedError();
              },
            ),
            ListTile(
              leading: const Icon(Icons.info),
              title: const Text('about').tr(),
              onTap: () async {
                await _showAboutDialog(context);
              },
            ),
          ],
        ),
      ),
    );
  }

  AssetImage _backgroundImage(BuildContext context) {
    final Station? endStation =
        context.read<StationBloc>().currentParams['endStation'];

    return AssetImage(
      endStation?.backgroundAssetPath ?? 'assets/locations/izmir.jpg',
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
