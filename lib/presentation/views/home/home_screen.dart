import 'dart:developer';
import 'package:FarmerFriendly/presentation/views/chat/chat_screen.dart';
import 'package:FarmerFriendly/presentation/views/settings/settings.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:FarmerFriendly/domain/models/user_model.dart';
import 'package:FarmerFriendly/main.dart';
import 'package:FarmerFriendly/presentation/views/home/main_screens_nav.dart';
import 'package:FarmerFriendly/presentation/widgets/contact_form_widgets.dart';
import 'package:FarmerFriendly/utils/constants/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  final String? receiverId;
  const Home({super.key, this.receiverId});

  @override
  Widget build(BuildContext context) {
    final User? user = FirebaseAuth.instance.currentUser;

    DateTime now = DateTime.now();
    int hour = now.hour;

    String greeting;
    if (hour >= 6 && hour < 12) {
      greeting = 'Good Morning';
    } else if (hour >= 12 && hour < 18) {
      greeting = 'Good Afternoon';
    } else {
      greeting = 'Good Evening';
    }

    return SafeArea(
      child: Scaffold(
        backgroundColor: kwhite,
        body: FutureBuilder<UserModel>(
          future: _getUserData(user!.uid),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Error ${snapshot.error}'));
            } else if (!snapshot.hasData) {
              return const Center(child: Text("user not found"));
            } else {
              var userData = snapshot.data;
              var username = userData?.username;
              return Container(
                height: screenHeight,
                decoration: const BoxDecoration(
                    gradient:
                        LinearGradient(colors: [Colors.green, Colors.teal])),
                child: Padding(
                  padding: EdgeInsets.only(top: screenHeight * 0.03),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(20),
                          child: WelcomeCaptions(
                              captionColor: kwhite,
                              captions: '$greeting , $username'),
                        ),

                        SizedBox(
                            height: screenHeight * .23,
                            width: screenWidth * 0.9,
                            child: Image.asset('assets/farmernobg.png')),
                        // SizedBox(height: screenHeight * 0.09),
                        const MainSreensNav(),
                      ],
                    ),
                  ),
                ),
              );
            }
          },
        ),
        floatingActionButton: IconButton(
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => const ChatScreen(),
              ));
            },
            icon: const CircleAvatar(
              backgroundColor: Colors.white,
              radius: 28,
              child: Icon(
                Icons.message,
                color: Colors.green,
                size: 32,
              ),
            )),
      ),
    );
  }

  Future<UserModel> _getUserData(String? uid) async {
    DocumentSnapshot userSnapshot =
        await FirebaseFirestore.instance.collection('users').doc(uid).get();
    var userData = userSnapshot.data() as Map<String, dynamic>;

    return UserModel(uid: uid, username: userData['username']);
  }
}
