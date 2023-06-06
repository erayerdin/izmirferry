// Copyright (c) 2023 Eray Erdin
//
// This Source Code Form is subject to the terms of the Mozilla Public
// License, v. 2.0. If a copy of the MPL was not distributed with this
// file, You can obtain one at http://mozilla.org/MPL/2.0/.

// i know this might look stupid
// but it works at the end of the day

extension StringTimeExtension on String {
  int get timeValue {
    // TODO add validation and throw FormatException
    final normalized = replaceAll(':', '');
    return int.parse(normalized);
  }
}

extension DateTimeTimeExtension on DateTime {
  String get timeRepr {
    final normalizedHour = hour.toString().padLeft(2, '0');
    final normalizedMinute = minute.toString().padLeft(2, '0');
    return '$normalizedHour:$normalizedMinute';
  }
}
