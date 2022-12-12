// ignore_for_file: prefer_const_constructors

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:maratha_matrimony_app/models/Database.dart';
import 'package:maratha_matrimony_app/models/UserModel.dart';
import 'package:maratha_matrimony_app/utils/Constants.dart';
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
  List<MyUser> _allUsers = [];

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
        ? Center(child: CircularProgressIndicator(color: COLOR_ORANGE))
        : Container(
            color: Colors.grey[200],
            child: Column(
              children: [
                FutureBuilder<List<MyUser>>(
                  future: UserModel.getAllUsersForFeed(uid: _user!.uid),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      _allUsers = snapshot.data!;
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

                      return Expanded(
                        child: ListView.builder(
                          itemCount: _allUsers.length,
                          itemBuilder: (context, index) {
                            return UserCard(
                              user: _allUsers[index],
                              pressConnectBtn: () async {
                                await Database().sendConnectReq(
                                    userUid: _user!.uid,
                                    otherUserUid: _allUsers[index].uid);
                                setState(() {
                                  _allUsers = List.from(_allUsers)
                                    ..removeAt(index);
                                });
                              },
                            );
                          },
                        ),
                      );
                    } else {
                      return Expanded(
                        child: Center(
                          child: CircularProgressIndicator(color: COLOR_ORANGE),
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
