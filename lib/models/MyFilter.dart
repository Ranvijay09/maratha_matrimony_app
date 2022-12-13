import 'package:cloud_firestore/cloud_firestore.dart';

class MyFilter {
  num ageMin;
  num ageMax;
  String gender;
  List<String> maritalStatus;
  List<String> highestEducation;
  List<String> occupation;
  List<String> annualIncome;

  MyFilter({
    this.ageMin = 21,
    this.ageMax = 50,
    this.gender = '',
    this.maritalStatus = const [
      'Unmarried',
      'Widow/Widower',
      'Divorcee',
      'Separated'
    ],
    this.highestEducation = const [
      'PhD',
      'Post Graduation',
      'Graduation',
      'Engg. Graduation',
      'Diploma',
      'HSC(12th)',
      'SSC(10th)'
    ],
    this.occupation = const ['Service', 'Business', 'Service & Business'],
    this.annualIncome = const [
      'More than 50Lacs',
      '25-50Lacs',
      '10-25Lacs',
      '5-10Lacs',
      '1-5Lacs',
      'Less than 1Lacs'
    ],
  });
}
