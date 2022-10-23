// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:equatable/equatable.dart';

class User extends Equatable {
  final int id;
  final String name;
  final int age;
  final List<String> imageUrls;
  final String education;
  final String jobTitle;

  const User({
    required this.id,
    required this.name,
    required this.age,
    required this.imageUrls,
    required this.education,
    required this.jobTitle,
  });

  static List<User> users = [
    User(
      id: 1,
      name: 'Megha',
      age: 25,
      imageUrls: ['assets/images/680.jpg'],
      education: 'BCA',
      jobTitle: 'Software Developer',
    ),
    User(
      id: 2,
      name: 'Anushka',
      age: 23,
      imageUrls: ['assets/images/830.jpg'],
      education: 'MSc CS',
      jobTitle: 'Software Designer',
    ),
    User(
      id: 3,
      name: 'Prachi',
      age: 23,
      imageUrls: ['assets/images/1033.jpg'],
      education: 'MCA',
      jobTitle: 'Quality Analyst',
    ),
  ];

  @override
  List<Object?> get props => [
        id,
        name,
        age,
        imageUrls,
        education,
        jobTitle,
      ];
}
