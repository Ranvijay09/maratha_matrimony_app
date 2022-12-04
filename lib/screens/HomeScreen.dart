// ignore_for_file: prefer_const_constructors

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:maratha_matrimony_app/models/Database.dart';
import 'package:maratha_matrimony_app/models/UserModel.dart';
import 'package:maratha_matrimony_app/widgets/UserCard.dart';
import 'package:maratha_matrimony_app/models/MyUser.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({
    super.key,
  });

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  User? _user;
  MyUser? _loggedInUser;
  bool loading = false;

  @override
  void didChangeDependencies() async {
    _user = Provider.of<User?>(context);
    _loggedInUser = await UserModel.getParticularUserDetails(_user!.uid);
    loading = false;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return loading
        ? Center(child: CircularProgressIndicator())
        : Container(
            color: Colors.grey[200],
            child: Column(
              children: [
                FutureBuilder<List<MyUser>>(
                  future: UserModel.getAllUsersForFeed(uid: _user!.uid),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      List<MyUser> _allUsers = snapshot.data!;
                      if (_allUsers.isEmpty) {
                        return Expanded(
                          child: Center(
                            child: Text(
                              "No Users Found!",
                              style: TextStyle(
                                color: Color.fromARGB(255, 102, 102, 102),
                                fontSize: 16,
                              ),
                            ),
                          ),
                        );
                      }

                      return StreamBuilder<List<String>>(
                          stream: UserModel.getBookmarks(_user!.uid),
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              List<String> _bookmarkIds = snapshot.data!;

                              return Expanded(
                                child: ListView.builder(
                                  itemCount: _allUsers.length,
                                  itemBuilder: (context, index) {
                                    return UserCard(
                                        pressConnectBtn: () async {
                                          await Database().sendConnectReq(
                                              userUid: _user!.uid,
                                              otherUserUid:
                                                  _allUsers[index].uid);
                                          _allUsers.remove(_allUsers[index]);
                                        },
                                        bookmarked: _bookmarkIds
                                            .contains(_allUsers[index].uid),
                                        user: _allUsers[index],
                                        pressBookmarkBtn: () async {
                                          await Database().bookmarkUser(
                                              userUid: _user!.uid,
                                              bookmarkUserUid:
                                                  _allUsers[index].uid);
                                          _allUsers.remove(_allUsers[index]);
                                        });
                                  },
                                ),
                              );
                            } else {
                              return SizedBox();
                            }
                          });
                    } else {
                      return Expanded(
                        child: Center(
                          child: CircularProgressIndicator(),
                        ),
                      );
                    }
                  },
                ),
              ],
            ),
          );
  }
}
