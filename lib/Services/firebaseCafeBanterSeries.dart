import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class CafebanterFirebaseService {
  FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  Future<UserCredential?> firebaseLoginUser(
      BuildContext context, String email, String password) async {
    UserCredential? credential;
    try {
      credential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      debugPrint('User logged in ${credential.user!.uid}');
      debugPrint('User logged in ${credential.user!.email}');
      debugPrint('User logged in ${credential.user!.emailVerified}');
      return credential;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        Fluttertoast.showToast(msg: "$email does not exist");
      } else if (e.code == 'wrong-password') {
        Fluttertoast.showToast(msg: "Incorrect Password");
      }
    }
    return credential;
  }

  Future<UserCredential?> firebaseSignUp(String email, String password) async {
    try {
      final credential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      return credential;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        Fluttertoast.showToast(msg: "The password provided is too weak.");
      } else if (e.code == 'email-already-in-use') {
        Fluttertoast.showToast(
            msg: "The account already exists for that email.");
      }
    } catch (e) {
      Fluttertoast.showToast(msg: e.toString());
    }
  }
}
