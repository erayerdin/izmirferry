import 'dart:async';

import 'package:easy_localization/easy_localization.dart';
import 'package:easy_localization_loader/easy_localization_loader.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
// ignore: unused_import
import 'package:firebase_in_app_messaging/firebase_in_app_messaging.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_loggy/flutter_loggy.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:izmirferry/firebase_options.dart';
import 'package:izmirferry/shared/licenses.dart';
import 'package:izmirferry/shared/locator.dart';
import 'package:izmirferry/shared/logger.dart';
import 'package:izmirferry/shared/router.dart';
import 'package:loggy/loggy.dart';

Future<void> main() async {
  await runZonedGuarded<Future<void>>(
    () async {
      WidgetsFlutterBinding.ensureInitialized();

      // Ads
      await MobileAds.instance.initialize();

      // Orientation Lock
      SystemChrome.setPreferredOrientations([
        DeviceOrientation.portraitUp,
      ]);

      // Localization
      await EasyLocalization.ensureInitialized();

      // Licenses
      initExtraLicenses();

      // Dependency Injection
      initLocator();

      // Firebase
      await Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform,
      );
      FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterError;
      FirebaseAnalytics.instance.setAnalyticsCollectionEnabled(true);

      // Logging
      Loggy.initLoggy(
        logPrinter: kDebugMode
            ? const PrettyDeveloperPrinter()
            : CrashlyticsPrinter(crashlytics: FirebaseCrashlytics.instance),
        logOptions:
            const LogOptions(kDebugMode ? traceLevel : LogLevel.warning),
      );

      // Firebase Messaging
      await FirebaseInAppMessaging.instance.triggerEvent("");
      final messagingToken = await FirebaseMessaging.instance.getToken();
      logDebug("Firebase Messaging Token: $messagingToken");

      Bloc.observer = LoggyBlocObserver();

      runApp(
        EasyLocalization(
          supportedLocales: const [Locale("tr", "TR")],
          path: "assets/translations",
          assetLoader: YamlAssetLoader(),
          child: App(),
        ),
      );
    },
    (error, stack) {},
  );
}

class App extends StatelessWidget {
  final _router = AppRouter();

  App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'İzmir Ferry',
      theme: ThemeData(
        useMaterial3: true,
        colorSchemeSeed: Colors.blue,
        appBarTheme: Theme.of(context).appBarTheme.copyWith(elevation: 8),
      ),
      debugShowCheckedModeBanner: false,
      // Localization
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,
      // Router
      routerConfig: _router.config(),
    );
  }
}
