// ignore_for_file: prefer_const_constructors

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:maratha_matrimony_app/models/Auth.dart';
import 'package:maratha_matrimony_app/models/UserModel.dart';
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
                imagePath: _user!.photoURL,
                onBtnClick: () async => {
                      image = await ImagePicker()
                          .pickImage(source: ImageSource.gallery)
                    }),
            SizedBox(height: 20),
            ProfileMenu(
              text: "My Profile Info",
              icon: FontAwesomeIcons.solidUser,
              press: () => {},
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
              press: () => _auth!.signOut(),
            ),
          ],
        ),
      )),
    );
  }
}
