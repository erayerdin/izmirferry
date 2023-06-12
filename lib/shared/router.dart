// Copyright (c) 2023 Eray Erdin
//
// This Source Code Form is subject to the terms of the Mozilla Public
// License, v. 2.0. If a copy of the MPL was not distributed with this
// file, You can obtain one at http://mozilla.org/MPL/2.0/.

import 'package:auto_route/auto_route.dart';
import 'package:izmirferry/favorite/presentation/pages/favorite_list/favorite_list.page.dart';
import 'package:izmirferry/shared/presentation/pages/home/home.page.dart';

part 'router.gr.dart';

// Warning: when you add or remove a new page, router.gr.dart will probably err
// due to missing import. that's the reason why it's not hidden in VSCode
// settings. check your file list for router.gr.dart. when it errs, go to that
// file, do CTRL+. on the missing import and choose the target page, which will
// import the page to this file.

@AutoRouterConfig()
class AppRouter extends _$AppRouter {
  @override
  List<AutoRoute> get routes => [
        AutoRoute(page: HomeRoute.page, initial: true),
        AutoRoute(page: FavoriteListRoute.page),
      ];
}
