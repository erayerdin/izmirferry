// Copyright (c) 2023 Eray Erdin
//
// This Source Code Form is subject to the terms of the Mozilla Public
// License, v. 2.0. If a copy of the MPL was not distributed with this
// file, You can obtain one at http://mozilla.org/MPL/2.0/.

import 'package:easy_localization/easy_localization.dart';

enum Day {
  monday,
  tuesday,
  wednesday,
  thursday,
  friday,
  saturday,
  sunday;
}

extension DaysExtension on Day {
  int get id {
    switch (this) {
      case Day.monday:
        return 1;
      case Day.tuesday:
        return 2;
      case Day.wednesday:
        return 3;
      case Day.thursday:
        return 4;
      case Day.friday:
        return 5;
      case Day.saturday:
        return 6;
      case Day.sunday:
        return 7;
    }
  }

  String get localizedName {
    switch (this) {
      case Day.monday:
        return 'monday'.tr();
      case Day.tuesday:
        return 'tuesday'.tr();
      case Day.wednesday:
        return 'wednesday'.tr();
      case Day.thursday:
        return 'thursday'.tr();
      case Day.friday:
        return 'friday'.tr();
      case Day.saturday:
        return 'saturday'.tr();
      case Day.sunday:
        return 'sunday'.tr();
    }
  }
}

extension DateTimeDayExtension on DateTime {
  // because `day` already exists on `DateTime`
  Day get dayValue {
    switch (weekday) {
      case 1:
        return Day.monday;
      case 2:
        return Day.tuesday;
      case 3:
        return Day.wednesday;
      case 4:
        return Day.thursday;
      case 5:
        return Day.friday;
      case 6:
        return Day.saturday;
      case 7:
        return Day.sunday;
      default:
        return Day.monday;
    }
  }
}
