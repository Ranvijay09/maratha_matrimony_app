// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, use_build_context_synchronously

import 'package:another_flushbar/flushbar.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:maratha_matrimony_app/models/Auth.dart';
import 'package:maratha_matrimony_app/models/Database.dart';
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
  final String userUid;
  FilterScreen({super.key, required this.userUid});

  @override
  State<FilterScreen> createState() => _FilterScreenState();
}

class _FilterScreenState extends State<FilterScreen> {
  AuthService? _auth;
  User? _user;
  final _formKey = GlobalKey<FormState>();

  MyFilter? myfilters;

  @override
  void initState() {
    getFilters();
    super.initState();
  }

  getFilters() async {
    myfilters = await UserModel.getMyFilters(widget.userUid);
    setState(() {
      myfilters = myfilters;
    });
  }

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
            Expanded(
              child: myfilters == null
                  ? Center(
                      child: CircularProgressIndicator(color: COLOR_ORANGE))
                  : SingleChildScrollView(
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
                              values: RangeValues(myfilters!.ageMin.toDouble(),
                                  myfilters!.ageMax.toDouble()),
                              min: 21,
                              max: 50,
                              divisions: 30,
                              labels: RangeLabels(
                                myfilters!.ageMin.round().toString(),
                                myfilters!.ageMax.round().toString(),
                              ),
                              onChanged: (RangeValues values) {
                                setState(() {
                                  myfilters!.ageMin = values.start.round();
                                  myfilters!.ageMax = values.end.round();
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
                                          if (myfilters!.maritalStatus
                                              .contains(marital_status.value)) {
                                            setState(() {
                                              myfilters!.maritalStatus = List
                                                  .from(
                                                      myfilters!.maritalStatus)
                                                ..remove(marital_status.value);
                                            });
                                          } else {
                                            setState(() {
                                              myfilters!.maritalStatus =
                                                  List.from(
                                                      myfilters!.maritalStatus)
                                                    ..add(marital_status.value);
                                            });
                                          }
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
                                            color: myfilters!.maritalStatus
                                                    .contains(
                                                        marital_status.value)
                                                ? COLOR_ORANGE
                                                : Theme.of(context)
                                                    .primaryColor
                                                    .withAlpha(100),
                                          ),
                                          child: Text(
                                            marital_status.value,
                                            style: TextStyle(
                                              color: myfilters!.maritalStatus
                                                      .contains(
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
                                          if (myfilters!.highestEducation
                                              .contains(edu.value)) {
                                            setState(() {
                                              myfilters!.highestEducation =
                                                  List.from(myfilters!
                                                      .highestEducation)
                                                    ..remove(edu.value);
                                            });
                                          } else {
                                            setState(() {
                                              myfilters!.highestEducation =
                                                  List.from(myfilters!
                                                      .highestEducation)
                                                    ..add(edu.value);
                                            });
                                          }
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
                                            color: myfilters!.highestEducation
                                                    .contains(edu.value)
                                                ? COLOR_ORANGE
                                                : Theme.of(context)
                                                    .primaryColor
                                                    .withAlpha(100),
                                          ),
                                          child: Text(
                                            edu.value,
                                            style: TextStyle(
                                              color: myfilters!.highestEducation
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
                                          if (myfilters!.occupation
                                              .contains(occ.value)) {
                                            setState(() {
                                              myfilters!.occupation = List.from(
                                                  myfilters!.occupation)
                                                ..remove(occ.value);
                                            });
                                          } else {
                                            setState(() {
                                              myfilters!.occupation = List.from(
                                                  myfilters!.occupation)
                                                ..add(occ.value);
                                            });
                                          }
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
                                            color: myfilters!.occupation
                                                    .contains(occ.value)
                                                ? COLOR_ORANGE
                                                : Theme.of(context)
                                                    .primaryColor
                                                    .withAlpha(100),
                                          ),
                                          child: Text(
                                            occ.value,
                                            style: TextStyle(
                                              color: myfilters!.occupation
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
                                          if (myfilters!.annualIncome
                                              .contains(ai.value)) {
                                            setState(() {
                                              myfilters!.annualIncome = List
                                                  .from(myfilters!.annualIncome)
                                                ..remove(ai.value);
                                            });
                                          } else {
                                            setState(() {
                                              myfilters!.annualIncome = List
                                                  .from(myfilters!.annualIncome)
                                                ..add(ai.value);
                                            });
                                          }
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
                                            color: myfilters!.annualIncome
                                                    .contains(ai.value)
                                                ? COLOR_ORANGE
                                                : Theme.of(context)
                                                    .primaryColor
                                                    .withAlpha(100),
                                          ),
                                          child: Text(
                                            ai.value,
                                            style: TextStyle(
                                              color: myfilters!.annualIncome
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
            ),
            ClipRRect(
              child: MaterialButton(
                onPressed: () async {
                  await Database()
                      .setFilters(userUid: widget.userUid, filters: myfilters!);
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
