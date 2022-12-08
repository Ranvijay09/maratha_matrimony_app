// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:maratha_matrimony_app/models/Database.dart';
import 'package:maratha_matrimony_app/models/UserModel.dart';
import 'package:maratha_matrimony_app/utils/Constants.dart';
import 'package:provider/provider.dart';

import '../models/MyUser.dart';

class UserDetailsScreen extends StatefulWidget {
  final String userUid;

  const UserDetailsScreen({super.key, required this.userUid});

  @override
  State<UserDetailsScreen> createState() => _UserDetailsScreenState();
}

class _UserDetailsScreenState extends State<UserDetailsScreen> {
  bool isBookmarked = true;
  User? _user;
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    _user = Provider.of<User?>(context);
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
          leading: Padding(
            padding: const EdgeInsets.all(9.0),
            child: Container(
              decoration: BoxDecoration(
                color: COLOR_WHITE,
                borderRadius: BorderRadius.circular(30),
              ),
              child: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: Icon(
                  FontAwesomeIcons.chevronLeft,
                  size: 20,
                  color: COLOR_BLACK,
                ),
              ),
            ),
          ),
        ),
        extendBodyBehindAppBar: true,
        body: Column(
          children: [
            StreamBuilder<List<String>>(
                stream: UserModel.getBookmarks(_user!.uid),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    List<String> _bookmarkIds = snapshot.data!;

                    isBookmarked = _bookmarkIds.contains(widget.userUid);

                    return FutureBuilder<MyUser>(
                        future:
                            UserModel.getParticularUserDetails(widget.userUid),
                        builder: (context, snap) {
                          if (snap.hasData) {
                            MyUser curUser = snap.data!;
                            return SingleChildScrollView(
                              child: SizedBox(
                                height: size.width * 1.1,
                                child: Stack(
                                  children: [
                                    Container(
                                      decoration: BoxDecoration(
                                          image: DecorationImage(
                                            image:
                                                NetworkImage(curUser.photoUrl),
                                            fit: BoxFit.cover,
                                          ),
                                          borderRadius: BorderRadius.only(
                                              bottomLeft: Radius.circular(15),
                                              bottomRight:
                                                  Radius.circular(15))),
                                    ),
                                    Align(
                                      alignment: Alignment.bottomRight,
                                      child: Padding(
                                        padding: const EdgeInsets.all(9.0),
                                        child: Container(
                                          decoration: BoxDecoration(
                                            color: COLOR_WHITE,
                                            borderRadius:
                                                BorderRadius.circular(30),
                                          ),
                                          child: IconButton(
                                            onPressed: toggleBookmark,
                                            icon: Icon(
                                              FontAwesomeIcons.solidBookmark,
                                              size: 20,
                                              color: isBookmarked
                                                  ? COLOR_BLACK
                                                  : COLOR_BLACK.withOpacity(.4),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          } else {
                            return SizedBox();
                          }
                        });
                  } else {
                    return Expanded(
                        child: Center(child: CircularProgressIndicator()));
                  }
                }),
          ],
        ),
      ),
    );
  }

  toggleBookmark() async {
    if (await Database().checkIfUserIsAddedToBookmarks(
        uid1: _user!.uid, uid2: widget.userUid)) isBookmarked = !isBookmarked;
  }
}
