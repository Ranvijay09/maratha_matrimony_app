import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:maratha_matrimony_app/models/Database.dart';

class ChatModel {
  static List<vChat> _convertSnapshots(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      return vChat(
          uid: doc["uid"],
          message: doc["message"],
          read: doc["read"],
          timestamp: doc["timestamp"].toDate());
    }).toList();
  }

  static Stream<List<vChat>> getChats(String combinedUid) {
    return Database()
        .db
        .collection("all-chats")
        .doc(combinedUid)
        .collection("chats")
        .orderBy("timestamp", descending: true)
        .snapshots()
        .map(_convertSnapshots);
  }

  static Stream<List<vChat>> getOneChat(String combinedUid) {
    return Database()
        .db
        .collection("all-chats")
        .doc(combinedUid)
        .collection("chats")
        .orderBy("timestamp", descending: true)
        .limit(1)
        .snapshots()
        .map(_convertSnapshots);
  }

  static List<String> _convertSnapshotsUsers(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      return doc["uid"].toString();
    }).toList();
  }

  static Stream<List<String>> getChatUsers(String uid) {
    return Database()
        .db
        .collection("users")
        .doc(uid)
        .collection("chats")
        .snapshots()
        .map(_convertSnapshotsUsers);
  }

  static Future makeMessageRead(String combinedUid, String chatUid) async {
    Database()
        .db
        .collection("all-chats")
        .doc(combinedUid)
        .collection("chats")
        .doc(chatUid)
        .update({
      "read": true,
    });
  }
}

class vChat {
  final String uid;
  final String message;
  final bool read;
  final DateTime timestamp;

  vChat(
      {required this.uid,
      required this.message,
      required this.read,
      required this.timestamp});
}
