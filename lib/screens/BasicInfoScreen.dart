// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, no_leading_underscores_for_local_identifiers

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:maratha_matrimony_app/models/Auth.dart';
import 'package:maratha_matrimony_app/models/Database.dart';
import 'package:maratha_matrimony_app/models/UserModel.dart';
import 'package:maratha_matrimony_app/screens/ScreenManager.dart';
import 'package:maratha_matrimony_app/screens/CurrentAddressScreen.dart';
import 'package:maratha_matrimony_app/screens/HomeScreen.dart';
import 'package:maratha_matrimony_app/utils/Constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';

class BasicInfoScreen extends StatefulWidget {
  const BasicInfoScreen({super.key});

  @override
  State<BasicInfoScreen> createState() => _BasicInfoScreenState();
}

class _BasicInfoScreenState extends State<BasicInfoScreen> {
  AuthService? _auth;
  User? _user;
  final _formKey = GlobalKey<FormState>();

  final _firstNameController = TextEditingController();
  final _middleNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _dobController = TextEditingController();
  final _subCastController = TextEditingController();
  final _educationStreamController = TextEditingController();

  final DateTime _today = DateTime.now();
  DateTime? _selectedDate;
  String? _gender;
  String? _maritalStatus;
  String? _noOfChildren = 'Not Applicable';
  String? _childrenLivingStatus = 'Not Applicable';
  String? _highestQualification;
  String? _occupation;
  String? _annualIncome;
  bool _isChildrenFieldsVisible = false;

  @override
  void dispose() {
    _firstNameController.dispose();
    _middleNameController.dispose();
    _lastNameController.dispose();
    _dobController.dispose();
    _subCastController.dispose();
    _educationStreamController.dispose();
    super.dispose();
  }

