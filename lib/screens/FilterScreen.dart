// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, use_build_context_synchronously

import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:maratha_matrimony_app/models/Auth.dart';
import 'package:maratha_matrimony_app/models/MyFilter.dart';
import 'package:maratha_matrimony_app/models/UserModel.dart';
import 'package:maratha_matrimony_app/screens/BasicInfoScreen.dart';
import 'package:maratha_matrimony_app/screens/BottomNavController.dart';
import 'package:maratha_matrimony_app/screens/HomeScreen.dart';
import 'package:maratha_matrimony_app/screens/ScreenManager.dart';
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

  RangeValues? _ageRangeValues;

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
            Form(
              key: _formKey,
              child: FutureBuilder<MyFilter>(
                  future: UserModel.getMyFilters(_user!.uid),
                  builder: (context, snap) {
                    if (snap.hasData) {
                      MyFilter myfilters = snap.data!;
                      _ageRangeValues =
                          RangeValues(myfilters.ageMin, myfilters.ageMax);
                      return Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: 20,
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 15.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("Age"),
                                  SizedBox(height: 5),
                                  RangeSlider(
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
                                ],
                              ),
                            ),
                            SizedBox(height: 10),
                            SizedBox(height: 20),
                          ],
                        ),
                      );
                    } else {
                      return Expanded(
                          child: Center(child: CircularProgressIndicator()));
                    }
                  }),
            ),
            ClipRRect(
              child: MaterialButton(
                onPressed: () {},
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
