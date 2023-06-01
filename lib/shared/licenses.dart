// Copyright (c) 2023 Eray Erdin
//
// This Source Code Form is subject to the terms of the Mozilla Public
// License, v. 2.0. If a copy of the MPL was not distributed with this
// file, You can obtain one at http://mozilla.org/MPL/2.0/.

import 'package:flutter/foundation.dart';

void initExtraLicenses() {
  LicenseRegistry.addLicense(() => Stream<LicenseEntry>.value(
      const LicenseEntryWithLineBreaks(['Location Photos'], '''
All the images of locations are taken from Wikipedia, which are shared with Creative Commons licenses.
See their respective wiki pages for more information to get further information about their licenses.

Konak - Faik Sarıkaya

Bostanlı - Gültekin Coşar

Karşıyaka - Michael ksk

Pasaport - Bernard Gagnon

Alsancak - Chansey

Göztepe - BSRF

Üçkuyular - Btian P. Dorsam

Karantina - Metin Canbalaban

İzmir - Kusadasi-Guy
''')));
}
