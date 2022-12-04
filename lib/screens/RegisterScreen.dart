// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, use_build_context_synchronously

import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:maratha_matrimony_app/models/Auth.dart';
import 'package:maratha_matrimony_app/screens/BasicInfoScreen.dart';
import 'package:maratha_matrimony_app/screens/BottomNavController.dart';
import 'package:maratha_matrimony_app/screens/HomeScreen.dart';
import 'package:maratha_matrimony_app/screens/ScreenManager.dart';
import 'package:maratha_matrimony_app/utils/Constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  AuthService? _auth;
  final _formKey = GlobalKey<FormState>();

  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  void showSnackBar(String msg) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(msg),
      padding: EdgeInsets.all(20),
      behavior: SnackBarBehavior.floating,
    ));
  }

  _register() async {
    if (_formKey.currentState!.validate()) {
      await _auth!.createUserWithEmailAndPassword(_emailController.text,
          _passwordController.text, _phoneController.text);
      String errorMessage = _auth!.errorMessage;
      if (errorMessage.isNotEmpty) {
        Flushbar(
          title: "Error",
          message: errorMessage,
          duration: Duration(seconds: 3),
        ).show(context);
        _passwordController.clear();
        _confirmPasswordController.clear();
        return;
      }
      // Successfully Signed in.
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => BasicInfoScreen(),
        ),
      );
    }
  }

  String? _validateEmail(String? val) {
    val = val!.trim();
    val = val.trimLeft();
    val = val.trimRight();
    if (val.isEmpty) return "Please enter an email";

    const pattern = r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$';
    final regExp = RegExp(pattern);

    if (!regExp.hasMatch(val)) return "Email is invalid";

    return null;
  }

  String? _validatePassword(String? val) {
    val = val!.trim();
    if (val.isEmpty) return "Please enter a password";

    if (val.length < 8) return "Password should contain atleast 8 characters";

    if (val.length > 15) return "Password should contain atmost 15 characters";

    return null;
  }

  String? _validateConfirmPassword(String? val) {
    val = val!.trim();
    if (val.isEmpty) return "Please enter a password";

    if (val != _passwordController.text) {
      return "Password & confirm password must be same.";
    }

    return null;
  }

  String? _validatePhoneNo(String? val) {
    if (val == null || val.isEmpty) return "Please enter your phone number";

    const pattern = r'^[6-9]\d{9}$';
    final regExp = RegExp(pattern);

    if (!regExp.hasMatch(val) ||
        val.trim().length < 10 ||
        val.trim().length > 10) {
      return "Please enter a valid phone number";
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    Size _size = MediaQuery.of(context).size;
    _auth = Provider.of<AuthService>(context);
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.grey[300],
        appBar: AppBar(
          elevation: 0,
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(
              FontAwesomeIcons.chevronLeft,
              size: 20,
            ),
          ),
          foregroundColor: COLOR_BLACK,
          backgroundColor: Colors.grey[300],
          title: Text(
            'Sign Up',
            style: TextStyle(
              fontSize: 20,
            ),
          ),
          centerTitle: true,
        ),
        body: Center(
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                            height: MediaQuery.of(context).size.height * 0.20),
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
                        SizedBox(
                          height: 50,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 25.0),
                          child: Container(
                            decoration: BoxDecoration(
                                color: Colors.grey[100],
                                border: Border.all(color: Colors.white),
                                borderRadius: BorderRadius.circular(12)),
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 20.0),
                              child: TextFormField(
                                validator: (val) => _validateEmail(val),
                                controller: _emailController,
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: 'Email',
                                  hintStyle: TextStyle(
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                style: TextStyle(fontSize: 15),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 10),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 25.0),
                          child: Container(
                            decoration: BoxDecoration(
                                color: Colors.grey[100],
                                border: Border.all(color: Colors.white),
                                borderRadius: BorderRadius.circular(12)),
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 20.0),
                              child: TextFormField(
                                validator: (val) => _validatePhoneNo(val),
                                controller: _phoneController,
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: 'Phone Number',
                                  hintStyle: TextStyle(
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                style: TextStyle(fontSize: 15),
                                keyboardType: TextInputType.number,
                                inputFormatters: [
                                  FilteringTextInputFormatter.digitsOnly,
                                ],
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 10),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 25.0),
                          child: Container(
                            decoration: BoxDecoration(
                                color: Colors.grey[100],
                                border: Border.all(color: Colors.white),
                                borderRadius: BorderRadius.circular(12)),
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 20.0),
                              child: TextFormField(
                                obscureText: true,
                                validator: (val) => _validatePassword(val),
                                controller: _passwordController,
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: 'Password',
                                  hintStyle: TextStyle(
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                style: TextStyle(fontSize: 15),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 10),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 25.0),
                          child: Container(
                            decoration: BoxDecoration(
                                color: Colors.grey[100],
                                border: Border.all(color: Colors.white),
                                borderRadius: BorderRadius.circular(12)),
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 20.0),
                              child: TextFormField(
                                obscureText: true,
                                validator: (val) =>
                                    _validateConfirmPassword(val),
                                controller: _confirmPasswordController,
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: 'Confirm Password',
                                  hintStyle: TextStyle(
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                style: TextStyle(fontSize: 15),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 20),
                      ],
                    ),
                  ),
                ),
                ClipRRect(
                  child: MaterialButton(
                    onPressed: _register,
                    minWidth: double.infinity,
                    height: 60,
                    color: COLOR_ORANGE,
                    child: (_auth?.isLoading ?? false)
                        ? CircularProgressIndicator(color: Colors.white)
                        : Text(
                            "Continue",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
