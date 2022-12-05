// ignore_for_file: prefer_const_constructors

import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:maratha_matrimony_app/utils/Constants.dart';

class ProfilePic extends StatelessWidget {
  final String imagePath;
  final VoidCallback onBtnClick;
  const ProfilePic({
    Key? key,
    required this.imagePath,
    required this.onBtnClick,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 240,
      width: 240,
      child: Stack(
        fit: StackFit.expand,
        clipBehavior: Clip.none,
        children: [
          ClipOval(
            child: Material(
              color: Colors.white,
              child: CachedNetworkImage(
                imageUrl: imagePath,
                progressIndicatorBuilder: (context, url, downloadProgress) =>
                    CircularProgressIndicator(
                  value: downloadProgress.progress,
                ),
                errorWidget: (context, url, error) =>
                    Icon(FontAwesomeIcons.spinner),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Positioned(
            right: 25,
            bottom: 0,
            child: SizedBox(
              height: 50,
              width: 50,
              child: TextButton(
                style: TextButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50),
                    side: BorderSide(color: Colors.white),
                  ),
                  primary: Colors.white,
                  backgroundColor: Color(0xFFF5F6F9),
                ),
                onPressed: onBtnClick,
                child: Icon(
                  FontAwesomeIcons.pen,
                  color: COLOR_BLACK,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
