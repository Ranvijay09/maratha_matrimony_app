import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:maratha_matrimony_app/models/UserModel.dart';

class Database {
  // Making this class a singleton.
  static final Database _database = Database._init();
  Database._init() {
    print("Database Initialised.");
  }

  factory Database() {
    return _database;
  }

  final FirebaseFirestore db = FirebaseFirestore.instance;

  Future addUserToCollectionIfNew(User user,
      {String? phoneNo, String? photoUrl}) async {
    DocumentSnapshot snapshot =
        await db.collection("users").doc(user.uid).get();
    if (!snapshot.exists) {
      print("New User!");
      await db.collection("users").doc(user.uid).set({
        "uid": user.uid,
        "email": user.email,
        "phoneNo": phoneNo,
        "firstName": '',
        "middleName": '',
        "lastName": '',
        "gender": '',
        "dob": DateTime.now(),
        "maritalStatus": '',
        "noOfChildren": '',
        "childrenLivingStatus": '',
        "subCast": '',
        "highestEducation": '',
        "educationStream": '',
        "occupation": '',
        "annualIncome": '',
        //address
        "address": '',
        "city": '',
        "tehsil": '',
        "district": '',
        "state": '',
        //socio religious attributes
        "gothra": '',
        "rashi": '',
        "horosMatch": '',
        "manglik": '',
        "birthState": '',
        "birthDistrict": '',
        "birthTehsil": '',
        "birthcity": '',
        "birthTime": '',

        //expectations from spouse
        "spouseHighestEducation": '',
        "spouseEducationStream": '',
        "spouseOccupation": '',
        "spouseDietPreference": '',
        "spouseAnnualIncome": '',
        "spouseAgeDifference": 0,
        "spouseMaritalStatus": '',
        "spouseComplexion": '',
        "spouseBodyType": '',
        "spouseSmokingHabit": '',
        "spouseDrinkingHabit": '',
        "spouseOtherExpectations": '',

        //physical attributes
        "height": 0,
        "weight": 0,
        "bloodGroup": '',
        "complexion": '',
        "physicalStatus": '',
        "bodyType": '',
        "diet": '',
        "smoke": '',
        "drink": '',

        //other
        "photoUrl": photoUrl != null ? photoUrl : user.photoURL,
        "varificationDocUrl": '',
        "isVerified": false,
      });
      await db.collection("filters").doc(user.uid).set({
        "ageMin": 21,
        "ageMax": 50,
        "maritalStatus": 'Doesn\'t Matter',
        "highestEducation": 'Doesn\'t Matter',
        "occupation": 'Doesn\'t Matter',
        "annualIncome": 'Doesn\'t Matter',
      });
      return true;
    }
    return false;
  }

  Future<bool> addBasicInfo(
      {required String uid,
      required String firstName,
      required String middleName,
      required String lastName,
      required String gender,
      required DateTime dob,
      required String maritalStatus,
      required String noOfChildren,
      required String childrenLivingStatus,
      required String subCast,
      required String highestEducation,
      required String educationStream,
      required String occupation,
      required String annualIncome}) async {
    bool isSuccess = true;
    await db.collection("users").doc(uid).update({
      "firstName": firstName,
      "middleName": middleName,
      "lastName": lastName,
      "gender": gender,
      "dob": dob,
      "maritalStatus": maritalStatus,
      "noOfChildren": noOfChildren,
      "childrenLivingStatus": childrenLivingStatus,
      "subCast": subCast,
      "highestEducation": highestEducation,
      "educationStream": educationStream,
      "occupation": occupation,
      "annualIncome": annualIncome,
    }).onError((error, stackTrace) {
      print(error.toString());
      isSuccess = false;
    });
    return isSuccess;
  }

