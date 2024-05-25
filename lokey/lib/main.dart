import 'package:flutter/material.dart';
import 'package:lokey/home_page.dart';
import 'package:lokey/input_page.dart';
import 'package:lokey/output_page.dart';
import 'package:lokey/recommendation_page.dart.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Routes Demo',
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/': (context) => const HomePage(),
        '/input': (context) => const InputPage(),
        '/output': (context) => const OutputPage(),
        '/recommendation': (context) => const RecommendationPage(),
      },
    );
  }
}
