import 'package:easy_localization/easy_localization.dart';
import 'package:easy_localization_loader/easy_localization_loader.dart';
import 'package:flutter/material.dart';
import 'package:flutter_loggy/flutter_loggy.dart';
import 'package:izmirferry/shared/locator.dart';
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
      child: const App(),
    ),
  );
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'İzmir Ferry',
      theme: ThemeData(
        useMaterial3: true,
        colorSchemeSeed: Colors.blue,
        appBarTheme: Theme.of(context).appBarTheme.copyWith(elevation: 4),
      ),
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,
      home: const HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("izmir_ferry").tr()),
      body: Center(
        child: const Text('hello_world').tr(),
      ),
    );
  }
}
