import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:maratha_matrimony_app/screens/home/home_screen.dart';
import 'package:maratha_matrimony_app/screens/onboarding/login_screen.dart';
import 'package:maratha_matrimony_app/utils/constants.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    double screenWidth = window.physicalSize.width;
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Mee Maratha Matrimony',
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.grey[200],
        primaryColor: COLOR_WHITE,
        accentColor: COLOR_ORANGE,
        textTheme: screenWidth < 500 ? TEXT_THEME_SMALL : TEXT_THEME_DEFAULT,
        fontFamily: "Montserrat",
      ),
      home: const HomeScreen(),
    );
  }
}
