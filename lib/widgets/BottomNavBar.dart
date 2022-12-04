import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../utils/Constants.dart';

class BottomNavBar extends StatefulWidget {
  const BottomNavBar({super.key});

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  int _selectedTabIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(
        left: kDefaultPadding * 2,
        right: kDefaultPadding * 2,
      ),
      height: 56,
      color: Colors.white,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          IconButton(
            onPressed: () {
              setState(() {
                _selectedTabIndex = 0;
              });
            },
            icon: Icon(
              FontAwesomeIcons.userGroup,
              size: 20,
              color: _selectedTabIndex == 0
                  ? COLOR_ORANGE
                  : COLOR_BLACK.withOpacity(.4),
            ),
          ),
          IconButton(
            onPressed: () {
              setState(() {
                _selectedTabIndex = 1;
              });
            },
            icon: Icon(
              FontAwesomeIcons.solidBookmark,
              size: 20,
              color: _selectedTabIndex == 1
                  ? COLOR_ORANGE
                  : COLOR_BLACK.withOpacity(.4),
            ),
          ),
          IconButton(
            onPressed: () {
              setState(() {
                _selectedTabIndex = 2;
              });
            },
            icon: Icon(
              FontAwesomeIcons.solidComments,
              size: 20,
              color: _selectedTabIndex == 2
                  ? COLOR_ORANGE
                  : COLOR_BLACK.withOpacity(.4),
            ),
          ),
          IconButton(
            onPressed: () {
              setState(() {
                _selectedTabIndex = 3;
              });
            },
            icon: Icon(
              FontAwesomeIcons.solidUser,
              size: 20,
              color: _selectedTabIndex == 3
                  ? COLOR_ORANGE
                  : COLOR_BLACK.withOpacity(.4),
            ),
          ),
        ],
      ),
    );
  }
}
