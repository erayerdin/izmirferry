// Copyright (c) 2023 Eray Erdin
//
// This Source Code Form is subject to the terms of the Mozilla Public
// License, v. 2.0. If a copy of the MPL was not distributed with this
// file, You can obtain one at http://mozilla.org/MPL/2.0/.

import 'package:izmirferry/ferry/data/models/station/station.model.dart';

const List<Station> stations = [
  Station(id: 1, name: 'Konak'),
  Station(id: 2, name: 'Karşıyaka'),
  Station(id: 3, name: 'Bostanlı'),
  Station(id: 4, name: 'Pasaport'),
  Station(id: 5, name: 'Alsancak'),
  Station(id: 6, name: 'Göztepe'),
  Station(id: 7, name: 'Üçkuyular'),
  Station(id: 1019, name: 'Karantina'),
];

const Map<String, String> izdenizHeaders = {
  'Host': 'www.izdeniz.com.tr',
  'User-Agent':
      'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/113.0.0.0 Safari/537.36',
  'Accept': '*/*',
  'Accept-Language': 'en-US,en;q=0.5',
  'Accept-Encoding': 'gzip, deflate, br',
  'Content-Type': 'application/x-www-form-urlencoded; charset=UTF-8',
  'X-Requested-With': 'XMLHttpRequest',
  'Origin': 'https://www.izdeniz.com.tr',
  'DNT': '1',
  'Connection': 'keep-alive',
  'Referer': 'https://www.izdeniz.com.tr/',
  'Cookie': 'AspxAutoDetectCookieSupport=1',
  'Sec-Fetch-Dest': 'empty',
  'Sec-Fetch-Mode': 'cors',
  'Sec-Fetch-Site': 'same-origin',
  'TE': 'trailers'
};
