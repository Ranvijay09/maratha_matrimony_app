// ignore_for_file: prefer_const_constructors

import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:maratha_matrimony_app/components/FillOutlineButton.dart';
import 'package:maratha_matrimony_app/models/Auth.dart';
import 'package:maratha_matrimony_app/models/ChatModel.dart';
import 'package:maratha_matrimony_app/models/MyUser.dart';
import 'package:maratha_matrimony_app/models/UserModel.dart';
import 'package:maratha_matrimony_app/screens/MessagesScreen.dart';
import 'package:maratha_matrimony_app/utils/Constants.dart';
import 'package:maratha_matrimony_app/widgets/ChatCard.dart';
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
    return Scaffold(
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.fromLTRB(
                kDefaultPadding, 0, kDefaultPadding, kDefaultPadding),
            color: kPrimaryColor,
            child: Row(
              children: <Widget>[
                FillOutlineButton(
                  press: () {},
                  text: "All Chats",
                  isFilled: true,
                ),
                SizedBox(width: kDefaultPadding - 5),
                FillOutlineButton(
                  press: () {},
                  text: "New Requests",
                ),
                SizedBox(width: kDefaultPadding - 5),
                FillOutlineButton(
                  press: () {},
                  text: "Sent Requests",
                ),
              ],
            ),
          ),
          StreamBuilder<List<String>>(
              stream: ChatModel.getChatUsers(_user!.uid),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  _chatUsersUid = snapshot.data!
                      .getRange(0, min(_currentMax, snapshot.data!.length))
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
                      itemCount:
                          min(_chatUsersUid.length, snapshot.data!.length) + 1,
                      itemBuilder: (context, index) {
                        if (index == _chatUsersUid.length) {
                          return _allUsersLoaded
                              ? Container()
                              : Center(
                                  child: Container(
                                    padding: EdgeInsets.only(top: 20),
                                    height: 20,
                                    width: 20,
                                    child: CircularProgressIndicator(),
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
                              if (oneChatSnap.hasData &&
                                  oneChatSnap.data!.length > 0) {
                                // the last message sent should not be bolded if the last message was sent by the current user.
                                bool read = oneChatSnap.data![0].read ||
                                    oneChatSnap.data![0].uid == _user!.uid;
                                String latestMsg = oneChatSnap.data![0].message;
                                return FutureBuilder<MyUser>(
                                    future: UserModel.getParticularUserDetails(
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
                                                  const MessagesScreen(),
                                            ),
                                          ),
                                        );
                                        //   return ListTile(
                                        //     onTap: () {
                                        //       Navigator.push(
                                        //         context,
                                        //         MaterialPageRoute(
                                        //           builder: (context) =>
                                        //               const MessagesScreen(),
                                        //         ),
                                        //       );
                                        //     },
                                        //     leading: ClipOval(
                                        //       child: Material(
                                        //         color: Colors.white,
                                        //         child: CachedNetworkImage(
                                        //           imageUrl: curUser.photoUrl,
                                        //           progressIndicatorBuilder:
                                        //               (context, url,
                                        //                       downloadProgress) =>
                                        //                   CircularProgressIndicator(
                                        //             value:
                                        //                 downloadProgress.progress,
                                        //           ),
                                        //           errorWidget:
                                        //               (context, url, error) =>
                                        //                   Icon(Icons.error),
                                        //           fit: BoxFit.contain,
                                        //           width: 50,
                                        //           height: 50,
                                        //         ),
                                        //       ),
                                        //     ),
                                        //     title: Text(
                                        //       curUser.firstName,
                                        //       style: TextStyle(
                                        //         fontWeight: !read
                                        //             ? FontWeight.bold
                                        //             : null,
                                        //       ),
                                        //     ),
                                        //     subtitle: Text(
                                        //       latestMsg,
                                        //       style: TextStyle(
                                        //         fontWeight: !read
                                        //             ? FontWeight.bold
                                        //             : null,
                                        //       ),
                                        //       maxLines: 1,
                                        //       overflow: TextOverflow.ellipsis,
                                        //     ),
                                        // trailing: !read
                                        //     ? Container(
                                        //         height: 10,
                                        //         width: 10,
                                        //         decoration: BoxDecoration(
                                        //           shape: BoxShape.circle,
                                        //           color: Colors.red,
                                        //         ),
                                        //       )
                                        //     : SizedBox(),
                                        //   );
                                      } else {
                                        return ListTile(
                                          title: LinearProgressIndicator(),
                                        );
                                      }
                                    });
                              } else {
                                return Container(
                                  height: 300,
                                  alignment: Alignment.bottomCenter,
                                  child: Text(
                                    "No Messages yet!",
                                    style: TextStyle(
                                      color: Colors.grey,
                                      fontSize: 16,
                                    ),
                                  ),
                                );
                              }
                            });
                      },
                    ),
                  );
                }
                return Center(child: CircularProgressIndicator());
              }),
          // Expanded(
          //   child: ListView.builder(
          //     itemCount: chatsData.length,
          //     itemBuilder: (context, index) => ChatCard(
          //       chat: chatsData[index],
          //       press: () => Navigator.push(
          //         context,
          //         MaterialPageRoute(
          //           builder: (context) => const MessagesScreen(),
          //         ),
          //       ),
          //     ),
          //   ),
          // ),
        ],
      ),
    );
  }
}
