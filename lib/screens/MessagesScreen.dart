// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:maratha_matrimony_app/models/ChatMessage.dart';
import 'package:maratha_matrimony_app/models/ChatModel.dart';
import 'package:maratha_matrimony_app/models/Database.dart';
import 'package:maratha_matrimony_app/models/UserModel.dart';
import 'package:maratha_matrimony_app/screens/UserDetailsScreen.dart';
import 'package:maratha_matrimony_app/utils/Constants.dart';

class MessagesScreen extends StatefulWidget {
  final User user;
  final String otherUid;
  final String otherName;
  final String otherEmail;

  final String otherPhotoUrl;

  const MessagesScreen({
    super.key,
    required this.user,
    required this.otherUid,
    required this.otherName,
    required this.otherPhotoUrl,
    required this.otherEmail,
  });

  @override
  State<MessagesScreen> createState() => _MessagesScreenState();
}

class _MessagesScreenState extends State<MessagesScreen> {
  String _combinedUid = "";
  ScrollController _scrollCtl = ScrollController();
  int _currentMax = 15;
  int _loadMore = 10;
  List<Chat> chats = [];
  bool _allChatsLoaded = false;
  bool _isMessageEmpty = true;

  Size? _size;

  TextEditingController _messageCtl = TextEditingController();

  bool _userIsAddedToMsgList = false;

  Database _db = Database();

  @override
  void initState() {
    _scrollCtl.addListener(() {
      if (_scrollCtl.position.pixels == _scrollCtl.position.maxScrollExtent) {
        setState(() {
          _currentMax += _loadMore;
        });
      }
    });
    _combinedUid = UserModel.getCombinedUid(widget.user.uid, widget.otherUid);
    super.initState();
  }

