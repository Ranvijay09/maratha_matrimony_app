// ignore_for_file: prefer_const_constructors

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:maratha_matrimony_app/models/Auth.dart';
import 'package:maratha_matrimony_app/models/Database.dart';
import 'package:maratha_matrimony_app/models/UserModel.dart';
import 'package:maratha_matrimony_app/screens/BottomNavController.dart';
import 'package:maratha_matrimony_app/screens/DocumentsUploadScreen.dart';
import 'package:maratha_matrimony_app/screens/HomeScreen.dart';
import 'package:maratha_matrimony_app/screens/ScreenManager.dart';
import 'package:maratha_matrimony_app/utils/Constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';

class PhysicalAttributesScreen extends StatefulWidget {
  const PhysicalAttributesScreen({super.key});

  @override
  State<PhysicalAttributesScreen> createState() =>
      _PhysicalAttributesScreenState();
}

class _PhysicalAttributesScreenState extends State<PhysicalAttributesScreen> {
  AuthService? _auth;
  User? _user;
  final _formKey = GlobalKey<FormState>();

  final _heightController = TextEditingController();
  final _weightController = TextEditingController();

  String? _selectedBloodGroup;
  String? _selectedComplexion;
  String? _physicalStatus;
  String? _bodyType;
  String? _diet;
  String? _smoke;
  String? _drink;

