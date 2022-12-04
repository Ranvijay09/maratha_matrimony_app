// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:maratha_matrimony_app/screens/UserDetailsScreen.dart';
import 'package:maratha_matrimony_app/utils/Constants.dart';

import '../models/MyUser.dart';

class UserCard extends StatelessWidget {
  final MyUser user;
  final VoidCallback pressBookmarkBtn;
  final bool bookmarked;
  const UserCard(
      {super.key,
      required this.user,
      required this.pressBookmarkBtn,
      required this.bookmarked});

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

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
                  user.firstName + ' ' + user.lastName,
                  style: TextStyle(
                      color: COLOR_BLACK,
                      fontSize: 18,
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
                      Row(
                        children: [
                          Icon(
                            FontAwesomeIcons.cakeCandles,
                            size: 12,
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Text(
                            DateFormat('dd MMM, yyyy').format(user.dob),
                            style: TextStyle(
                              fontSize: 12,
                              color: COLOR_BLACK,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      Row(
                        children: [
                          Icon(
                            FontAwesomeIcons.locationPin,
                            size: 12,
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Text(
                            user.district + ' ' + user.state,
                            style: TextStyle(
                              fontSize: 12,
                              color: COLOR_BLACK,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      Row(
                        children: [
                          Icon(
                            FontAwesomeIcons.graduationCap,
                            size: 12,
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Text(
                            user.highestEducation,
                            style: TextStyle(
                              fontSize: 12,
                              color: COLOR_BLACK,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      Row(
                        children: [
                          Icon(
                            FontAwesomeIcons.bowlFood,
                            size: 12,
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Text(
                            user.diet,
                            style: TextStyle(
                              fontSize: 12,
                              color: COLOR_BLACK,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      Row(
                        children: [
                          Icon(
                            FontAwesomeIcons.om,
                            size: 12,
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Text(
                            user.rashi,
                            style: TextStyle(
                              fontSize: 12,
                              color: COLOR_BLACK,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      Row(
                        children: [
                          Icon(
                            FontAwesomeIcons.ring,
                            size: 12,
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Text(
                            user.maritalStatus,
                            style: TextStyle(
                              fontSize: 12,
                              color: COLOR_BLACK,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
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
                                user: user, isBookmarked: bookmarked);
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
                      Text(user.weight.toString() + 'kg | '),
                      Text(user.height.toString() + 'cm'),
                      SizedBox(
                        width: 3,
                      ),
                      IconButton(
                        onPressed: pressBookmarkBtn,
                        icon: Icon(
                          FontAwesomeIcons.solidBookmark,
                          size: 20,
                          color: bookmarked
                              ? COLOR_BLACK
                              : COLOR_BLACK.withOpacity(.4),
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
                        image: NetworkImage(user.photoUrl),
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
