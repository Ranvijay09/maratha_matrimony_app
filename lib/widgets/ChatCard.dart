// ignore_for_file: prefer_const_constructors

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:maratha_matrimony_app/models/MyUser.dart';
import 'package:maratha_matrimony_app/utils/Constants.dart';
import 'package:maratha_matrimony_app/utils/Constants.dart';

class ChatCard extends StatelessWidget {
  const ChatCard({
    Key? key,
    required this.lastMessage,
    required this.press,
    required this.user,
    required this.read,
  }) : super(key: key);

  final String lastMessage;
  final bool read;
  final MyUser user;
  final VoidCallback press;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      splashColor: COLOR_GREY,
      onTap: press,
      child: Padding(
        padding: const EdgeInsets.symmetric(
            horizontal: kDefaultPadding, vertical: kDefaultPadding * 0.75),
        child: Row(
          children: [
            ClipOval(
              child: Material(
                color: Colors.white,
                child: CachedNetworkImage(
                  imageUrl: user.photoUrl,
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
            Expanded(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: kDefaultPadding),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      user.firstName + ' ' + user.lastName,
                      style: TextStyle(
                        fontWeight: !read ? FontWeight.bold : null,
                      ),
                    ),
                    SizedBox(height: 8),
                    Opacity(
                      opacity: 0.64,
                      child: Text(
                        lastMessage,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontWeight: !read ? FontWeight.bold : null,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Opacity(
              opacity: 0.64,
              child: !read
                  ? Container(
                      height: 10,
                      width: 10,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.red,
                      ),
                    )
                  : SizedBox(),
            ),
          ],
        ),
      ),
    );
  }
}
