// Copyright (c) 2023 Eray Erdin
//
// This Source Code Form is subject to the terms of the Mozilla Public
// License, v. 2.0. If a copy of the MPL was not distributed with this
// file, You can obtain one at http://mozilla.org/MPL/2.0/.

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/foundation.dart';

enum Day {
  monday,
  tuesday,
  wednesday,
  thursday,
  friday,
  saturday,
  sunday;
}

extension DayExtension on Day {
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

// enum AdmodTestAd {
//   appOpen,
//   banner,
//   interstitial,
//   interstitialVideo,
//   rewarded,
//   rewardedInterstitial,
//   nativeAdvanced,
//   nativeAdvancedVideo,
// }

// extension AdmobTestAdExtension on AdmodTestAd {
//   String get id {
//     switch (this) {
//       case AdmodTestAd.appOpen:
//         return 'ca-app-pub-3940256099942544/3419835294';
//       case AdmodTestAd.banner:
//         return 'ca-app-pub-3940256099942544/6300978111';
//       case AdmodTestAd.interstitial:
//         return 'ca-app-pub-3940256099942544/1033173712';
//       case AdmodTestAd.interstitialVideo:
//         return 'ca-app-pub-3940256099942544/8691691433';
//       case AdmodTestAd.rewarded:
//         return 'ca-app-pub-3940256099942544/5224354917';
//       case AdmodTestAd.rewardedInterstitial:
//         return 'ca-app-pub-3940256099942544/5354046379';
//       case AdmodTestAd.nativeAdvanced:
//         return 'ca-app-pub-3940256099942544/2247696110';
//       case AdmodTestAd.nativeAdvancedVideo:
//         return 'ca-app-pub-3940256099942544/1044960115';
//     }
//   }
// }

enum AdmobAd {
  homePageBanner,
}

extension AdmobAdExtension on AdmobAd {
  String get id {
    switch (this) {
      case AdmobAd.homePageBanner:
        return kDebugMode
            ? 'ca-app-pub-3940256099942544/6300978111'
            : 'ca-app-pub-6866424804119649/1140349679';
    }
  }
}

typedef SqliteRow = Map<String, Object?>;
