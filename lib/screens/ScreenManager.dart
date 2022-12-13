// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:maratha_matrimony_app/models/Auth.dart';
import 'package:maratha_matrimony_app/models/MyUser.dart';
import 'package:maratha_matrimony_app/screens/HomeScreen.dart';
import 'package:maratha_matrimony_app/screens/BookmarksScreen.dart';
import 'package:maratha_matrimony_app/screens/ChatsScreen.dart';
import 'package:maratha_matrimony_app/screens/AccountScreen.dart';
import 'package:maratha_matrimony_app/utils/Constants.dart';
import 'package:maratha_matrimony_app/widgets/TopAppBar.dart';
import 'package:provider/provider.dart';

class ScreenManager extends StatefulWidget {
  const ScreenManager({super.key});

  @override
  State<ScreenManager> createState() => _ScreenManagerState();
}

class _ScreenManagerState extends State<ScreenManager> {
  MyUser? loggedInUser;
  User? _user;
  final _pages = [
    HomeScreen(),
    BookmarksScreen(),
    ChatsScreen(),
    AccountScreen(),
  ];
  var _selectedTabIndex = 0;

  @override
  Widget build(BuildContext context) {
    _user = Provider.of<User?>(context);

    return WillPopScope(
      onWillPop: () async => false,
      child: SafeArea(
        child: Scaffold(
          appBar: _selectedTabIndex == 2
              ? chatAppBar()
              : TopAppBar(tab: _selectedTabIndex, userUid: _user!.uid),
          bottomNavigationBar: Container(
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
          ),
          body: _pages[_selectedTabIndex],
        ),
      ),
    );
  }

  AppBar chatAppBar() {
    return AppBar(
      elevation: 0,
      backgroundColor: kPrimaryColor,
      automaticallyImplyLeading: false,
      title: Text(
        "Chats",
        style: TextStyle(fontSize: 25),
      ),
    );
  }
}
