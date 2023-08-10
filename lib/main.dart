import 'package:flutter/material.dart';

import 'package:extra_expenses/screens/home.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp],
    );
    return MaterialApp(
      title: 'App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        textSelectionTheme:
            const TextSelectionThemeData(selectionColor: Colors.white),
      ),
      home: const HomeScreen(),
    );
  }
}
