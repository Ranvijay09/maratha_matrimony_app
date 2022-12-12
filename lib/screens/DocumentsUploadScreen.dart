// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, use_build_context_synchronously

import 'package:another_flushbar/flushbar.dart';
import 'package:file_picker/file_picker.dart';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:maratha_matrimony_app/models/Auth.dart';
import 'package:maratha_matrimony_app/models/Database.dart';
import 'package:maratha_matrimony_app/models/UserModel.dart';
import 'package:maratha_matrimony_app/screens/BasicInfoScreen.dart';
import 'package:maratha_matrimony_app/screens/HomeScreen.dart';
import 'package:maratha_matrimony_app/screens/ScreenManager.dart';
import 'package:maratha_matrimony_app/utils/Constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:maratha_matrimony_app/widgets/ProfilePic.dart';
import 'package:provider/provider.dart';

class DocumentsUploadScreen extends StatefulWidget {
  const DocumentsUploadScreen({super.key});

  @override
  State<DocumentsUploadScreen> createState() => _DocumentsUploadScreenState();
}

class _DocumentsUploadScreenState extends State<DocumentsUploadScreen> {
  AuthService? _auth;
  User? _user;
  ImagePicker picker = ImagePicker();
  XFile? image;
  File? selectedFile;
  final _docController = TextEditingController();
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    _user = Provider.of<User?>(context);
    _auth = Provider.of<AuthService>(context);
    return WillPopScope(
      onWillPop: () async => false,
      child: SafeArea(
        child: Scaffold(
          backgroundColor: Colors.grey[300],
          appBar: AppBar(
            automaticallyImplyLeading: false,
            elevation: 0,
            leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(
                FontAwesomeIcons.chevronLeft,
                size: 20,
              ),
            ),
            foregroundColor: COLOR_BLACK,
            backgroundColor: Colors.grey[300],
            title: Text(
              'Photo & Document',
              style: TextStyle(
                fontSize: 20,
              ),
            ),
            centerTitle: true,
          ),
          body: Center(
            child: Column(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: 50,
                        ),
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
                                UserModel.updateProfilePhoto(
                                        File(image!.path), _user!)
                                    .then((value) => setState(() {
                                          image = null;
                                        }));
                              }
                            }),
                        SizedBox(height: 50),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 25.0),
                          child: Container(
                            decoration: BoxDecoration(
                                color: Colors.grey[100],
                                border: Border.all(color: Colors.white),
                                borderRadius: BorderRadius.circular(12)),
                            child: Padding(
                              padding:
                                  const EdgeInsets.only(left: 20.0, right: 10),
                              child: TextFormField(
                                validator: (val) {
                                  if (val!.isEmpty) {
                                    return "Please upload verification document";
                                  }
                                  return null;
                                },
                                controller: _docController,
                                readOnly: true,
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: 'Verification Document*',
                                  hintStyle: TextStyle(
                                    fontWeight: FontWeight.w500,
                                  ),
                                  suffixIcon: Icon(
                                    FontAwesomeIcons.upload,
                                    size: 20,
                                    color: COLOR_BLACK,
                                  ),
                                ),
                                style: TextStyle(fontSize: 15),
                                onTap: () async {
                                  var result =
                                      await FilePicker.platform.pickFiles();

                                  if (result != null) {
                                    selectedFile =
                                        File(result.files.first.path!);
                                    _docController.text =
                                        result.files.first.name;
                                  }
                                },
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 20),
                      ],
                    ),
                  ),
                ),
                ClipRRect(
                  child: MaterialButton(
                    onPressed: isLoading
                        ? null
                        : () => saveProfilePicAndDocumentToDB(),
                    minWidth: double.infinity,
                    height: 60,
                    color: COLOR_ORANGE,
                    child: isLoading
                        ? CircularProgressIndicator(color: Colors.white)
                        : Text(
                            "Continue",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  saveProfilePicAndDocumentToDB() async {
    isLoading = true;
    if (_user?.photoURL != UserModel.defaultPhotoUrl) {
      if (selectedFile != null) {
        await UserModel.updateVerficationDoc(selectedFile!, _user!);
        isLoading = false;
        _auth?.signOut();
        Navigator.of(context)
            .push(
              MaterialPageRoute(
                builder: (context) => ScreenManager(),
              ),
            )
            .catchError((error) => print("something is wrong. $error"));
      } else {
        showSnackBar(
            "Upload any relevant document for your profile verification!");
        isLoading = false;
      }
    } else {
      showSnackBar("Upload your image first!");
      isLoading = false;
    }
  }

  void showSnackBar(String msg) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(msg),
      padding: EdgeInsets.all(20),
      behavior: SnackBarBehavior.floating,
    ));
  }
}
