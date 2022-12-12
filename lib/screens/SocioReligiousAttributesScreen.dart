// ignore_for_file: prefer_const_constructors

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:maratha_matrimony_app/models/Auth.dart';
import 'package:maratha_matrimony_app/models/Database.dart';
import 'package:maratha_matrimony_app/models/UserModel.dart';
import 'package:maratha_matrimony_app/screens/ScreenManager.dart';
import 'package:maratha_matrimony_app/screens/HomeScreen.dart';
import 'package:maratha_matrimony_app/screens/PhysicalAttributesScreen.dart';
import 'package:maratha_matrimony_app/utils/Constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';

class SocioReligiousAttributesScreen extends StatefulWidget {
  const SocioReligiousAttributesScreen({super.key});

  @override
  State<SocioReligiousAttributesScreen> createState() =>
      _SocioReligiousAttributesScreenState();
}

class _SocioReligiousAttributesScreenState
    extends State<SocioReligiousAttributesScreen> {
  AuthService? _auth;
  User? _user;
  final _formKey = GlobalKey<FormState>();

  final _gothraController = TextEditingController();
  final _cityController = TextEditingController();
  final _tehsilController = TextEditingController();
  final _birthTimeController = TextEditingController();

  int _curState = -1;
  int _curDistrict = -1;
  String? _selectedBirthDistrict;
  String? _selectedBirthState;
  TimeOfDay? _selectedBirthTime;
  String? _selectedRashi;
  String? _horosMatch;
  String? _manglik;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _gothraController.dispose();
    _cityController.dispose();
    _tehsilController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _user = Provider.of<User?>(context);
    _auth = Provider.of<AuthService>(context);
    return WillPopScope(
      onWillPop: () async => false,
      child: SafeArea(
        child: Scaffold(
          backgroundColor: Colors.grey[300],
          appBar: AppBar(
            automaticallyImplyLeading: false,
            elevation: 0,
            foregroundColor: COLOR_BLACK,
            backgroundColor: Colors.grey[300],
            title: Text(
              'Socio Religious Attributes',
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
                            padding:
                                const EdgeInsets.symmetric(horizontal: 25.0),
                            child: Container(
                              decoration: BoxDecoration(
                                  color: Colors.grey[100],
                                  border: Border.all(color: Colors.white),
                                  borderRadius: BorderRadius.circular(12)),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 20.0),
                                child: TextFormField(
                                  validator: (val) {
                                    if (val!.isEmpty) {
                                      return "Please enter your gothra";
                                    }
                                    return null;
                                  },
                                  controller: _gothraController,
                                  decoration: InputDecoration(
                                    border: InputBorder.none,
                                    hintText: 'Gothra*',
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
                            padding:
                                const EdgeInsets.symmetric(horizontal: 25.0),
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
                                  'Rashi*',
                                  style: TextStyle(
                                    fontSize: 15,
                                    color: COLOR_BLACK,
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                ),
                                items: [
                                  'Aries मेष राशि',
                                  'Taurus वृषभ राशि',
                                  'Gemini मिथुन राशि',
                                  'Cancer कर्क राशि',
                                  'Leo सिंह राशि',
                                  'Virgo कन्या राशि',
                                  'Libra तुला राशि',
                                  'Scorpio वृश्चिक राशि',
                                  'Saggitarius धनु राशि',
                                  'Capricorn मकर राशि',
                                  'Aquarius कुम्भ राशि',
                                  'Pisces मीन राशि',
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
                                value: _selectedRashi,
                                validator: (value) {
                                  if (value == null) {
                                    return 'Please select your rashi.';
                                  }
                                  return null;
                                },
                                onChanged: (value) {
                                  setState(() {
                                    _selectedRashi = value as String;
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
                            padding:
                                const EdgeInsets.symmetric(horizontal: 25.0),
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
                                  'Horos Match*',
                                  style: TextStyle(
                                    fontSize: 15,
                                    color: COLOR_BLACK,
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                ),
                                items: ['Not Applicable', 'Yes', 'No']
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
                                value: _horosMatch,
                                validator: (value) {
                                  if (value == null) {
                                    return 'Please select horos match.';
                                  }
                                  return null;
                                },
                                onChanged: (value) {
                                  setState(() {
                                    _horosMatch = value as String;
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
                            padding:
                                const EdgeInsets.symmetric(horizontal: 25.0),
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
                                  'Manglik*',
                                  style: TextStyle(
                                    fontSize: 15,
                                    color: COLOR_BLACK,
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                ),
                                items: ['Not Applicable', 'Yes', 'No']
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
                                value: _manglik,
                                validator: (value) {
                                  if (value == null) {
                                    return 'Please select maglik status.';
                                  }
                                  return null;
                                },
                                onChanged: (value) {
                                  setState(() {
                                    _manglik = value as String;
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
                          FutureBuilder(
                            future: _getStatesData(),
                            builder: (context, snapshot) {
                              List states = [
                                {
                                  "state_id": -1,
                                  "state_name": "Select a birth state",
                                }
                              ];
                              if (snapshot.hasData) {
                                dynamic data = snapshot.data;
                                states.addAll(data);
                              }
                              return Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 25.0),
                                child: DropdownButtonHideUnderline(
                                  child: DropdownButtonFormField2<int>(
                                    decoration: InputDecoration(
                                      isDense: true,
                                      contentPadding: EdgeInsets.zero,
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(15),
                                      ),
                                    ),
                                    isExpanded: true,
                                    hint: Text(
                                      'State*',
                                      style: TextStyle(
                                        fontSize: 15,
                                        color: COLOR_BLACK,
                                      ),
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    value: _curState,
                                    items: states
                                        .map((state) => DropdownMenuItem<int>(
                                              value: state["state_id"],
                                              child: Text(
                                                state['state_name'],
                                                style: const TextStyle(
                                                  fontSize: 15,
                                                  color: COLOR_BLACK,
                                                ),
                                              ),
                                            ))
                                        .toList(),
                                    validator: (val) {
                                      if (val! <= 0)
                                        return "Please select your birth state.";
                                    },
                                    onChanged: (newVal) {
                                      setState(() {
                                        _curState = newVal!;
                                        // We have to reset current district so that there is no value in it after state changes
                                        _curDistrict = -1;
                                      });
                                      if (_curState > 0) {
                                        _selectedBirthState =
                                            states[_curState]["state_name"];
                                      } else
                                        _selectedBirthState = "";
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
                              );
                            },
                          ),
                          SizedBox(height: 20),
                          FutureBuilder(
                            future: _getDistrictsData(_curState),
                            builder: (context, snapshot) {
                              List districts = [
                                {
                                  "district_id": -1,
                                  "district_name": "Select a birth district",
                                }
                              ];
                              if (snapshot.hasData) {
                                dynamic data = snapshot.data;
                                districts.addAll(data);
                              }
                              return Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 25.0),
                                child: DropdownButtonHideUnderline(
                                  child: DropdownButtonFormField2<int>(
                                    decoration: InputDecoration(
                                      isDense: true,
                                      contentPadding: EdgeInsets.zero,
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(15),
                                      ),
                                    ),
                                    isExpanded: true,
                                    hint: Text(
                                      'District*',
                                      style: TextStyle(
                                        fontSize: 15,
                                        color: COLOR_BLACK,
                                      ),
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    value: _curDistrict,
                                    items: districts
                                        .map((district) =>
                                            DropdownMenuItem<int>(
                                              value: district["district_id"],
                                              child: Text(
                                                district['district_name'],
                                                style: const TextStyle(
                                                  fontSize: 15,
                                                  color: COLOR_BLACK,
                                                ),
                                              ),
                                            ))
                                        .toList(),
                                    validator: (val) {
                                      if (val! <= 0) {
                                        return "Please select your birth district.";
                                      }
                                      return null;
                                    },
                                    onChanged: (newVal) {
                                      setState(() {
                                        _curDistrict = newVal!;
                                      });
                                      if (_curDistrict >= 0) {
                                        districts.forEach((district) {
                                          if (district["district_id"] ==
                                              _curDistrict) {
                                            _selectedBirthDistrict =
                                                district["district_name"];
                                            return;
                                          }
                                        });
                                      } else
                                        _selectedBirthDistrict = "";
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
                              );
                            },
                          ),
                          SizedBox(height: 16),
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 25.0),
                            child: Container(
                              decoration: BoxDecoration(
                                  color: Colors.grey[100],
                                  border: Border.all(color: Colors.white),
                                  borderRadius: BorderRadius.circular(12)),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 20.0),
                                child: TextFormField(
                                  validator: (val) {
                                    if (val!.isEmpty) {
                                      return "Please enter your tehsil";
                                    }
                                    return null;
                                  },
                                  controller: _tehsilController,
                                  decoration: InputDecoration(
                                    border: InputBorder.none,
                                    hintText: 'Birth Tehsil*',
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
                          SizedBox(height: 12),
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 25.0),
                            child: Container(
                              decoration: BoxDecoration(
                                  color: Colors.grey[100],
                                  border: Border.all(color: Colors.white),
                                  borderRadius: BorderRadius.circular(12)),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 20.0),
                                child: TextFormField(
                                  validator: (val) {
                                    if (val!.isEmpty) {
                                      return "Please enter your city";
                                    }
                                    return null;
                                  },
                                  controller: _cityController,
                                  decoration: InputDecoration(
                                    border: InputBorder.none,
                                    hintText: 'Birth City*',
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
                          SizedBox(height: 12),
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 25.0),
                            child: Container(
                              decoration: BoxDecoration(
                                  color: Colors.grey[100],
                                  border: Border.all(color: Colors.white),
                                  borderRadius: BorderRadius.circular(12)),
                              child: Padding(
                                padding: const EdgeInsets.only(
                                    left: 20.0, right: 10),
                                child: TextFormField(
                                  validator: (val) {
                                    if (val!.isEmpty) {
                                      return "Please select your birth time";
                                    }
                                    return null;
                                  },
                                  controller: _birthTimeController,
                                  readOnly: true,
                                  decoration: InputDecoration(
                                    border: InputBorder.none,
                                    hintText: 'Time of Birth*',
                                    hintStyle: TextStyle(
                                      fontWeight: FontWeight.w500,
                                    ),
                                    suffixIcon: Icon(
                                      FontAwesomeIcons.clock,
                                      size: 20,
                                      color: COLOR_BLACK,
                                    ),
                                  ),
                                  style: TextStyle(fontSize: 15),
                                  onTap: () async {
                                    TimeOfDay? pickedTime =
                                        await showTimePicker(
                                      initialTime: TimeOfDay.now(),
                                      context: context,
                                    );
                                    if (pickedTime != null) {
                                      _selectedBirthTime = pickedTime;
                                      _birthTimeController.text =
                                          pickedTime.format(context);
                                    }
                                  },
                                ),
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
                      onPressed: saveSocioReligiousAttributesToDB,
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
      ),
    );
  }

  saveSocioReligiousAttributesToDB() async {
    if (_formKey.currentState!.validate()) {
      await Database().addSocioReligiousAttributes(
        uid: _user!.uid,
        gothra: _gothraController.text,
        rashi: _selectedRashi ?? '',
        horosMatch: _horosMatch ?? '',
        manglik: _manglik ?? '',
        time: _birthTimeController.text,
        city: _cityController.text,
        tehsil: _tehsilController.text,
        district: _selectedBirthDistrict ?? '',
        state: _selectedBirthState ?? '',
      );
      Navigator.of(context)
          .push(
            MaterialPageRoute(
              builder: (context) => PhysicalAttributesScreen(),
            ),
          )
          .catchError((error) => print("something is wrong. $error"));
    }
  }

  Future<List> _getStatesData() async {
    var response = await rootBundle.loadString("assets/json/states.json");
    final data = await json.decode(response);
    return data["states"];
  }

  Future _getDistrictsData(int stateId) async {
    if (stateId <= 0) return [];
    var response = await rootBundle.loadString("assets/json/districts.json");
    final data1 = await json.decode(response);
    return (data1["districts"][stateId - 1]["districts"]);
  }
}
