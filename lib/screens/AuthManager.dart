import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:maratha_matrimony_app/models/Auth.dart';
import 'package:maratha_matrimony_app/screens/ScreenManager.dart';
import 'package:maratha_matrimony_app/screens/LoginScreen.dart';
import 'package:maratha_matrimony_app/screens/SplashScreen.dart';
import 'package:provider/provider.dart';

class AuthManager extends StatelessWidget {
  const AuthManager({super.key});

  @override
  Widget build(BuildContext context) {
    User? user = Provider.of<User?>(context);
    AuthService _auth = Provider.of<AuthService>(context);
    if (user != null && !_auth.isLoading) return ScreenManager();
    return LoginScreen();
  }
}
