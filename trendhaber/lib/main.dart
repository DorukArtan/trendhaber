import 'package:flutter/material.dart';
import 'pages/settings_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context){
  return MaterialApp(
    debugShowCheckedModeBanner: false,
    title: 'TrendHaber',
    theme: ThemeData(
      primarySwatch: Colors.pink,
    ),
    home: SettingsPage(),
  );
  }
}