  Future<bool> addCurrentAddress({
    required String uid,
    required String address,
    required String city,
    required String tehsil,
    required String district,
    required String state,
  }) async {
    bool isSuccess = true;
    await db.collection("users").doc(uid).update({
      "address": address,
      "city": city,
      "tehsil": tehsil,
      "district": district,
      "state": state,
    }).onError((error, stackTrace) {
      print(error.toString());
      isSuccess = false;
    });
    return isSuccess;
  }

  Future<bool> addSocioReligiousAttributes({
    required String uid,
    required String gothra,
    required String rashi,
    required String horosMatch,
    required String manglik,
    required String time,
    required String city,
    required String tehsil,
    required String district,
    required String state,
  }) async {
    bool isSuccess = true;
    await db.collection("users").doc(uid).update({
      "gothra": gothra,
      "rashi": rashi,
      "horosMatch": horosMatch,
      "manglik": manglik,
      "birthState": state,
      "birthDistrict": district,
      "birthTehsil": tehsil,
      "birthcity": city,
      "birthTime": time,
    }).onError((error, stackTrace) {
      print(error.toString());
      isSuccess = false;
    });
    return isSuccess;
  }

  Future<bool> addPhysicalAttributes({
    required String uid,
    required String height,
    required String weight,
    required String bloodGroup,
    required String complexion,
    required String physicalStatus,
    required String bodyType,
    required String diet,
    required String smoke,
    required String drink,
  }) async {
    bool isSuccess = true;
    await db.collection("users").doc(uid).update({
      "height": int.parse(height),
      "weight": int.parse(weight),
      "bloodGroup": bloodGroup,
      "complexion": complexion,
      "physicalStatus": physicalStatus,
      "bodyType": bodyType,
      "diet": diet,
      "smoke": smoke,
      "drink": drink,
    }).onError((error, stackTrace) {
      print(error.toString());
      isSuccess = false;
    });
    return isSuccess;
  }

  Future sendMessage({
    required String combinedUid,
    required String senderUid,
    required String message,
  }) async {
    Timestamp timestamp = Timestamp.now();
    await db
        .collection("all-chats")
        .doc(combinedUid)
        .collection("chats")
        .doc(timestamp.millisecondsSinceEpoch.toString())
        .set({
      "uid": senderUid,
      "message": message,
      "read": false,
      "timestamp": timestamp,
    });
  }

  Future<bool> checkIfUserIsAddedToMsgList({
    required String uid1,
    required String name1,
    required String email1,
    required String photoUrl1,
    required String uid2,
    required String name2,
    required String email2,
    required String photoUrl2,
  }) async {
    bool success = true;
    try {
      // Checking if user2 exists in user1
      DocumentSnapshot snap1 = await db
          .collection("users")
          .doc(uid1)
          .collection("chats")
          .doc(uid2)
          .get();

      String combinedUid = UserModel.getCombinedUid(uid1, uid2);
      if (!snap1.exists) {
        await db.collection("all-chats").doc(combinedUid).set({
          "combinedUid": combinedUid,
        });
      }

      if (!snap1.exists) {
        await db
            .collection("users")
            .doc(uid1)
            .collection("chats")
            .doc(uid2)
            .set({
          "uid": uid2,
        });
      }

      // Checking if user1 exists in user2
      DocumentSnapshot snap2 = await db
          .collection("users")
          .doc(uid2)
          .collection("chats")
          .doc(uid1)
          .get();

      if (!snap2.exists) {
        await db
            .collection("users")
            .doc(uid2)
            .collection("chats")
            .doc(uid1)
            .set({
          "uid": uid1,
        });
      }
    } catch (e) {
      print(e.toString());
      success = false;
    }
    return success;
  }

  Future updateDocUrl(String fieldName, String uid, String url) async {
    bool success = true;
    await db.collection("users").doc(uid).update({
      fieldName: url,
    }).onError((error, stackTrace) => success = false);

    if (success) {
      await db.collection("users").doc(uid).update({
        fieldName: url,
      }).onError((error, stackTrace) => success = false);
    }
    return success;
  }