  @override
  void dispose() {
    _messageCtl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        appBar: buildAppBar(),
        body: Column(
          children: [
            Expanded(
              child: StreamBuilder<List<Chat>>(
                stream: ChatModel.getChats(_combinedUid),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    chats = snapshot.data!
                        .getRange(0, min(_currentMax, snapshot.data!.length))
                        .toList();
                    // Make messages as read
                    makeMessagesRead(_combinedUid, chats);
                    if (_currentMax >= snapshot.data!.length)
                      _allChatsLoaded = true;
                    if (chats.isNotEmpty) {
                      return ListView.builder(
                        controller: _scrollCtl,
                        reverse: true,
                        itemCount: min(chats.length, snapshot.data!.length) + 1,
                        itemBuilder: (context, index) {
                          if (index == chats.length) {
                            return _allChatsLoaded
                                ? Container()
                                : Center(
                                    child: Container(
                                      height: 20,
                                      width: 20,
                                      child: CircularProgressIndicator(
                                          color: COLOR_ORANGE),
                                    ),
                                  );
                          }
                          bool curUsersMsg =
                              chats[index].uid == widget.user.uid;
                          return ConstrainedBox(
                            constraints: BoxConstraints(
                              maxWidth: _size!.width * 0.8,
                            ),
                            child: Padding(
                              padding: EdgeInsets.all(8),
                              child: Row(
                                mainAxisAlignment: curUsersMsg
                                    ? MainAxisAlignment.end
                                    : MainAxisAlignment.start,
                                children: [
                                  Material(
                                    elevation: 8,
                                    borderRadius: BorderRadius.circular(10),
                                    color: curUsersMsg
                                        ? COLOR_ORANGE
                                        : Colors.white,
                                    child: Container(
                                      padding: EdgeInsets.symmetric(
                                          vertical: 4, horizontal: 12),
                                      color: Colors.transparent,
                                      child: Column(
                                        crossAxisAlignment: curUsersMsg
                                            ? CrossAxisAlignment.end
                                            : CrossAxisAlignment.start,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.symmetric(
                                                vertical: 10),
                                            child: ConstrainedBox(
                                              constraints: BoxConstraints(
                                                maxWidth: _size!.width * 0.8,
                                              ),
                                              child: Text(
                                                chats[index].message,
                                                textAlign: curUsersMsg
                                                    ? TextAlign.right
                                                    : null,
                                                style: TextStyle(
                                                  color: curUsersMsg
                                                      ? Colors.white
                                                      : null,
                                                  fontSize: 18,
                                                ),
                                              ),
                                            ),
                                          ),
                                          // Sent Time
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.end,
                                            children: [
                                              Text(
                                                _formatTimeTo12Hr(
                                                    chats[index].timestamp.hour,
                                                    chats[index]
                                                        .timestamp
                                                        .minute),
                                                style: TextStyle(
                                                  color: curUsersMsg
                                                      ? COLOR_WHITE
                                                      : Colors.grey,
                                                  fontWeight: FontWeight.w600,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      );
                    } else {
                      return Center(
                        child: Text(
                          "No chats available. Say hi!",
                          style: TextStyle(color: Colors.grey),
                        ),
                      );
                    }
                  }
                  return Center(
                    child: CircularProgressIndicator(color: COLOR_ORANGE),
                  );
                },
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(vertical: 10),
              padding: EdgeInsets.symmetric(horizontal: 5),
              color: Colors.transparent,
              child: ConstrainedBox(
                constraints: BoxConstraints(maxHeight: 150),
                child: Row(
                  children: [
                    Flexible(
                      child: Material(
                        elevation: 8,
                        borderRadius: BorderRadius.circular(30),
                        child: TextField(
                          controller: _messageCtl,
                          style: TextStyle(fontSize: 18),
                          maxLines: null,
                          onChanged: (val) {
                            if (val.trim().isEmpty) {
                              setState(() {
                                _isMessageEmpty = true;
                              });
                            } else {
                              setState(() {
                                _isMessageEmpty = false;
                              });
                            }
                          },
                          textInputAction: TextInputAction.newline,
                          decoration: InputDecoration(
                            hintText: "Write a message",
                            contentPadding: EdgeInsets.all(20),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(100),
                              borderSide: BorderSide.none,
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(100),
                              borderSide: BorderSide.none,
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 5),
                    _isMessageEmpty
                        ? SizedBox()
                        : GestureDetector(
                            onTap: _sendMessage,
                            child: Container(
                              width: 55,
                              height: 55,
                              padding: EdgeInsets.only(left: 3),
                              decoration: BoxDecoration(
                                color: COLOR_ORANGE,
                                borderRadius: BorderRadius.circular(100),
                              ),
                              child: Icon(
                                Icons.send,
                                color: Colors.white,
                              ),
                            ),
                          ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  AppBar buildAppBar() {
    return AppBar(
      automaticallyImplyLeading: false,
      backgroundColor: kPrimaryColor,
      leading: IconButton(
        onPressed: () {
          Navigator.pop(context);
        },
        icon: Icon(
          FontAwesomeIcons.chevronLeft,
          size: 20,
        ),
      ),
      titleSpacing: 0,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          ClipOval(
            child: Material(
              color: Colors.white,
              child: CachedNetworkImage(
                imageUrl: widget.otherPhotoUrl,
                progressIndicatorBuilder: (context, url, downloadProgress) =>
                    CircularProgressIndicator(
                  value: downloadProgress.progress,
                ),
                errorWidget: (context, url, error) =>
                    Icon(FontAwesomeIcons.spinner),
                fit: BoxFit.cover,
                width: 50,
                height: 50,
              ),
            ),
          ),
          SizedBox(width: kDefaultPadding * 0.75),
          Text(
            widget.otherName,
            style: TextStyle(fontSize: 16),
          ),
        ],
      ),
      actions: [
        IconButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) {
                  return UserDetailsScreen(userUid: widget.otherUid);
                },
              ),
            );
          },
          icon: const Icon(
            FontAwesomeIcons.circleInfo,
            color: COLOR_WHITE,
            size: 20,
          ),
        ),
      ],
    );
  }

  Future makeMessagesRead(String combinedUid, List<Chat> chats) async {
    chats.forEach((chat) async {
      if (chat.uid == widget.user.uid) return;
      await ChatModel.makeMessageRead(
        combinedUid,
        chat.timestamp.millisecondsSinceEpoch.toString(),
      );
    });
  }

  Future _sendMessage() async {
    String msg = _messageCtl.text;
    _messageCtl.clear();

    setState(() {
      _isMessageEmpty = true;
    });

    await _db.sendMessage(
      combinedUid: _combinedUid,
      senderUid: widget.user.uid,
      message: msg,
    );

    if (!_userIsAddedToMsgList) {
      _userIsAddedToMsgList = await _checkIfUserIsAddedToMsgList();
    }
  }

  String _formatTimeTo12Hr(int hour, int minute) {
    String amOrPm = "AM";
    if (hour > 12) {
      hour = hour % 12;
      amOrPm = "PM";
    } else if (hour == 0) hour = 12;

    if (hour == 12) amOrPm = "PM";

    return hour.toString() + ":" + minute.toString() + " " + amOrPm;
  }

  Future<bool> _checkIfUserIsAddedToMsgList() async {
    bool success = await _db.checkIfUserIsAddedToMsgList(
      uid1: widget.user.uid,
      name1: widget.user.displayName!,
      email1: widget.user.email!,
      photoUrl1: widget.user.photoURL!,
      uid2: widget.otherUid,
      name2: widget.otherName,
      email2: widget.otherEmail,
      photoUrl2: widget.otherPhotoUrl,
    );
    return success;
  }
}
