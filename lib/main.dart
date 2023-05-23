import 'package:easy_localization/easy_localization.dart';
import 'package:easy_localization_loader/easy_localization_loader.dart';
import 'package:flutter/material.dart';
import 'package:flutter_loggy/flutter_loggy.dart';
import 'package:izmirferry/shared/locator.dart';
import 'package:izmirferry/shared/router.dart';
import 'package:loggy/loggy.dart';

Future<void> main() async {
  // Localization
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();

  // Dependency Injection
  initLocator();

  // Logging
  Loggy.initLoggy(
    logPrinter: const PrettyDeveloperPrinter(),
  );

  runApp(
    EasyLocalization(
      supportedLocales: const [Locale("tr", "TR")],
      path: "assets/translations",
      assetLoader: YamlAssetLoader(),
      child: App(),
    ),
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
      // Localization
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,
      // Router
      routerConfig: _router.config(),
    );
  }
}
