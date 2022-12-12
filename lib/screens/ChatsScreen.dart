// ignore_for_file: prefer_const_constructors

import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:maratha_matrimony_app/widgets/ChatCardSkeleton.dart';
import 'package:maratha_matrimony_app/widgets/FillOutlineButton.dart';
import 'package:maratha_matrimony_app/models/Auth.dart';
import 'package:maratha_matrimony_app/models/ChatModel.dart';
import 'package:maratha_matrimony_app/models/Database.dart';
import 'package:maratha_matrimony_app/models/MyUser.dart';
import 'package:maratha_matrimony_app/models/UserModel.dart';
import 'package:maratha_matrimony_app/screens/MessagesScreen.dart';
import 'package:maratha_matrimony_app/utils/Constants.dart';
import 'package:maratha_matrimony_app/widgets/ChatCard.dart';
import 'package:maratha_matrimony_app/widgets/UserCard.dart';
import 'package:provider/provider.dart';

class ChatsScreen extends StatefulWidget {
  const ChatsScreen({super.key});

  @override
  State<ChatsScreen> createState() => _ChatsScreenState();
}

class _ChatsScreenState extends State<ChatsScreen> {
  User? _user;
  AuthService? _auth;
  String otherUid = "";

  int _currentMax = 15;
  int _loadMore = 10;
  ScrollController _scrollCtl = ScrollController();
  bool _allUsersLoaded = false;

  List<String> _chatUsersUid = [];
  int _selectedChatsScreenTab = 1;

