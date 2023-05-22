// Copyright (c) 2023 Eray Erdin
//
// This Source Code Form is subject to the terms of the Mozilla Public
// License, v. 2.0. If a copy of the MPL was not distributed with this
// file, You can obtain one at http://mozilla.org/MPL/2.0/.

import 'package:easy_localization/easy_localization.dart';

enum Days {
  monday,
  tuesday,
  wednesday,
  thursday,
  friday,
  saturday,
  sunday;
}

extension DaysExtension on Days {
  int get id {
    switch (this) {
      case Days.monday:
        return 1;
      case Days.tuesday:
        return 2;
      case Days.wednesday:
        return 3;
      case Days.thursday:
        return 4;
      case Days.friday:
        return 5;
      case Days.saturday:
        return 6;
      case Days.sunday:
        return 7;
    }
  }

  String get localizedName {
    switch (this) {
      case Days.monday:
        return 'monday'.tr();
      case Days.tuesday:
        return 'tuesday'.tr();
      case Days.wednesday:
        return 'wednesday'.tr();
      case Days.thursday:
        return 'thursday'.tr();
      case Days.friday:
        return 'friday'.tr();
      case Days.saturday:
        return 'saturday'.tr();
      case Days.sunday:
        return 'sunday';
    }
  }
}
