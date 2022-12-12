// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, prefer_interpolation_to_compose_strings

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
  final VoidCallback pressConnectBtn;

  final String connectBtnText;
  final Color connectBtncolor;
  const UserCard({
    super.key,
    required this.user,
    required this.pressConnectBtn,
    this.connectBtnText = 'Connect Request',
    this.connectBtncolor = COLOR_ORANGE,
  });

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return Container(
      margin: EdgeInsets.only(
        top: kDefaultPadding / 2,
      ),
      padding: EdgeInsets.only(
        top: 10,
        bottom: 3,
        left: 15,
        right: 15,
      ),
      height: (((size.width / 2) - 15) * 1.1) + 100,
      decoration: BoxDecoration(color: COLOR_WHITE),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            width: size.width / 2 - 15,
            padding: EdgeInsets.only(right: 2),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        user.firstName + ' ' + user.lastName,
                        style: TextStyle(
                            color: COLOR_BLACK,
                            fontSize: 18,
                            fontWeight: FontWeight.bold),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
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
                              fontSize: 13,
                              color: COLOR_BLACK,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Icon(
                            FontAwesomeIcons.locationPin,
                            size: 12,
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Text(
                            user.district,
                            style: TextStyle(
                              fontSize: 13,
                              color: COLOR_BLACK,
                            ),
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
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
                              fontSize: 13,
                              color: COLOR_BLACK,
                            ),
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
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
                              fontSize: 13,
                              color: COLOR_BLACK,
                            ),
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
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
                              fontSize: 13,
                              color: COLOR_BLACK,
                            ),
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
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
                              fontSize: 13,
                              color: COLOR_BLACK,
                            ),
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                ClipRRect(
                  borderRadius: BorderRadius.circular(15),
                  child: MaterialButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) {
                            return UserDetailsScreen(userUid: user.uid);
                          },
                        ),
                      );
                    },
                    minWidth: double.infinity,
                    height: 50,
                    color: COLOR_WHITE.withOpacity(.6),
                    child: Text(
                      'More Info',
                      style: TextStyle(
                        color: COLOR_ORANGE,
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 5),
              ],
            ),
          ),
          Container(
            width: size.width / 2 - 15,
            padding: EdgeInsets.only(left: 2),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text(user.weight.toString() + 'kg | '),
                            Text(user.height.toString() + 'cm'),
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
                            borderRadius: BorderRadius.circular(15),
                          ),
                        ),
                      ],
                    ),
                  ),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(15),
                    child: MaterialButton(
                      onPressed: pressConnectBtn,
                      minWidth: double.infinity,
                      height: 50,
                      color: connectBtncolor,
                      child: Text(
                        connectBtnText,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                ]),
          ),
        ],
      ),
    );
  }
}
