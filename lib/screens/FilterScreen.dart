// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, use_build_context_synchronously

import 'package:another_flushbar/flushbar.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:maratha_matrimony_app/models/Auth.dart';
import 'package:maratha_matrimony_app/models/MyFilter.dart';
import 'package:maratha_matrimony_app/models/UserModel.dart';
import 'package:maratha_matrimony_app/screens/BasicInfoScreen.dart';
import 'package:maratha_matrimony_app/screens/ScreenManager.dart';
import 'package:maratha_matrimony_app/screens/HomeScreen.dart';
import 'package:maratha_matrimony_app/screens/AuthManager.dart';
import 'package:maratha_matrimony_app/utils/Constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';

class FilterScreen extends StatefulWidget {
  const FilterScreen({super.key});

  @override
  State<FilterScreen> createState() => _FilterScreenState();
}

class _FilterScreenState extends State<FilterScreen> {
  AuthService? _auth;
  User? _user;
  final _formKey = GlobalKey<FormState>();

  MyFilter? myfilters;
  RangeValues? _ageRangeValues;
  List<String>? _maritalStatus;
  List<String>? _highestEducation;
  List<String>? _occupation;
  List<String>? _annualIncome;

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size _size = MediaQuery.of(context).size;
    _auth = Provider.of<AuthService>(context);
    _user = Provider.of<User>(context);
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
          backgroundColor: COLOR_WHITE,
          title: Text(
            'Set Preferences',
            style: TextStyle(
              fontSize: 20,
            ),
          ),
          centerTitle: true,
        ),
        body: Column(
          children: [
            FutureBuilder<MyFilter>(
                future: UserModel.getMyFilters(_user!.uid),
                builder: (context, snap) {
                  if (snap.hasData) {
                    myfilters = snap.data!;
                    _ageRangeValues =
                        RangeValues(myfilters!.ageMin, myfilters!.ageMax);
                    _maritalStatus = List.from(myfilters!.maritalStatus);
                    _highestEducation = List.from(myfilters!.highestEducation);
                    _occupation = List.from(myfilters!.occupation);
                    _annualIncome = List.from(myfilters!.annualIncome);
                    return Expanded(
                      child: SingleChildScrollView(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              SizedBox(height: 30),
                              Text("Age"),
                              SizedBox(height: 5),
                              RangeSlider(
                                activeColor: COLOR_ORANGE,
                                values: _ageRangeValues!,
                                min: 21,
                                max: 50,
                                divisions: 30,
                                labels: RangeLabels(
                                  _ageRangeValues!.start.round().toString(),
                                  _ageRangeValues!.end.round().toString(),
                                ),
                                onChanged: (RangeValues values) {
                                  setState(() {
                                    _ageRangeValues = values;
                                  });
                                },
                              ),
                              SizedBox(height: 30),
                              Text("Marital Status"),
                              SizedBox(height: 10),
                              SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    'Unmarried',
                                    'Widow/Widower',
                                    'Divorcee',
                                    'Separated'
                                  ]
                                      .asMap()
                                      .entries
                                      .map(
                                        (marital_status) => InkWell(
                                          onTap: () {
                                            if (_maritalStatus!.contains(
                                                marital_status.value)) {
                                              _maritalStatus!
                                                  .remove(marital_status.value);
                                            } else {
                                              _maritalStatus!
                                                  .add(marital_status.value);
                                            }
                                            print(_maritalStatus);
                                          },
                                          child: Container(
                                            margin: const EdgeInsets.all(10),
                                            padding: const EdgeInsets.symmetric(
                                              horizontal: 40,
                                              vertical: 10,
                                            ),
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(5.0),
                                              color: _maritalStatus!.contains(
                                                      marital_status.value)
                                                  ? COLOR_ORANGE
                                                  : Theme.of(context)
                                                      .primaryColor
                                                      .withAlpha(100),
                                            ),
                                            child: Text(
                                              marital_status.value,
                                              style: TextStyle(
                                                color: _maritalStatus!.contains(
                                                        marital_status.value)
                                                    ? COLOR_WHITE
                                                    : COLOR_BLACK,
                                              ),
                                            ),
                                          ),
                                        ),
                                      )
                                      .toList(),
                                ),
                              ),
                              SizedBox(height: 30),
                              Text("Highest Education"),
                              SizedBox(height: 10),
                              SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    'PhD',
                                    'Post Graduation',
                                    'Graduation',
                                    'Engg. Graduation',
                                    'Diploma',
                                    'HSC(12th)',
                                    'SSC(10th)'
                                  ]
                                      .asMap()
                                      .entries
                                      .map(
                                        (edu) => InkWell(
                                          onTap: () {
                                            if (_highestEducation!
                                                .contains(edu.value)) {
                                              _highestEducation!
                                                  .remove(edu.value);
                                            } else {
                                              _highestEducation!.add(edu.value);
                                            }
                                            print(_highestEducation);
                                          },
                                          child: Container(
                                            margin: const EdgeInsets.all(10),
                                            padding: const EdgeInsets.symmetric(
                                              horizontal: 40,
                                              vertical: 10,
                                            ),
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(5.0),
                                              color: _highestEducation!
                                                      .contains(edu.value)
                                                  ? COLOR_ORANGE
                                                  : Theme.of(context)
                                                      .primaryColor
                                                      .withAlpha(100),
                                            ),
                                            child: Text(
                                              edu.value,
                                              style: TextStyle(
                                                color: _highestEducation!
                                                        .contains(edu.value)
                                                    ? COLOR_WHITE
                                                    : COLOR_BLACK,
                                              ),
                                            ),
                                          ),
                                        ),
                                      )
                                      .toList(),
                                ),
                              ),
                              SizedBox(height: 30),
                              Text("Occupation"),
                              SizedBox(height: 10),
                              SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    'Service',
                                    'Business',
                                    'Service & Business'
                                  ]
                                      .asMap()
                                      .entries
                                      .map(
                                        (occ) => InkWell(
                                          onTap: () {
                                            if (_occupation!
                                                .contains(occ.value)) {
                                              _occupation!.remove(occ.value);
                                            } else {
                                              _occupation!.add(occ.value);
                                            }
                                            print(_occupation);
                                          },
                                          child: Container(
                                            margin: const EdgeInsets.all(10),
                                            padding: const EdgeInsets.symmetric(
                                              horizontal: 40,
                                              vertical: 10,
                                            ),
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(5.0),
                                              color: _occupation!
                                                      .contains(occ.value)
                                                  ? COLOR_ORANGE
                                                  : Theme.of(context)
                                                      .primaryColor
                                                      .withAlpha(100),
                                            ),
                                            child: Text(
                                              occ.value,
                                              style: TextStyle(
                                                color: _occupation!
                                                        .contains(occ.value)
                                                    ? COLOR_WHITE
                                                    : COLOR_BLACK,
                                              ),
                                            ),
                                          ),
                                        ),
                                      )
                                      .toList(),
                                ),
                              ),
                              SizedBox(height: 30),
                              Text("Annual Income"),
                              SizedBox(height: 10),
                              SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    'More than 50Lacs',
                                    '25-50Lacs',
                                    '10-25Lacs',
                                    '5-10Lacs',
                                    '1-5Lacs',
                                    'Less than 1Lacs',
                                  ]
                                      .asMap()
                                      .entries
                                      .map(
                                        (ai) => InkWell(
                                          onTap: () {
                                            if (_annualIncome!
                                                .contains(ai.value)) {
                                              _annualIncome!.remove(ai.value);
                                            } else {
                                              _annualIncome!.add(ai.value);
                                            }
                                            print(_annualIncome);
                                          },
                                          child: Container(
                                            margin: const EdgeInsets.all(10),
                                            padding: const EdgeInsets.symmetric(
                                              horizontal: 40,
                                              vertical: 10,
                                            ),
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(5.0),
                                              color: _annualIncome!
                                                      .contains(ai.value)
                                                  ? COLOR_ORANGE
                                                  : Theme.of(context)
                                                      .primaryColor
                                                      .withAlpha(100),
                                            ),
                                            child: Text(
                                              ai.value,
                                              style: TextStyle(
                                                color: _annualIncome!
                                                        .contains(ai.value)
                                                    ? COLOR_WHITE
                                                    : COLOR_BLACK,
                                              ),
                                            ),
                                          ),
                                        ),
                                      )
                                      .toList(),
                                ),
                              ),
                              SizedBox(height: 30)
                            ],
                          ),
                        ),
                      ),
                    );
                  } else {
                    return Expanded(
                        child: Center(
                            child: CircularProgressIndicator(
                                color: COLOR_ORANGE)));
                  }
                }),
            ClipRRect(
              child: MaterialButton(
                onPressed: () {
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(
                      builder: (context) => ScreenManager(),
                    ),
                  );
                },
                minWidth: double.infinity,
                height: 60,
                color: COLOR_ORANGE,
                child: Text(
                  "Apply Changes",
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
    );
  }
}
