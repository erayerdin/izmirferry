// Copyright (c) 2023 Eray Erdin
//
// This Source Code Form is subject to the terms of the Mozilla Public
// License, v. 2.0. If a copy of the MPL was not distributed with this
// file, You can obtain one at http://mozilla.org/MPL/2.0/.

import 'package:flutter_test/flutter_test.dart';
import 'package:izmirferry/shared/extensions/time.dart';

void main() {
  group('string extension', () {
    test('-- valid', () {
      final vals = [
        '05:42'.timeValue,
        '19:30'.timeValue,
        '09:05'.timeValue,
      ];
      expect(vals, equals([542, 1930, 905]));
    });

    // TODO write invalid test
  });

  group('datetime extension', () {
    test('-- leading zero on hour', () {
      final dt = DateTime(1994, 12, 5, 3, 30);
      expect(dt.timeRepr, equals('03:30'));
    });

    test('-- leading zero on minute', () {
      final dt = DateTime(1994, 12, 5, 3, 5);
      expect(dt.timeRepr, equals('03:05'));
    });
  });
}
