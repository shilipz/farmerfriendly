import 'dart:developer';

import 'package:cucumber_app/presentation/views/contact_details.dart';
import 'package:cucumber_app/presentation/views/home_screen.dart';
import 'package:cucumber_app/presentation/views/login.dart';
import 'package:cucumber_app/presentation/views/splash_screen.dart';
import 'package:cucumber_app/utils/authorisation.dart';
import 'package:cucumber_app/utils/constants/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../../main.dart';

class Forms extends StatelessWidget {
  final String loginText;
  final TextEditingController? controller;
  const Forms({required this.loginText, this.controller, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 300,
      height: 50,
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
          hintText: loginText,
          hintStyle: const TextStyle(color: hintcolor),
          prefix: const SizedBox(
            width: 25,
            height: 30,
          ),
          filled: true,
          fillColor: Colors.grey[300],
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(100),
            borderSide: BorderSide.none,
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(100),
            borderSide: BorderSide.none,
          ),
          border: InputBorder.none,
        ),
      ),
    );
  }
}

class SignUpButton extends StatelessWidget {
  final String buttonText;
  final String password;
  final String email;
  const SignUpButton(
      {required this.buttonText,
      super.key,
      required this.password,
      required this.email});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 300,
      height: 50,
      child: ElevatedButton(
        onPressed: () async {
          await signUp(email, password);
        },
        style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all<Color>(lightgreen),
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(25),
            ))),
        child: Text(
          buttonText,
          style: const TextStyle(fontSize: 18),
        ),
      ),
    );
  }
}

class SigninButton extends StatelessWidget {
  const SigninButton({super.key});

  @override
  Widget build(BuildContext context) {
    return const Icon(Icons.login, color: darkgreen, size: 45);
  }
}

// arrow button calling widget
class SignInCard extends StatelessWidget {
  final String cardtext;
  const SignInCard({required this.cardtext, super.key});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: Container(
        width: screenWidth * 0.9,
        height: screenHeight * 0.20,
        decoration: const BoxDecoration(color: Colors.white),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Text(cardtext, style: TextStyle(fontSize: 20, color: darkgreen)),
            TextButton(
                onPressed: () {
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => const FarmReg()));
                },
                child: Text(cardtext,
                    style: const TextStyle(fontSize: 20, color: darkgreen))),
            const SigninButton()
          ],
        ),
      ),
    );
  }
}

class Arrowback extends StatelessWidget {
  final Color backcolor;
  const Arrowback({required this.backcolor, super.key});

  @override
  Widget build(BuildContext context) {
    return Positioned(
        child: Padding(
      padding: const EdgeInsets.all(17),
      child: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back_ios, size: 25, color: backcolor)),
    ));
  }
}

class LoginButton extends StatelessWidget {
  final String buttonText;
  final String email;
  final String password;
  const LoginButton(
      {required this.buttonText,
      super.key,
      required this.email,
      required this.password});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 300,
      height: 50,
      child: ElevatedButton(
        onPressed: () async {
          if (FirebaseAuth.instance.currentUser != null) {
            await signIn(email, password);
            Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => Home(),
            ));
          }
        },
        style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all<Color>(lightgreen),
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(25),
            ))),
        child: Text(
          buttonText,
          style: const TextStyle(fontSize: 18),
        ),
      ),
    );
  }
}
