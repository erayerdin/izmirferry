// Copyright (c) 2023 Eray Erdin
//
// This Source Code Form is subject to the terms of the Mozilla Public
// License, v. 2.0. If a copy of the MPL was not distributed with this
// file, You can obtain one at http://mozilla.org/MPL/2.0/.

import 'package:flutter/material.dart';

class CircularIconButton extends StatelessWidget {
  final void Function() onPressed;
  final double elevation;
  final Widget child;
  final Color fillColor;
  final double size;

  const CircularIconButton({
    super.key,
    required this.onPressed,
    this.elevation = 2.0,
    required this.child,
    this.fillColor = Colors.white,
    this.size = 16 * 3,
  });

  @override
  Widget build(BuildContext context) {
    return RawMaterialButton(
      onPressed: onPressed,
      elevation: 2.0,
      fillColor: fillColor,
      shape: const CircleBorder(),
      constraints: BoxConstraints(
        minWidth: size,
        maxWidth: size,
        minHeight: size,
        maxHeight: size,
      ),
      child: child,
    );
  }
}