  void showSnackBar(String msg) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(msg),
      padding: EdgeInsets.all(20),
      behavior: SnackBarBehavior.floating,
    ));
  }

  @override
  Widget build(BuildContext context) {
    _user = Provider.of<User?>(context);
    _auth = Provider.of<AuthService>(context);
    return WillPopScope(
      onWillPop: () async => false,
      child: SafeArea(
        child: Scaffold(
          resizeToAvoidBottomInset: true,
          backgroundColor: Colors.grey[300],
          appBar: AppBar(
            automaticallyImplyLeading: false,
            elevation: 0,
            foregroundColor: COLOR_BLACK,
            backgroundColor: Colors.grey[300],
            title: Text(
              'Basic Info',
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
                            height: 10,
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
                                      return "Please enter your first name";
                                    }
                                    return null;
                                  },
                                  controller: _firstNameController,
                                  decoration: InputDecoration(
                                    border: InputBorder.none,
                                    hintText: 'First Name*',
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
                                      return "Please enter your middle name";
                                    }
                                    return null;
                                  },
                                  controller: _middleNameController,
                                  decoration: InputDecoration(
                                    border: InputBorder.none,
                                    hintText: 'Middle Name*',
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
                                      return "Please enter your last name";
                                    }
                                    return null;
                                  },
                                  controller: _lastNameController,
                                  decoration: InputDecoration(
                                    border: InputBorder.none,
                                    hintText: 'Last Name*',
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
                                      return "Please select your DOB";
                                    }
                                    return null;
                                  },
                                  controller: _dobController,
                                  readOnly: true,
                                  decoration: InputDecoration(
                                    border: InputBorder.none,
                                    hintText: 'Date of Birth*',
                                    hintStyle: TextStyle(
                                      fontWeight: FontWeight.w500,
                                    ),
                                    suffixIcon: Icon(
                                      FontAwesomeIcons.calendar,
                                      size: 20,
                                      color: COLOR_BLACK,
                                    ),
                                  ),
                                  style: TextStyle(fontSize: 15),
                                  onTap: () async {
                                    DateTime? date = await showDatePicker(
                                      context: context,
                                      initialDate: DateTime(_today.year - 21),
                                      firstDate: DateTime(_today.year - 100),
                                      lastDate: DateTime(_today.year - 21),
                                    );
                                    if (date != null) {
                                      _selectedDate = date;
                                      _dobController.text =
                                          "${date.day}/${date.month}/${date.year}";
                                    }
                                  },
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
                                  'Gender*',
                                  style: TextStyle(
                                    fontSize: 15,
                                    color: COLOR_BLACK,
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                ),
                                items: ['Male', 'Female']
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
                                value: _gender,
                                validator: (value) {
                                  if (value == null) {
                                    return 'Please select gender.';
                                  }
                                },
                                onChanged: (value) {
                                  setState(() {
                                    _gender = value as String;
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
                                  'Marital Status*',
                                  style: TextStyle(
                                    fontSize: 15,
                                    color: COLOR_BLACK,
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                ),
                                items: [
                                  'Unmarried',
                                  'Widow/Widower',
                                  'Divorcee',
                                  'Separated'
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
                                value: _maritalStatus,
                                validator: (value) {
                                  if (value == null) {
                                    return 'Please select marital status.';
                                  }
                                },
                                onChanged: (value) {
                                  setState(() {
                                    _maritalStatus = value as String;
                                    _isChildrenFieldsVisible =
                                        value != 'Unmarried' ? true : false;
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
                          SizedBox(
                              height: _maritalStatus == 'unmarried' ||
                                      _maritalStatus == null
                                  ? 14
                                  : 20),
                          Visibility(
                            visible: _isChildrenFieldsVisible,
                            child: Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 25.0),
                                  child: DropdownButtonHideUnderline(
                                    child: DropdownButtonFormField2(
                                      decoration: InputDecoration(
                                        isDense: true,
                                        contentPadding: EdgeInsets.zero,
                                        border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(15),
                                        ),
                                      ),
                                      isExpanded: true,
                                      hint: Text(
                                        'No of Children*',
                                        style: TextStyle(
                                          fontSize: 15,
                                          color: COLOR_BLACK,
                                        ),
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      items: [
                                        'Not Applicable',
                                        '1',
                                        '2',
                                        '3',
                                        '4',
                                        '4 & above'
                                      ]
                                          .map((item) =>
                                              DropdownMenuItem<String>(
                                                value: item,
                                                child: Text(
                                                  item,
                                                  style: const TextStyle(
                                                    fontSize: 15,
                                                    color: COLOR_BLACK,
                                                  ),
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                ),
                                              ))
                                          .toList(),
                                      value: _noOfChildren,
                                      validator: (value) {
                                        if (value == null &&
                                            _maritalStatus != 'Unmarried') {
                                          return 'This field is mandatory.';
                                        }
                                        return null;
                                      },
                                      onChanged: (value) {
                                        setState(() {
                                          _noOfChildren = value as String;
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
                                      buttonPadding:
                                          EdgeInsets.only(right: 20.0),
                                      buttonDecoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(12),
                                        border: Border.all(color: Colors.white),
                                        color: Colors.grey[100],
                                      ),
                                      itemHeight: 40,
                                      dropdownMaxHeight: 200,
                                      dropdownPadding: EdgeInsets.symmetric(
                                          horizontal: 25.0),
                                      dropdownDecoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(12),
                                        color: Colors.grey[100],
                                      ),
                                      dropdownElevation: 8,
                                      scrollbarRadius:
                                          const Radius.circular(40),
                                      scrollbarThickness: 6,
                                      scrollbarAlwaysShow: true,
                                    ),
                                  ),
                                ),
                                SizedBox(height: 20),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 25.0),
                                  child: DropdownButtonHideUnderline(
                                    child: DropdownButtonFormField2(
                                      decoration: InputDecoration(
                                        isDense: true,
                                        contentPadding: EdgeInsets.zero,
                                        border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(15),
                                        ),
                                      ),
                                      isExpanded: true,
                                      hint: Text(
                                        'Children Living Status*',
                                        style: TextStyle(
                                          fontSize: 15,
                                          color: COLOR_BLACK,
                                        ),
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      items: [
                                        'Not Applicable',
                                        'Living with me',
                                        'Not living with me',
                                      ]
                                          .map((item) =>
                                              DropdownMenuItem<String>(
                                                value: item,
                                                child: Text(
                                                  item,
                                                  style: const TextStyle(
                                                    fontSize: 15,
                                                    color: COLOR_BLACK,
                                                  ),
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                ),
                                              ))
                                          .toList(),
                                      value: _childrenLivingStatus,
                                      validator: (value) {
                                        if (value == null &&
                                            _maritalStatus != 'Unmarried') {
                                          return 'This field is mandatory.';
                                        }
                                        return null;
                                      },
                                      onChanged: (value) {
                                        setState(() {
                                          _childrenLivingStatus =
                                              value as String;
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
                                      buttonPadding:
                                          EdgeInsets.only(right: 20.0),
                                      buttonDecoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(12),
                                        border: Border.all(color: Colors.white),
                                        color: Colors.grey[100],
                                      ),
                                      itemHeight: 40,
                                      dropdownMaxHeight: 200,
                                      dropdownPadding: EdgeInsets.symmetric(
                                          horizontal: 25.0),
                                      dropdownDecoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(12),
                                        color: Colors.grey[100],
                                      ),
                                      dropdownElevation: 8,
                                      scrollbarRadius:
                                          const Radius.circular(40),
                                      scrollbarThickness: 6,
                                      scrollbarAlwaysShow: true,
                                    ),
                                  ),
                                ),
                                SizedBox(height: 14),
                              ],
                            ),
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
                                  controller: _subCastController,
                                  decoration: InputDecoration(
                                    border: InputBorder.none,
                                    hintText: 'Sub-Cast',
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
                                  'Highest Qualification*',
                                  style: TextStyle(
                                    fontSize: 15,
                                    color: COLOR_BLACK,
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                ),
                                items: [
                                  'PhD',
                                  'Post Graduation',
                                  'Graduation',
                                  'Engg. Graduation',
                                  'Diploma',
                                  'HSC(12th)',
                                  'SSC(10th)'
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
                                value: _highestQualification,
                                validator: (value) {
                                  if (value == null) {
                                    return 'Please select highest qualification.';
                                  }
                                },
                                onChanged: (value) {
                                  setState(() {
                                    _highestQualification = value as String;
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
                          SizedBox(height: 14),
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
                                  controller: _educationStreamController,
                                  decoration: InputDecoration(
                                    border: InputBorder.none,
                                    hintText: 'Education Stream',
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
                                  'Occupation*',
                                  style: TextStyle(
                                    fontSize: 15,
                                    color: COLOR_BLACK,
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                ),
                                items: [
                                  'Service',
                                  'Business',
                                  'Service & Business'
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
                                value: _occupation,
                                validator: (value) {
                                  if (value == null) {
                                    return 'Please select occupation.';
                                  }
                                },
                                onChanged: (value) {
                                  setState(() {
                                    _occupation = value as String;
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
                                  'Annual Income*',
                                  style: TextStyle(
                                    fontSize: 15,
                                    color: COLOR_BLACK,
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                ),
                                items: [
                                  'More than 50Lacs',
                                  '25-50Lacs',
                                  '10-25Lacs',
                                  '5-10Lacs',
                                  '1-5Lacs',
                                  'Less than 1Lacs',
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
                                value: _annualIncome,
                                validator: (value) {
                                  if (value == null) {
                                    return 'Please select annual income.';
                                  }
                                },
                                onChanged: (value) {
                                  setState(() {
                                    _annualIncome = value as String;
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
                          SizedBox(height: 16),
                        ],
                      ),
                    ),
                  ),
                  ClipRRect(
                    child: MaterialButton(
                      onPressed: saveBasicDataToDB,
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

  saveBasicDataToDB() async {
    if (_formKey.currentState!.validate()) {
      await Database().addBasicInfo(
        uid: _user!.uid,
        firstName: _firstNameController.text,
        middleName: _middleNameController.text,
        lastName: _lastNameController.text,
        gender: _gender ?? '',
        dob: _selectedDate ?? _today,
        maritalStatus: _maritalStatus ?? '',
        noOfChildren: _noOfChildren ?? '',
        childrenLivingStatus: _childrenLivingStatus ?? '',
        subCast: _subCastController.text,
        highestEducation: _highestQualification ?? '',
        educationStream: _educationStreamController.text,
        occupation: _occupation ?? '',
        annualIncome: _annualIncome ?? '',
      );
      Navigator.of(context)
          .push(
            MaterialPageRoute(
              builder: (context) => CurrentAddressScreen(),
            ),
          )
          .catchError((error) => print("something is wrong. $error"));
    }
  }
}
