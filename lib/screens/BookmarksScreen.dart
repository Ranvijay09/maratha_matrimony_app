// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:maratha_matrimony_app/models/UserModel.dart';
import 'package:maratha_matrimony_app/screens/HomeScreen.dart';
import 'package:maratha_matrimony_app/utils/Constants.dart';
import 'package:maratha_matrimony_app/widgets/UserCard.dart';
import 'package:maratha_matrimony_app/models/MyUser.dart';
import 'package:maratha_matrimony_app/models/database.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BookmarksScreen extends StatefulWidget {
  const BookmarksScreen({super.key});

  @override
  State<BookmarksScreen> createState() => _BookmarksScreenState();
}

class _BookmarksScreenState extends State<BookmarksScreen> {
  User? _user;

  @override
  Widget build(BuildContext context) {
    _user = Provider.of<User?>(context);
    return Container(
      color: Colors.grey[200],
      child: Column(
        children: [
          StreamBuilder<List<String>>(
              stream: UserModel.getBookmarks(_user!.uid),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  List<String> _bookmarkIds = snapshot.data!;

                  if (_bookmarkIds.length == 0) {
                    return Expanded(
                      child: Center(
                        child: Text(
                          "No Bookmarks yet!",
                          style: TextStyle(
                            color: Color.fromARGB(255, 102, 102, 102),
                            fontSize: 16,
                          ),
                        ),
                      ),
                    );
                  }
                  return Expanded(
                    child: ListView.builder(
                      itemCount: _bookmarkIds.length,
                      itemBuilder: (context, index) {
                        return FutureBuilder<MyUser>(
                            future: UserModel.getParticularUserDetails(
                                _bookmarkIds[index]),
                            builder: (context, snap) {
                              if (snap.hasData) {
                                MyUser curUser = snap.data!;
                                return UserCard(
                                  pressConnectBtn: () {},
                                  user: curUser,
                                );
                              } else {
                                return ListTile(
                                  title: LinearProgressIndicator(),
                                );
                              }
                            });
                      },
                    ),
                  );
                } else {
                  return Expanded(
                      child: Center(child: CircularProgressIndicator()));
                }
              }),
        ],
      ),
    );
  }
}