  @override
  void initState() {
    _scrollCtl.addListener(() {
      if (_scrollCtl.position.pixels == _scrollCtl.position.maxScrollExtent) {
        setState(() {
          _currentMax += _loadMore;
        });
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    _user = Provider.of<User?>(context);
    _auth = Provider.of<AuthService>(context);
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Container(
                padding: EdgeInsets.fromLTRB(
                    kDefaultPadding, 0, kDefaultPadding, kDefaultPadding),
                color: kPrimaryColor,
                child: Row(
                  children: <Widget>[
                    FillOutlineButton(
                      press: () {
                        setState(() {
                          _selectedChatsScreenTab = 1;
                        });
                      },
                      text: "All Chats",
                      isFilled: _selectedChatsScreenTab == 1,
                    ),
                    SizedBox(width: kDefaultPadding),
                    FillOutlineButton(
                      press: () {
                        setState(() {
                          _selectedChatsScreenTab = 2;
                        });
                      },
                      text: "New Requests",
                      isFilled: _selectedChatsScreenTab == 2,
                    ),
                    SizedBox(width: kDefaultPadding),
                    FillOutlineButton(
                      press: () {
                        setState(() {
                          _selectedChatsScreenTab = 3;
                        });
                      },
                      text: "Sent Requests",
                      isFilled: _selectedChatsScreenTab == 3,
                    ),
                  ],
                ),
              ),
            ),
            _selectedChatsScreenTab == 1
                ? StreamBuilder<List<String>>(
                    stream: ChatModel.getChatUsers(_user!.uid),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        _chatUsersUid = snapshot.data!
                            .getRange(
                                0, min(_currentMax, snapshot.data!.length))
                            .toList();
                        if (_currentMax >= snapshot.data!.length) {
                          _allUsersLoaded = true;
                        }

                        if (_chatUsersUid.length == 0) {
                          return Expanded(
                            child: Center(
                              child: Text(
                                "No Chats Yet!",
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
                            controller: _scrollCtl,
                            itemCount: min(_chatUsersUid.length,
                                    snapshot.data!.length) +
                                1,
                            itemBuilder: (context, index) {
                              if (index == _chatUsersUid.length) {
                                return _allUsersLoaded
                                    ? Container()
                                    : Center(
                                        child: Container(
                                          padding: EdgeInsets.only(top: 20),
                                          height: 20,
                                          width: 20,
                                          child: CircularProgressIndicator(
                                              color: COLOR_ORANGE),
                                        ),
                                      );
                              }
                              return StreamBuilder<List<Chat>>(
                                  stream: ChatModel.getOneChat(
                                    UserModel.getCombinedUid(
                                        _user!.uid, _chatUsersUid[index]),
                                  ),
                                  builder: (context, oneChatSnap) {
                                    // Check if the top chat is read or not
                                    bool read = true;
                                    String latestMsg =
                                        'Tap to start conversation.';
                                    if (oneChatSnap.hasData &&
                                        oneChatSnap.data!.length > 0) {
                                      // the last message sent should not be bolded if the last message was sent by the current user.
                                      read = oneChatSnap.data![0].read ||
                                          oneChatSnap.data![0].uid ==
                                              _user!.uid;
                                      latestMsg = oneChatSnap.data![0].message;
                                    }
                                    return FutureBuilder<MyUser>(
                                        future:
                                            UserModel.getParticularUserDetails(
                                                _chatUsersUid[index]),
                                        builder: (context, snap) {
                                          if (snap.hasData) {
                                            MyUser curUser = snap.data!;
                                            return ChatCard(
                                              user: curUser,
                                              lastMessage: latestMsg,
                                              read: read,
                                              press: () => Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) =>
                                                      MessagesScreen(
                                                    user: _user!,
                                                    otherUid: curUser.uid,
                                                    otherName:
                                                        curUser.firstName +
                                                            ' ' +
                                                            curUser.lastName,
                                                    otherPhotoUrl:
                                                        curUser.photoUrl,
                                                    otherEmail: curUser.email,
                                                  ),
                                                ),
                                              ),
                                            );
                                          } else {
                                            return ListTile(
                                                title: ChatCardSkeleton());
                                          }
                                        });
                                  });
                            },
                          ),
                        );
                      }
                      return Center(
                          child:
                              CircularProgressIndicator(color: COLOR_ORANGE));
                    })
                : (_selectedChatsScreenTab == 2)
                    ? StreamBuilder<List<String>>(
                        stream: UserModel.getPendingRequests(_user!.uid),
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            List<String> _pendingRequestsIds = snapshot.data!;

                            if (_pendingRequestsIds.length == 0) {
                              return Expanded(
                                child: Center(
                                  child: Text(
                                    "No Pending Connection Requests!",
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
                                itemCount: _pendingRequestsIds.length,
                                itemBuilder: (context, index) {
                                  return FutureBuilder<MyUser>(
                                      future:
                                          UserModel.getParticularUserDetails(
                                              _pendingRequestsIds[index]),
                                      builder: (context, snap) {
                                        if (snap.hasData) {
                                          MyUser curUser = snap.data!;
                                          return UserCard(
                                            connectBtncolor: Color.fromARGB(
                                                255, 80, 191, 83),
                                            connectBtnText: 'Accept Request',
                                            pressConnectBtn: () async {
                                              await Database().acceptConnectReq(
                                                  userUid: _user!.uid,
                                                  otherUserUid:
                                                      _pendingRequestsIds[
                                                          index]);
                                              setState(() {
                                                _pendingRequestsIds = List.from(
                                                    _pendingRequestsIds)
                                                  ..removeAt(index);
                                              });
                                            },
                                            user: curUser,
                                          );
                                        } else {
                                          return ListTile(
                                              title: LinearProgressIndicator(
                                                  minHeight: 280,
                                                  color: COLOR_ORANGE));
                                        }
                                      });
                                },
                              ),
                            );
                          } else {
                            return Expanded(
                                child: Center(
                                    child: CircularProgressIndicator(
                                        color: COLOR_ORANGE)));
                          }
                        },
                      )
                    : StreamBuilder<List<String>>(
                        stream: UserModel.getSentRequests(_user!.uid),
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            List<String> _sentRequestsIds = snapshot.data!;

                            if (_sentRequestsIds.length == 0) {
                              return Expanded(
                                child: Center(
                                  child: Text(
                                    "No Sent Requests!",
                                    style: TextStyle(
                                      color: Color.fromARGB(255, 102, 102, 102),
                                      fontSize: 16,
                                    ),
                                  ),
                                ),
                              );
                            } else {
                              return Expanded(
                                child: ListView.builder(
                                  itemCount: _sentRequestsIds.length,
                                  itemBuilder: (context, index) {
                                    return FutureBuilder<MyUser>(
                                        future:
                                            UserModel.getParticularUserDetails(
                                                _sentRequestsIds[index]),
                                        builder: (context, snap) {
                                          if (snap.hasData) {
                                            MyUser curUser = snap.data!;
                                            return UserCard(
                                              connectBtnText: 'Cancel Request',
                                              connectBtncolor: Colors.red,
                                              pressConnectBtn: () async {
                                                await Database()
                                                    .cancelConnectReq(
                                                        userUid: _user!.uid,
                                                        otherUserUid:
                                                            _sentRequestsIds[
                                                                index]);
                                                setState(() {
                                                  _sentRequestsIds = List.from(
                                                      _sentRequestsIds)
                                                    ..removeAt(index);
                                                });
                                              },
                                              user: curUser,
                                            );
                                          } else {
                                            return ListTile(
                                                title: LinearProgressIndicator(
                                                    minHeight: 280,
                                                    color: COLOR_ORANGE));
                                          }
                                        });
                                  },
                                ),
                              );
                            }
                          } else {
                            return Expanded(
                                child: Center(
                                    child: CircularProgressIndicator(
                                        color: COLOR_ORANGE)));
                          }
                        },
                      ),
          ],
        ),
      ),
    );
  }
}
