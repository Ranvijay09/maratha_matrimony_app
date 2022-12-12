import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:maratha_matrimony_app/firebase_options.dart';
import 'package:maratha_matrimony_app/screens/BasicInfoScreen.dart';
import 'package:maratha_matrimony_app/screens/CurrentAddressScreen.dart';
import 'package:maratha_matrimony_app/screens/DocumentsUploadScreen.dart';
import 'package:maratha_matrimony_app/screens/PhysicalAttributesScreen.dart';
import 'package:maratha_matrimony_app/screens/AuthManager.dart';
import 'package:maratha_matrimony_app/models/Auth.dart';
import 'package:maratha_matrimony_app/screens/SocioReligiousAttributesScreen.dart';
import 'package:maratha_matrimony_app/utils/Constants.dart';
import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    double screenWidth = window.physicalSize.width;
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<AuthService>.value(value: AuthService()),
        StreamProvider<User?>.value(
          value: AuthService().user,
          initialData: null,
          catchError: (context, _) {
            print("User null!");
            return null;
          },
        )
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Mee Maratha Matrimony',
        theme: ThemeData(
          scaffoldBackgroundColor: Colors.grey[200],
          primaryColor: COLOR_WHITE,
          textTheme: screenWidth < 500 ? TEXT_THEME_SMALL : TEXT_THEME_DEFAULT,
          fontFamily: "Montserrat",
        ),
        home: AuthManager(),
      ),
    );
  }
}
