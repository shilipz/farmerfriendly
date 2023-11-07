import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cucumber_app/domain/models/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';

// /---------------signUp---------------------------

class FirebaseAuthServices {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final CollectionReference _usersCollection =
      FirebaseFirestore.instance.collection('users');

  Future<User?> signUpWithEmailAndPassword(UserModel userModel) async {
    try {
      UserCredential userCredential =
          await _firebaseAuth.createUserWithEmailAndPassword(
        email: userModel.email!,
        password: userModel.password!,
      );

      User? user = userCredential.user;

      if (user != null) {
        await _usersCollection.doc(user.uid).set({
          'email': userModel.email,
          'username': userModel.username,
        });
        await setDisplayName(userModel.username!);
      }

      return user;
    } catch (e) {
      log('Error during signup: $e');
      return null;
    }
  }

  Future<void> setDisplayName(String displayName) async {
    try {
      User? user = _firebaseAuth.currentUser;

      if (user != null) {
        await user.updateDisplayName(displayName);
        await _usersCollection.doc(user.uid).update({'username': displayName});
      }
    } catch (e) {
      log('Error setting display name: $e');
    }
  }
  // ... other methods ...

// ---------------signIn---------------------------------------

  Future<User?> signInWithEmailAndPassword(
      String email, String password) async {
    try {
      UserCredential credential =
          await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return credential.user;
    } catch (e) {
      log("some error ocurred");
    }
    return null;
  }
}
