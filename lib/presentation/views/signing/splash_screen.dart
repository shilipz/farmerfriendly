import 'package:FarmerFriendly/main.dart';
import 'package:FarmerFriendly/presentation/views/home/home_screen.dart';
import 'package:FarmerFriendly/presentation/views/signing/login.dart';
import 'package:FarmerFriendly/utils/constants/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key});

  @override
  Widget build(BuildContext context) {
    Future.delayed(const Duration(seconds: 3), () {
      FirebaseAuth auth = FirebaseAuth.instance;
      if (auth.currentUser != null) {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => const Home()),
        );
      } else {
        Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (context) => const Login(),
        ));
      }
    });

    return Scaffold(
      backgroundColor: kwhite,
      body: _buildBody(context),
    );
  }

  Widget _buildBody(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (snapshot.hasData) {
          return const Home();
        } else if (snapshot.hasError) {
          return const Center(
            child: Text("Something Went Wrong"),
          );
        }
        return _buildSplashContent(context);
      },
    );
  }

  Widget _buildSplashContent(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
              height: screenHeight * .23,
              width: screenWidth * 0.9,
              child: Image.asset('assets/farmernobg.png')),
          Text(
            'FarmerFriendly',
            style: GoogleFonts.aboreto(
              textStyle: const TextStyle(
                color: homeorange,
                letterSpacing: 3,
                fontSize: 36,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
