import 'package:FarmerFriendly/main.dart';
import 'package:FarmerFriendly/presentation/views/settings/about.dart';
import 'package:FarmerFriendly/presentation/views/signing/login.dart';
import 'package:FarmerFriendly/presentation/widgets/contact_form_widgets.dart';
import 'package:FarmerFriendly/presentation/widgets/signing_widgets.dart';
import 'package:FarmerFriendly/utils/constants/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SettingScreen extends StatelessWidget {
  const SettingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: SingleChildScrollView(
        child: Container(
          decoration: const BoxDecoration(
              gradient: LinearGradient(colors: [Colors.green, Colors.teal])),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding(
                padding: EdgeInsets.all(10),
                child: Row(
                  children: [
                    Arrowback(backcolor: kwhite),
                    Captions(captionColor: kwhite, captions: 'Settings')
                  ],
                ),
              ),
              Container(
                height: screenHeight,
                width: screenWidth,
                color: Colors.yellow[100],
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          const Icon(
                            Icons.share,
                            color: kblack,
                          ),
                          TextButton(
                              onPressed: () {},
                              child: const Text(
                                'Share',
                                style: TextStyle(color: kblack, fontSize: 16),
                              )),
                        ],
                      ),
                      Row(
                        children: [
                          const Icon(
                            Icons.edit_document,
                            color: kblack,
                          ),
                          TextButton(
                              onPressed: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => const AboutScreen()));
                              },
                              child: const Text(
                                'About',
                                style: TextStyle(color: kblack, fontSize: 16),
                              )),
                        ],
                      ),
                      Row(
                        children: [
                          const Icon(
                            Icons.logout,
                            color: kblack,
                          ),
                          TextButton(
                              onPressed: () {
                                showAlertDialog(context);
                              },
                              child: const Text(
                                'Signout',
                                style: TextStyle(color: kblack, fontSize: 16),
                              )),
                        ],
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    ));
  }

  void showAlertDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Sign-out'),
        content: const Text('Are you sure you want to sign out?'),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text('Cancel'),
          ),
          TextButton(
              onPressed: () {
                FirebaseAuth.instance.signOut();
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => Login()),
                  (Route<dynamic> route) => false,
                );
              },
              child: const Text('Sign out'))
        ],
      ),
    );
  }
}
