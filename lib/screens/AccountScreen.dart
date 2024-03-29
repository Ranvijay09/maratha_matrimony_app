// ignore_for_file: prefer_const_constructors

import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:maratha_matrimony_app/models/Auth.dart';
import 'package:maratha_matrimony_app/models/UserModel.dart';
import 'package:maratha_matrimony_app/screens/AuthManager.dart';
import 'package:maratha_matrimony_app/screens/UserDetailsScreen.dart';
import 'package:maratha_matrimony_app/widgets/ProfileMenu.dart';
import 'package:maratha_matrimony_app/widgets/ProfilePic.dart';
import 'package:provider/provider.dart';

class AccountScreen extends StatefulWidget {
  const AccountScreen({super.key});

  @override
  State<AccountScreen> createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  User? _user;
  AuthService? _auth;
  ImagePicker picker = ImagePicker();
  XFile? image;
  @override
  Widget build(BuildContext context) {
    _user = Provider.of<User?>(context);
    _auth = Provider.of<AuthService>(context);
    return SafeArea(
      child: Scaffold(
          body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(vertical: 20),
        child: Column(
          children: [
            ProfilePic(
                imagePath: image != null
                    ? UserModel.defaultPhotoUrl
                    : _user!.photoURL!,
                onBtnClick: () async {
                  var img = await ImagePicker()
                      .pickImage(source: ImageSource.gallery);

                  setState(() {
                    image = img;
                  });
                  if (image != null) {
                    showSnackBar(
                        "It'll take some time to update your profile photo on screen");
                    UserModel.updateProfilePhoto(File(image!.path), _user!)
                        .then((value) => image = null);
                  }
                }),
            SizedBox(height: 20),
            ProfileMenu(
              text: "My Profile Info",
              icon: FontAwesomeIcons.solidUser,
              press: () => {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return UserDetailsScreen(
                        userUid: _user!.uid,
                        showBookmarkIcon: false,
                      );
                    },
                  ),
                )
              },
            ),
            ProfileMenu(
              text: "About Us",
              icon: FontAwesomeIcons.solidAddressCard,
              press: () {},
            ),
            ProfileMenu(
              text: "Contact Us",
              icon: FontAwesomeIcons.phone,
              press: () {},
            ),
            ProfileMenu(
              text: "Sign Out",
              icon: FontAwesomeIcons.rightFromBracket,
              press: () async {
                await _auth!.signOut();
                Navigator.of(context)
                    .push(
                      MaterialPageRoute(
                        builder: (context) => AuthManager(),
                      ),
                    )
                    .catchError((error) => print("something is wrong. $error"));
              },
            ),
          ],
        ),
      )),
    );
  }

  void showSnackBar(String msg) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(msg),
      padding: EdgeInsets.all(20),
      behavior: SnackBarBehavior.floating,
    ));
  }
}
