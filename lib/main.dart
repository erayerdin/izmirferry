import 'package:flutter/material.dart';
import 'package:loggy/loggy.dart';

void main() {
  Loggy.initLoggy();
  runApp(const App());
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
      home: const HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("İzmir Ferry")),
      body: const Center(
        child: Text('hello world'),
      ),
    );
  }
}
