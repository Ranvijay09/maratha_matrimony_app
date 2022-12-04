import 'dart:async';
import 'dart:io';
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:maratha_matrimony_app/models/database.dart';
import 'package:maratha_matrimony_app/models/MyUser.dart';

class UserModel {
  static String defaultPhotoUrl =
      "https://firebasestorage.googleapis.com/v0/b/maratha-matrimony-app.appspot.com/o/default-avatar-profile-icon-social-media-user-vector-image-icon-default-avatar-profile-icon-social-media-user-vector-image-209162840.jpg?alt=media&token=2dadb52e-7b9c-4b15-977f-284eddac313c";

  static FirebaseStorage storage = FirebaseStorage.instance;
  static Future<bool> updateProfilePhoto(File file, User user) async {
    bool success = true;
    var storageRef = storage.ref().child("user/profile/${user.uid}");
    var uploadTask = storageRef.putFile(file);
    String downloadUrl = "";
    await uploadTask.then(
        (snapshot) async => downloadUrl = await snapshot.ref.getDownloadURL());

    await user
        .updatePhotoURL(downloadUrl)
        .onError((error, stackTrace) => success = false);

    await Database().updateDocUrl('photoUrl', user.uid, downloadUrl);

    return success;
  }

  static Future<bool> updateVerficationDoc(File file, User user) async {
    bool success = true;
    var storageRef = storage.ref().child("user/document/${user.uid}");
    var uploadTask = storageRef.putFile(file);
    String downloadUrl = "";
    await uploadTask.then(
        (snapshot) async => downloadUrl = await snapshot.ref.getDownloadURL());

    await user
        .updatePhotoURL(downloadUrl)
        .onError((error, stackTrace) => success = false);

    await Database().updateDocUrl('varificationDocUrl', user.uid, downloadUrl);

    return success;
  }

  static MyUser _convertDocSnapshot(DocumentSnapshot doc) {
    return MyUser(
      uid: doc["uid"],
      email: doc["email"],
      phoneNo: doc["phoneNo"],
      firstName: doc["firstName"],
      middleName: doc["middleName"],
      lastName: doc["lastName"],
      gender: doc["gender"],
      dob: DateTime.fromMicrosecondsSinceEpoch(
          doc["dob"].microsecondsSinceEpoch),
      maritalStatus: doc["maritalStatus"],
      noOfChildren: doc["noOfChildren"],
      childrenLivingStatus: doc["childrenLivingStatus"],
      subCast: doc["subCast"],
      highestEducation: doc["highestEducation"],
      educationStream: doc["educationStream"],
      occupation: doc["occupation"],
      annualIncome: doc["annualIncome"],

      //address
      address: doc["address"],
      city: doc["city"],
      tehsil: doc["tehsil"],
      district: doc["district"],
      state: doc["state"],

      //socio religious attributes
      gothra: doc["gothra"],
      rashi: doc["rashi"],
      horosMatch: doc["horosMatch"],
      manglik: doc["manglik"],
      birthState: doc["birthState"],
      birthDistrict: doc["birthDistrict"],
      birthTehsil: doc["birthTehsil"],
      birthcity: doc["birthcity"],
      birthTime: doc["birthTime"],

      //expectations from spouse
      spouseHighestEducation: doc["spouseHighestEducation"],
      spouseEducationStream: doc["spouseEducationStream"],
      spouseOccupation: doc["spouseOccupation"],
      spouseDietPreference: doc["spouseDietPreference"],
      spouseAnnualIncome: doc["spouseAnnualIncome"],
      spouseAgeDifference: doc["spouseAgeDifference"],
      spouseMaritalStatus: doc["spouseMaritalStatus"],
      spouseComplexion: doc["spouseComplexion"],
      spouseBodyType: doc["spouseBodyType"],
      spouseSmokingHabit: doc["spouseSmokingHabit"],
      spouseDrinkingHabit: doc["spouseDrinkingHabit"],
      spouseOtherExpectations: doc["spouseOtherExpectations"],

      //physical attributes
      height: doc["height"],
      weight: doc["weight"],
      bloodGroup: doc["bloodGroup"],
      complexion: doc["complexion"],
      physicalStatus: doc["physicalStatus"],
      bodyType: doc["bodyType"],
      diet: doc["diet"],
      smoke: doc["smoke"],
      drink: doc["drink"],

      //other
      photoUrl: doc["photoUrl"],
      varificationDocUrl: doc["varificationDocUrl"],
      isVerified: doc["isVerified"],
    );
  }

  static Future<MyUser> getParticularUserDetails(String uid) async {
    return _convertDocSnapshot(
        await Database().db.collection("users").doc(uid).get());
  }

