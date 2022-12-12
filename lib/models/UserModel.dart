import 'dart:async';
import 'dart:io';
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:maratha_matrimony_app/models/MyFilter.dart';
import 'package:maratha_matrimony_app/models/database.dart';
import 'package:maratha_matrimony_app/models/MyUser.dart';

class UserModel {
  static String defaultPhotoUrl =
      "https://firebasestorage.googleapis.com/v0/b/maratha-matrimony-app.appspot.com/o/default-avatar-profile-icon.jpg?alt=media&token=0dc370d1-907e-4c9a-b1d1-1e7a69528e92";
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
    MyFilter _filters = await UserModel.getMyFilters(uid);
    Stream<List<String>> _bookmarkIds = UserModel.getBookmarks(uid);
    Stream<List<String>> _sentReqIds = UserModel.getSentRequests(uid);
    Stream<List<String>> _pendingReqIds = UserModel.getPendingRequests(uid);
    Stream<List<String>> _chatIds = UserModel.getChats(uid);
    List<MyUser> snap = [];
    List<Object> allBookmarks = [uid];
    _bookmarkIds.listen((listOfBookmarks) {
      for (var bookmark in listOfBookmarks) {
        allBookmarks.add(bookmark);
      }
    });
    List<Object> allSentRequests = [uid];
    _sentReqIds.listen((listOfSentReqs) {
      for (var req in listOfSentReqs) {
        allSentRequests.add(req);
      }
    });
    List<Object> allPendingRequests = [uid];
    _pendingReqIds.listen((listOfPendingReqs) {
      for (var req in listOfPendingReqs) {
        allPendingRequests.add(req);
      }
    });
    List<Object> allChats = [uid];
    _chatIds.listen((listOfChats) {
      for (var chat in listOfChats) {
        allChats.add(chat);
      }
    });
    try {
      snapshot = await Database()
          .db
          .collection("users")
          .where('gender', isEqualTo: _filters.gender)
          .get();
    } catch (e) {
      print(e);
      success = false;
    }
    if (success) {
      List<MyUser> allUsers = _convertSnapshots(snapshot!);
      allUsers.forEach((s) => {
            if (!allBookmarks.contains(s.uid) &&
                !allSentRequests.contains(s.uid) &&
                !allPendingRequests.contains(s.uid) &&
                !allChats.contains(s.uid) &&
                _filters.annualIncome.contains(s.annualIncome) &&
                _filters.occupation.contains(s.occupation) &&
                _filters.maritalStatus.contains(s.maritalStatus) &&
                _filters.highestEducation.contains(s.highestEducation))
              {snap.add(s)}
          });
      return snap;
    } else {
      return [];
    }
  }

  static Future<MyFilter> getMyFilters(String uid) async {
    return _convertFilterSnapshot(
        await Database().db.collection("filters").doc(uid).get());
  }

  static MyFilter _convertFilterSnapshot(DocumentSnapshot doc) {
    return MyFilter(
      ageMax: doc["ageMax"],
      ageMin: doc["ageMin"],
      gender: doc["gender"],
      maritalStatus: List.from(doc["maritalStatus"]),
      highestEducation: List.from(doc["highestEducation"]),
      occupation: List.from(doc["occupation"]),
      annualIncome: List.from(doc["annualIncome"]),
    );
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

  static Stream<List<String>> getChats(String uid) {
    return Database()
        .db
        .collection("users")
        .doc(uid)
        .collection("chats")
        .snapshots()
        .map(_convertBookmarkSnapshot);
  }

  static Stream<List<String>> getPendingRequests(String uid) {
    return Database()
        .db
        .collection("users")
        .doc(uid)
        .collection("pending-requests")
        .snapshots()
        .map(_convertBookmarkSnapshot);
  }

  static Stream<List<String>> getSentRequests(String uid) {
    return Database()
        .db
        .collection("users")
        .doc(uid)
        .collection("sent-requests")
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
