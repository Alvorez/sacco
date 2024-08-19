import 'package:flutter/material.dart';
import 'package:sacco_teller/constants.dart';
import 'package:sacco_teller/login.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: primaryColor,
      ),
      home: const Home(),
    );
  }
}

