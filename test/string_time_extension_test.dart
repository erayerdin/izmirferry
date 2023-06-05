// Copyright (c) 2023 Eray Erdin
//
// This Source Code Form is subject to the terms of the Mozilla Public
// License, v. 2.0. If a copy of the MPL was not distributed with this
// file, You can obtain one at http://mozilla.org/MPL/2.0/.

import 'package:flutter_test/flutter_test.dart';
import 'package:izmirferry/shared/extensions/time.dart';

void main() {
  test('valid', () {
    final vals = [
      '05:42'.timeValue,
      '19:30'.timeValue,
      '09:05'.timeValue,
    ];
    expect(vals, equals([542, 1930, 905]));
  });

  // TODO write invalid test
}
