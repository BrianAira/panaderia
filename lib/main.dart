import 'package:flutter/material.dart';
import 'presentacion/menu.dart';
import 'config/locator.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  setupLocator(); // Este usa getDatabasesPath() internamente
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Panadería App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      home: const Menu(),
      debugShowCheckedModeBanner: false,
    );
  }
}
