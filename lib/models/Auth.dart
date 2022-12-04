import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';
import 'package:maratha_matrimony_app/models/Database.dart';
import 'package:maratha_matrimony_app/models/UserModel.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthService with ChangeNotifier {
  final firebaseAuth = FirebaseAuth.instance;
  bool _isLoading = false;
  String _errorMessage = "";
  bool get isLoading => _isLoading;
  String get errorMessage => _errorMessage;

  Database _db = Database();

  Future signInWithGoogle() async {
    _errorMessage = "";
    setLoading(true);
    try {
      // Trigger the authentication flow
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

      if (googleUser == null) return false;

      // Obtain the auth details from the request
      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      // Create a new credential
      final OAuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      UserCredential userCredential =
          await firebaseAuth.signInWithCredential(credential);
      setLoading(false);

      if (userCredential.user != null) {
        await _db.addUserToCollectionIfNew(userCredential.user!);
      }

      return userCredential.user;
    } on SocketException {
      setLoading(false);
      setMessage("No internet, please connect to internet!");
    } catch (e) {
      setLoading(false);
      setMessage(e.toString());
    }
  }

  Future createUserWithEmailAndPassword(
      String email, String password, String phoneNo) async {
    _errorMessage = "";
    setLoading(true);
    try {
      UserCredential userCredential = await firebaseAuth
          .createUserWithEmailAndPassword(email: email, password: password);

      if (userCredential.user != null) {
        await userCredential.user!.updatePhotoURL(UserModel.defaultPhotoUrl);
        await _db.addUserToCollectionIfNew(
          userCredential.user!,
          phoneNo: phoneNo,
          photoUrl: UserModel.defaultPhotoUrl,
        );
      }
      setLoading(false);
      print("LAST");
      print(userCredential.user);
      return userCredential.user;
    } on SocketException {
      setLoading(false);
      setMessage("No internet, please connect to internet!");
    } catch (e) {
      setLoading(false);
      setMessage(e.toString());
    }
    notifyListeners();
  }

  Future loginUserWithEmailAndPassword(String email, String password) async {
    _errorMessage = "";
    setLoading(true);
    try {
      UserCredential userCredential = await firebaseAuth
          .signInWithEmailAndPassword(email: email, password: password);
      setLoading(false);

      return userCredential.user;
    } on SocketException {
      setLoading(false);
      setMessage("No internet, please connect to internet!");
    } catch (e) {
      setLoading(false);
      setMessage(e.toString());
    }
    notifyListeners();
  }

  Future signOut() async {
    try {
      await firebaseAuth.signOut();
    } catch (e) {
      print(e);
    }
  }

  Future phoneVerification(String phoneNo) async {
    _errorMessage = "";
    PhoneAuthCredential? phoneAuthCredential;
    String? verificationId;
    await firebaseAuth.verifyPhoneNumber(
      phoneNumber: phoneNo,
      verificationCompleted: (PhoneAuthCredential credential) {
        phoneAuthCredential = credential;
      },
      verificationFailed: (err) {
        setMessage(err.message ?? "");
        print(err);
      },
      codeSent: (vID, _) {
        verificationId = vID;
      },
      codeAutoRetrievalTimeout: (_) {},
    );

    if (phoneAuthCredential != null) return [true, null];
    return [
      false,
      verificationId,
    ];
  }

  sendResetLink(String email) async {
    try {
      await firebaseAuth.sendPasswordResetEmail(email: email);
    } catch (er) {
      setMessage(er.toString());
    }
  }

  void setLoading(bool val) {
    _isLoading = val;
    notifyListeners();
  }

  void setMessage(String val) {
    _errorMessage = val;
    notifyListeners();
  }

  Stream<User> get user =>
      FirebaseAuth.instance.userChanges().map((event) => event!);
}
