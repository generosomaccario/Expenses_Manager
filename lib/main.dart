import 'package:expenses_manager/pages/homepage.dart';
import 'package:expenses_manager/theme/theme.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Expenses Manager',
      theme: theme,
      home: const HomePage(),
    );
  }
}
