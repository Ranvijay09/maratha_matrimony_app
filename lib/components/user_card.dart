// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:maratha_matrimony_app/screens/details/user_details_screen.dart';
import 'package:maratha_matrimony_app/utils/constants.dart';

import '../models/user_model.dart';

class UserCard extends StatelessWidget {
  final User user;

  const UserCard({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final ThemeData themeData = Theme.of(context);

    return Container(
      margin: EdgeInsets.only(
        top: kDefaultPadding / 2,
      ),
      padding: EdgeInsets.only(
        top: 10,
        left: 15,
        right: 15,
      ),
      height: (((size.width / 2) - 15) * 1.1) + 105,
      decoration: BoxDecoration(color: COLOR_WHITE),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            width: size.width / 2 - 15,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  user.name,
                  style: TextStyle(
                      color: COLOR_BLACK,
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 15,
                ),
                Container(
                  height: ((size.width / 2) - 15) * 1.1,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(user.education),
                      SizedBox(
                        height: 5,
                      ),
                      Text(user.jobTitle),
                      SizedBox(
                        height: 5,
                      ),
                      Text(user.education),
                      SizedBox(
                        height: 5,
                      ),
                      Text(user.jobTitle),
                    ],
                  ),
                ),
                SizedBox(height: 5),
                Padding(
                  padding: const EdgeInsets.only(right: 2),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) {
                            return UserDetailsScreen(
                              user: user,
                            );
                          },
                        ),
                      );
                    },
                    child: Container(
                      padding: EdgeInsets.all(7),
                      decoration: BoxDecoration(
                          border: Border.all(color: COLOR_ORANGE),
                          borderRadius: BorderRadius.circular(8)),
                      child: Center(
                        child: Text(
                          'More Info',
                          style: TextStyle(
                            color: COLOR_ORANGE,
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            width: size.width / 2 - 15,
            child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(user.age.toString() + ' Years | '),
                      Text(user.age.toString() + '\"'),
                      SizedBox(
                        width: 3,
                      ),
                      IconButton(
                        onPressed: () {},
                        icon: const Icon(
                          FontAwesomeIcons.solidBookmark,
                          color: COLOR_BLACK,
                          size: 16,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Container(
                    height: ((size.width / 2) - 15) * 1.1,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage(user.imageUrls[0]),
                        fit: BoxFit.cover,
                      ),
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  SizedBox(height: 5),
                  Padding(
                    padding: const EdgeInsets.only(left: 2),
                    child: Container(
                      padding: EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: COLOR_ORANGE,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Center(
                        child: Text(
                          'Connect Request',
                          style: TextStyle(
                            color: COLOR_WHITE,
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                          ),
                        ),
                      ),
                    ),
                  ),
                ]),
          ),
        ],
      ),
    );
  }
}
