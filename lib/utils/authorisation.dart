import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';

Future<void> signIn(String email, String password) async {
  try {
    await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password);
  } on FirebaseAuthException catch (e) {
    print(e);
  }
}

signUp(String email, String password) async {
  try {
    log('hello');
    final UserCredential userdata = await FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: password);
    if (userdata.user == null) {
      log('no');
    } else {
      log('yes');
    }
    // if (FirebaseAuth.instance.currentUser != null) {
    //   log(FirebaseAuth.instance.currentUser!.uid);
    // } else {
    //   log('failed');
    // }
  } on FirebaseAuthException catch (e) {
    log('signup error $e');
  }
}
