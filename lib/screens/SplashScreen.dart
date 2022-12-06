// ignore_for_file: prefer_const_constructors, no_leading_underscores_for_local_identifiers

import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:maratha_matrimony_app/models/Auth.dart';
import 'package:maratha_matrimony_app/screens/BottomNavController.dart';
import 'package:maratha_matrimony_app/screens/LoginScreen.dart';
import 'package:maratha_matrimony_app/utils/Constants.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        backgroundColor: Colors.grey[300],
        body: SafeArea(
          child: Center(
            child:
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              Image.asset(
                'assets/images/logo.png',
                width: 200,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Soul',
                    style: GoogleFonts.amita(
                      fontWeight: FontWeight.bold,
                      fontSize: 40,
                      color: COLOR_BLACK,
                    ),
                  ),
                  Text(
                    'Saathi',
                    style: GoogleFonts.amita(
                      fontWeight: FontWeight.bold,
                      fontSize: 40,
                      color: COLOR_ORANGE,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 50),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: Image.asset(
                  'assets/images/communityLogo.png',
                ),
              ),
            ]),
          ),
        ),
      ),
    );
  }
}