  Future<bool> checkIfUserIsAddedToBookmarks({
    required String uid1,
    required String uid2,
  }) async {
    bool success = true;
    try {
      // Checking if user2 exists in user1
      DocumentSnapshot snap1 = await db
          .collection("users")
          .doc(uid1)
          .collection("bookmarks")
          .doc(uid2)
          .get();

      !snap1.exists
          ? bookmarkUser(userUid: uid1, bookmarkUserUid: uid2)
              .onError((error, stackTrace) => success = false)
          : deleteBookmark(userUid: uid1, bookmarkUserUid: uid2)
              .onError((error, stackTrace) => success = false);
    } catch (e) {
      print(e.toString());
      success = false;
    }
    return success;
  }

  Future<bool> bookmarkUser({
    required String userUid,
    required String bookmarkUserUid,
  }) async {
    bool success = true;
    await db
        .collection("users")
        .doc(userUid)
        .collection("bookmarks")
        .doc(bookmarkUserUid)
        .set({
      "uid": bookmarkUserUid,
    }).onError((error, stackTrace) => success = false);
    return success;
  }

  Future<bool> deleteBookmark({
    required String userUid,
    required String bookmarkUserUid,
  }) async {
    bool success = true;
    await db
        .collection("users")
        .doc(userUid)
        .collection("bookmarks")
        .doc(bookmarkUserUid)
        .delete()
        .onError((error, stackTrace) => success = false);
    return success;
  }

  Future<bool> sendConnectReq({
    required String userUid,
    required String otherUserUid,
  }) async {
    bool success = true;

    DocumentSnapshot snap1 = await db
        .collection("users")
        .doc(userUid)
        .collection("chats")
        .doc(otherUserUid)
        .get();
    if (snap1.exists) return success;

    await db
        .collection("users")
        .doc(userUid)
        .collection("sent-requests")
        .doc(otherUserUid)
        .set({
      "uid": otherUserUid,
    }).onError((error, stackTrace) => success = false);
    if (success) {
      await db
          .collection("users")
          .doc(otherUserUid)
          .collection("pending-requests")
          .doc(userUid)
          .set({
        "uid": userUid,
      }).onError((error, stackTrace) => success = false);
    }
    return success;
  }

  Future<bool> acceptConnectReq({
    required String userUid,
    required String otherUserUid,
  }) async {
    bool success = true;
    await db
        .collection("users")
        .doc(userUid)
        .collection("pending-requests")
        .doc(otherUserUid)
        .delete()
        .onError((error, stackTrace) => success = false);
    if (success) {
      await db
          .collection("users")
          .doc(otherUserUid)
          .collection("sent-requests")
          .doc(userUid)
          .delete()
          .onError((error, stackTrace) => success = false);
      if (success) {
        await db
            .collection("users")
            .doc(otherUserUid)
            .collection("chats")
            .doc(userUid)
            .set({
          "uid": userUid,
        }).onError((error, stackTrace) => success = false);

        await db
            .collection("users")
            .doc(userUid)
            .collection("chats")
            .doc(otherUserUid)
            .set({
          "uid": otherUserUid,
        }).onError((error, stackTrace) => success = false);

        String combinedUid = UserModel.getCombinedUid(userUid, otherUserUid);
        await db.collection("all-chats").doc(combinedUid).set({
          "combinedUid": combinedUid,
        });
      }
    }
    return success;
  }

  Future<bool> cancelConnectReq({
    required String userUid,
    required String otherUserUid,
  }) async {
    bool success = true;
    await db
        .collection("users")
        .doc(userUid)
        .collection("sent-requests")
        .doc(otherUserUid)
        .delete()
        .onError((error, stackTrace) => success = false);
    if (success) {
      await db
          .collection("users")
          .doc(otherUserUid)
          .collection("pending-requests")
          .doc(userUid)
          .delete()
          .onError((error, stackTrace) => success = false);
    }
    return success;
  }
}