  static List<MyUser> _convertSnapshots(QuerySnapshot snapshot) {
    try {
      return snapshot.docs.map((doc) {
        return MyUser(
          uid: doc["uid"],
          email: doc["email"],
          phoneNo: doc["phoneNo"],
          firstName: doc["firstName"],
          middleName: doc["middleName"],
          lastName: doc["lastName"],
          gender: doc["gender"],
          dob: DateTime.fromMicrosecondsSinceEpoch(
              doc["dob"].microsecondsSinceEpoch),
          maritalStatus: doc["maritalStatus"],
          noOfChildren: doc["noOfChildren"],
          childrenLivingStatus: doc["childrenLivingStatus"],
          subCast: doc["subCast"],
          highestEducation: doc["highestEducation"],
          educationStream: doc["educationStream"],
          occupation: doc["occupation"],
          annualIncome: doc["annualIncome"],

          //address
          address: doc["address"],
          city: doc["city"],
          tehsil: doc["tehsil"],
          district: doc["district"],
          state: doc["state"],

          //socio religious attributes
          gothra: doc["gothra"],
          rashi: doc["rashi"],
          horosMatch: doc["horosMatch"],
          manglik: doc["manglik"],
          birthState: doc["birthState"],
          birthDistrict: doc["birthDistrict"],
          birthTehsil: doc["birthTehsil"],
          birthcity: doc["birthcity"],
          birthTime: doc['birthTime'],

          //expectations from spouse
          spouseHighestEducation: doc["spouseHighestEducation"],
          spouseEducationStream: doc["spouseEducationStream"],
          spouseOccupation: doc["spouseOccupation"],
          spouseDietPreference: doc["spouseDietPreference"],
          spouseAnnualIncome: doc["spouseAnnualIncome"],
          spouseAgeDifference: doc["spouseAgeDifference"],
          spouseMaritalStatus: doc["spouseMaritalStatus"],
          spouseComplexion: doc["spouseComplexion"],
          spouseBodyType: doc["spouseBodyType"],
          spouseSmokingHabit: doc["spouseSmokingHabit"],
          spouseDrinkingHabit: doc["spouseDrinkingHabit"],
          spouseOtherExpectations: doc["spouseOtherExpectations"],

          //physical attributes
          height: doc["height"],
          weight: doc["weight"],
          bloodGroup: doc["bloodGroup"],
          complexion: doc["complexion"],
          physicalStatus: doc["physicalStatus"],
          bodyType: doc["bodyType"],
          diet: doc["diet"],
          smoke: doc["smoke"],
          drink: doc["drink"],

          //other
          photoUrl: doc["photoUrl"],
          varificationDocUrl: doc["varificationDocUrl"],
          isVerified: doc["isVerified"],
        );
      }).toList();
    } catch (e) {
      print(e);
      return [];
    }
  }

  static Future<List<MyUser>> getAllUsersDetails() async {
    bool success = true;
    QuerySnapshot? snapshot;
    try {
      snapshot = await Database().db.collection("users").get();
    } catch (e) {
      print(e);
      success = false;
    }
    if (success)
      return _convertSnapshots(snapshot!);
    else {
      return [];
    }
  }

  static Future<List<MyUser>> getAllUsersForFeed({required String uid}) async {
    bool success = true;
    QuerySnapshot? snapshot;
    MyUser _loggedInUser = await UserModel.getParticularUserDetails(uid);
    Stream<List<String>> _bookmarkIds = UserModel.getBookmarks(uid);
    List<Object> allBookmarks = [uid];
    List<MyUser> snap = [];
    _bookmarkIds.listen((listOfBookmarks) {
      for (var bookmark in listOfBookmarks) {
        allBookmarks.add(bookmark);
      }
    });
    try {
      snapshot = await Database()
          .db
          .collection("users")
          .where('gender', isNotEqualTo: _loggedInUser.gender)
          .get();
    } catch (e) {
      print(e);
      success = false;
    }
    if (success) {
      List<MyUser> allUsers = _convertSnapshots(snapshot!);
      allUsers.forEach((s) => {if (!allBookmarks.contains(s.uid)) snap.add(s)});
      return snap;
    } else {
      return [];
    }
  }

  static List<String> _convertBookmarkSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      return doc["uid"].toString();
    }).toList();
  }

  static Stream<List<String>> getBookmarks(String uid) {
    return Database()
        .db
        .collection("users")
        .doc(uid)
        .collection("bookmarks")
        .snapshots()
        .map(_convertBookmarkSnapshot);
  }

  static String getCombinedUid(String uid1, String uid2) {
    int i = 0;
    int minLen = min(uid1.length, uid2.length);
    while (i < minLen) {
      if (uid1.codeUnits[i] < uid2.codeUnits[i])
        return uid1 + uid2;
      else if (uid1.codeUnits[i] > uid2.codeUnits[i]) return uid2 + uid1;
      i++;
    }
    if (uid1.length < uid2.length) return uid1 + uid2;
    return uid2 + uid1;
  }
}
