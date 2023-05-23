// ignore_for_file: public_member_api_docs, sort_constructors_first
// Copyright (c) 2023 Eray Erdin
//
// This Source Code Form is subject to the terms of the Mozilla Public
// License, v. 2.0. If a copy of the MPL was not distributed with this
// file, You can obtain one at http://mozilla.org/MPL/2.0/.

import 'package:awesome_extensions/awesome_extensions.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class AppBarComponent extends StatelessWidget {
  final List<Widget> children;
  final String imagePath;

  const AppBarComponent({
    Key? key,
    required this.children,
    required this.imagePath,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      // color: Colors.blue,
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
          image: AssetImage(imagePath),
          fit: BoxFit.cover,
          opacity: 0.2,
        ),
        borderRadius: BorderRadius.vertical(
          bottom: Radius.elliptical(MediaQuery.of(context).size.width, 50.0),
        ),
      ),
      child: Column(
        children: [
          const Text('izmir_ferry')
              .tr()
              .textStyle(
                context.textTheme.titleLarge?.copyWith(color: Colors.white),
              )
              .alignAtTopCenter()
              .paddingOnly(top: 32 * 3, left: 16, right: 16, bottom: 32 * 3),
          ...children,
        ],
      ).paddingOnly(left: 16, right: 16, bottom: 16 * 3),
    );
  }
}