  @override
  void dispose() {
    _heightController.dispose();
    _weightController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _user = Provider.of<User?>(context);
    _auth = Provider.of<AuthService>(context);
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.grey[300],
        appBar: AppBar(
          automaticallyImplyLeading: false,
          elevation: 0,
          foregroundColor: COLOR_BLACK,
          backgroundColor: Colors.grey[300],
          title: Text(
            'Physical Attributes',
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
                          height: 12,
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
                                validator: (val) {
                                  if (val!.isEmpty) {
                                    return "Please enter your height";
                                  }
                                  return null;
                                },
                                controller: _heightController,
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: 'Height in cm*',
                                  hintStyle: TextStyle(
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                style: TextStyle(fontSize: 15),
                                keyboardType: TextInputType.text,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 12,
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
                                validator: (val) {
                                  if (val!.isEmpty) {
                                    return "Please enter your weight";
                                  }
                                  return null;
                                },
                                controller: _weightController,
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: 'Weight in kg*',
                                  hintStyle: TextStyle(
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                style: TextStyle(fontSize: 15),
                                keyboardType: TextInputType.text,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 16),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 25.0),
                          child: DropdownButtonHideUnderline(
                            child: DropdownButtonFormField2(
                              decoration: InputDecoration(
                                isDense: true,
                                contentPadding: EdgeInsets.zero,
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15),
                                ),
                              ),
                              isExpanded: true,
                              hint: Text(
                                'Blood Group*',
                                style: TextStyle(
                                  fontSize: 15,
                                  color: COLOR_BLACK,
                                ),
                                overflow: TextOverflow.ellipsis,
                              ),
                              items: [
                                'A+',
                                'A-',
                                'B+',
                                'B-',
                                'AB+',
                                'AB-',
                                'O+',
                                'O-',
                              ]
                                  .map((item) => DropdownMenuItem<String>(
                                        value: item,
                                        child: Text(
                                          item,
                                          style: const TextStyle(
                                            fontSize: 15,
                                            color: COLOR_BLACK,
                                          ),
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ))
                                  .toList(),
                              value: _selectedBloodGroup,
                              validator: (value) {
                                if (value == null) {
                                  return 'Please select your blood group.';
                                }
                                return null;
                              },
                              onChanged: (value) {
                                setState(() {
                                  _selectedBloodGroup = value as String;
                                });
                              },
                              icon: const Icon(
                                FontAwesomeIcons.caretDown,
                                color: COLOR_BLACK,
                              ),
                              iconSize: 20,
                              iconEnabledColor: COLOR_BLACK,
                              iconDisabledColor: Colors.grey,
                              buttonHeight: 50,
                              buttonPadding: EdgeInsets.only(right: 20.0),
                              buttonDecoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12),
                                border: Border.all(color: Colors.white),
                                color: Colors.grey[100],
                              ),
                              itemHeight: 40,
                              dropdownMaxHeight: 200,
                              dropdownPadding:
                                  EdgeInsets.symmetric(horizontal: 25.0),
                              dropdownDecoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12),
                                color: Colors.grey[100],
                              ),
                              dropdownElevation: 8,
                              scrollbarRadius: const Radius.circular(40),
                              scrollbarThickness: 6,
                              scrollbarAlwaysShow: true,
                            ),
                          ),
                        ),
                        SizedBox(height: 20),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 25.0),
                          child: DropdownButtonHideUnderline(
                            child: DropdownButtonFormField2(
                              decoration: InputDecoration(
                                isDense: true,
                                contentPadding: EdgeInsets.zero,
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15),
                                ),
                              ),
                              isExpanded: true,
                              hint: Text(
                                'Complexion*',
                                style: TextStyle(
                                  fontSize: 15,
                                  color: COLOR_BLACK,
                                ),
                                overflow: TextOverflow.ellipsis,
                              ),
                              items: [
                                'Very Fair',
                                'Fair',
                                'Wheatish',
                                'Wheatish Medium',
                                'Wheatish Brown',
                                'Dark'
                              ]
                                  .map((item) => DropdownMenuItem<String>(
                                        value: item,
                                        child: Text(
                                          item,
                                          style: const TextStyle(
                                            fontSize: 15,
                                            color: COLOR_BLACK,
                                          ),
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ))
                                  .toList(),
                              value: _selectedComplexion,
                              validator: (value) {
                                if (value == null) {
                                  return 'Please select your complexion.';
                                }
                                return null;
                              },
                              onChanged: (value) {
                                setState(() {
                                  _selectedComplexion = value as String;
                                });
                              },
                              icon: const Icon(
                                FontAwesomeIcons.caretDown,
                                color: COLOR_BLACK,
                              ),
                              iconSize: 20,
                              iconEnabledColor: COLOR_BLACK,
                              iconDisabledColor: Colors.grey,
                              buttonHeight: 50,
                              buttonPadding: EdgeInsets.only(right: 20.0),
                              buttonDecoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12),
                                border: Border.all(color: Colors.white),
                                color: Colors.grey[100],
                              ),
                              itemHeight: 40,
                              dropdownMaxHeight: 200,
                              dropdownPadding:
                                  EdgeInsets.symmetric(horizontal: 25.0),
                              dropdownDecoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12),
                                color: Colors.grey[100],
                              ),
                              dropdownElevation: 8,
                              scrollbarRadius: const Radius.circular(40),
                              scrollbarThickness: 6,
                              scrollbarAlwaysShow: true,
                            ),
                          ),
                        ),
                        SizedBox(height: 20),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 25.0),
                          child: DropdownButtonHideUnderline(
                            child: DropdownButtonFormField2(
                              decoration: InputDecoration(
                                isDense: true,
                                contentPadding: EdgeInsets.zero,
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15),
                                ),
                              ),
                              isExpanded: true,
                              hint: Text(
                                'Physical Status*',
                                style: TextStyle(
                                  fontSize: 15,
                                  color: COLOR_BLACK,
                                ),
                                overflow: TextOverflow.ellipsis,
                              ),
                              items: ['Normal', 'Physically Challanged']
                                  .map((item) => DropdownMenuItem<String>(
                                        value: item,
                                        child: Text(
                                          item,
                                          style: const TextStyle(
                                            fontSize: 15,
                                            color: COLOR_BLACK,
                                          ),
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ))
                                  .toList(),
                              value: _physicalStatus,
                              validator: (value) {
                                if (value == null) {
                                  return 'Please select physical status.';
                                }
                                return null;
                              },
                              onChanged: (value) {
                                setState(() {
                                  _physicalStatus = value as String;
                                });
                              },
                              icon: const Icon(
                                FontAwesomeIcons.caretDown,
                                color: COLOR_BLACK,
                              ),
                              iconSize: 20,
                              iconEnabledColor: COLOR_BLACK,
                              iconDisabledColor: Colors.grey,
                              buttonHeight: 50,
                              buttonPadding: EdgeInsets.only(right: 20.0),
                              buttonDecoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12),
                                border: Border.all(color: Colors.white),
                                color: Colors.grey[100],
                              ),
                              itemHeight: 40,
                              dropdownMaxHeight: 200,
                              dropdownPadding:
                                  EdgeInsets.symmetric(horizontal: 25.0),
                              dropdownDecoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12),
                                color: Colors.grey[100],
                              ),
                              dropdownElevation: 8,
                              scrollbarRadius: const Radius.circular(40),
                              scrollbarThickness: 6,
                              scrollbarAlwaysShow: true,
                            ),
                          ),
                        ),
                        SizedBox(height: 20),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 25.0),
                          child: DropdownButtonHideUnderline(
                            child: DropdownButtonFormField2(
                              decoration: InputDecoration(
                                isDense: true,
                                contentPadding: EdgeInsets.zero,
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15),
                                ),
                              ),
                              isExpanded: true,
                              hint: Text(
                                'Body Type*',
                                style: TextStyle(
                                  fontSize: 15,
                                  color: COLOR_BLACK,
                                ),
                                overflow: TextOverflow.ellipsis,
                              ),
                              items: ['Slim', 'Average', 'Athletic', 'Heavy']
                                  .map((item) => DropdownMenuItem<String>(
                                        value: item,
                                        child: Text(
                                          item,
                                          style: const TextStyle(
                                            fontSize: 15,
                                            color: COLOR_BLACK,
                                          ),
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ))
                                  .toList(),
                              value: _bodyType,
                              validator: (value) {
                                if (value == null) {
                                  return 'Please select your body type.';
                                }
                                return null;
                              },
                              onChanged: (value) {
                                setState(() {
                                  _bodyType = value as String;
                                });
                              },
                              icon: const Icon(
                                FontAwesomeIcons.caretDown,
                                color: COLOR_BLACK,
                              ),
                              iconSize: 20,
                              iconEnabledColor: COLOR_BLACK,
                              iconDisabledColor: Colors.grey,
                              buttonHeight: 50,
                              buttonPadding: EdgeInsets.only(right: 20.0),
                              buttonDecoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12),
                                border: Border.all(color: Colors.white),
                                color: Colors.grey[100],
                              ),
                              itemHeight: 40,
                              dropdownMaxHeight: 200,
                              dropdownPadding:
                                  EdgeInsets.symmetric(horizontal: 25.0),
                              dropdownDecoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12),
                                color: Colors.grey[100],
                              ),
                              dropdownElevation: 8,
                              scrollbarRadius: const Radius.circular(40),
                              scrollbarThickness: 6,
                              scrollbarAlwaysShow: true,
                            ),
                          ),
                        ),
                        SizedBox(height: 20),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 25.0),
                          child: DropdownButtonHideUnderline(
                            child: DropdownButtonFormField2(
                              decoration: InputDecoration(
                                isDense: true,
                                contentPadding: EdgeInsets.zero,
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15),
                                ),
                              ),
                              isExpanded: true,
                              hint: Text(
                                'Diet*',
                                style: TextStyle(
                                  fontSize: 15,
                                  color: COLOR_BLACK,
                                ),
                                overflow: TextOverflow.ellipsis,
                              ),
                              items: [
                                'Vegetarian',
                                'Eggetarian',
                                'Occasionally Non-Veg',
                                'Non-Vegetarian',
                                'Jain',
                                'Vegan'
                              ]
                                  .map((item) => DropdownMenuItem<String>(
                                        value: item,
                                        child: Text(
                                          item,
                                          style: const TextStyle(
                                            fontSize: 15,
                                            color: COLOR_BLACK,
                                          ),
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ))
                                  .toList(),
                              value: _diet,
                              validator: (value) {
                                if (value == null) {
                                  return 'Please select your diet.';
                                }
                                return null;
                              },
                              onChanged: (value) {
                                setState(() {
                                  _diet = value as String;
                                });
                              },
                              icon: const Icon(
                                FontAwesomeIcons.caretDown,
                                color: COLOR_BLACK,
                              ),
                              iconSize: 20,
                              iconEnabledColor: COLOR_BLACK,
                              iconDisabledColor: Colors.grey,
                              buttonHeight: 50,
                              buttonPadding: EdgeInsets.only(right: 20.0),
                              buttonDecoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12),
                                border: Border.all(color: Colors.white),
                                color: Colors.grey[100],
                              ),
                              itemHeight: 40,
                              dropdownMaxHeight: 200,
                              dropdownPadding:
                                  EdgeInsets.symmetric(horizontal: 25.0),
                              dropdownDecoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12),
                                color: Colors.grey[100],
                              ),
                              dropdownElevation: 8,
                              scrollbarRadius: const Radius.circular(40),
                              scrollbarThickness: 6,
                              scrollbarAlwaysShow: true,
                            ),
                          ),
                        ),
                        SizedBox(height: 20),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 25.0),
                          child: DropdownButtonHideUnderline(
                            child: DropdownButtonFormField2(
                              decoration: InputDecoration(
                                isDense: true,
                                contentPadding: EdgeInsets.zero,
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15),
                                ),
                              ),
                              isExpanded: true,
                              hint: Text(
                                'Smoke*',
                                style: TextStyle(
                                  fontSize: 15,
                                  color: COLOR_BLACK,
                                ),
                                overflow: TextOverflow.ellipsis,
                              ),
                              items: ['Yes', 'No']
                                  .map((item) => DropdownMenuItem<String>(
                                        value: item,
                                        child: Text(
                                          item,
                                          style: const TextStyle(
                                            fontSize: 15,
                                            color: COLOR_BLACK,
                                          ),
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ))
                                  .toList(),
                              value: _smoke,
                              validator: (value) {
                                if (value == null) {
                                  return 'Please select smoking status.';
                                }
                                return null;
                              },
                              onChanged: (value) {
                                setState(() {
                                  _smoke = value as String;
                                });
                              },
                              icon: const Icon(
                                FontAwesomeIcons.caretDown,
                                color: COLOR_BLACK,
                              ),
                              iconSize: 20,
                              iconEnabledColor: COLOR_BLACK,
                              iconDisabledColor: Colors.grey,
                              buttonHeight: 50,
                              buttonPadding: EdgeInsets.only(right: 20.0),
                              buttonDecoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12),
                                border: Border.all(color: Colors.white),
                                color: Colors.grey[100],
                              ),
                              itemHeight: 40,
                              dropdownMaxHeight: 200,
                              dropdownPadding:
                                  EdgeInsets.symmetric(horizontal: 25.0),
                              dropdownDecoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12),
                                color: Colors.grey[100],
                              ),
                              dropdownElevation: 8,
                              scrollbarRadius: const Radius.circular(40),
                              scrollbarThickness: 6,
                              scrollbarAlwaysShow: true,
                            ),
                          ),
                        ),
                        SizedBox(height: 20),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 25.0),
                          child: DropdownButtonHideUnderline(
                            child: DropdownButtonFormField2(
                              decoration: InputDecoration(
                                isDense: true,
                                contentPadding: EdgeInsets.zero,
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15),
                                ),
                              ),
                              isExpanded: true,
                              hint: Text(
                                'Drink*',
                                style: TextStyle(
                                  fontSize: 15,
                                  color: COLOR_BLACK,
                                ),
                                overflow: TextOverflow.ellipsis,
                              ),
                              items: ['Yes', 'No']
                                  .map((item) => DropdownMenuItem<String>(
                                        value: item,
                                        child: Text(
                                          item,
                                          style: const TextStyle(
                                            fontSize: 15,
                                            color: COLOR_BLACK,
                                          ),
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ))
                                  .toList(),
                              value: _drink,
                              validator: (value) {
                                if (value == null) {
                                  return 'Please select physical status.';
                                }
                                return null;
                              },
                              onChanged: (value) {
                                setState(() {
                                  _drink = value as String;
                                });
                              },
                              icon: const Icon(
                                FontAwesomeIcons.caretDown,
                                color: COLOR_BLACK,
                              ),
                              iconSize: 20,
                              iconEnabledColor: COLOR_BLACK,
                              iconDisabledColor: Colors.grey,
                              buttonHeight: 50,
                              buttonPadding: EdgeInsets.only(right: 20.0),
                              buttonDecoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12),
                                border: Border.all(color: Colors.white),
                                color: Colors.grey[100],
                              ),
                              itemHeight: 40,
                              dropdownMaxHeight: 200,
                              dropdownPadding:
                                  EdgeInsets.symmetric(horizontal: 25.0),
                              dropdownDecoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12),
                                color: Colors.grey[100],
                              ),
                              dropdownElevation: 8,
                              scrollbarRadius: const Radius.circular(40),
                              scrollbarThickness: 6,
                              scrollbarAlwaysShow: true,
                            ),
                          ),
                        ),
                        SizedBox(height: 15)
                      ],
                    ),
                  ),
                ),
                ClipRRect(
                  child: MaterialButton(
                    onPressed: savePhysicalAttributesToDB,
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

  savePhysicalAttributesToDB() async {
    if (_formKey.currentState!.validate()) {
      await Database().addPhysicalAttributes(
        uid: _user!.uid,
        height: _heightController.text,
        weight: _weightController.text,
        bloodGroup: _selectedBloodGroup ?? '',
        complexion: _selectedComplexion ?? '',
        physicalStatus: _physicalStatus ?? '',
        bodyType: _bodyType ?? '',
        diet: _diet ?? '',
        smoke: _smoke ?? '',
        drink: _drink ?? '',
      );
      Navigator.of(context)
          .push(
            MaterialPageRoute(
              builder: (context) => DocumentsUploadScreen(),
            ),
          )
          .catchError((error) => print("something is wrong. $error"));
    }
  }
}
