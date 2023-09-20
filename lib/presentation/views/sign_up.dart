import 'package:cucumber_app/presentation/widgets/contact_form_widgets.dart';
import 'package:flutter/material.dart';

import '../../main.dart';
import '../../utils/constants/constants.dart';
import '../widgets/signing_widgets.dart';

class SignUp extends StatelessWidget {
  const SignUp({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController usernameController = TextEditingController();
    final TextEditingController passwordController = TextEditingController();
    return SafeArea(
      child: Scaffold(
          body: SingleChildScrollView(
        child: Stack(
          children: [
            Container(
                decoration: const BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage('assets/signin.png'),
                        fit: BoxFit.cover))),
            const Arrowback(backcolor: kwhite),
            const Padding(
              padding: EdgeInsets.only(left: 80),
              child: Captions(captionColor: kwhite, captions: 'Sign Up'),
            ),
            Positioned(
                child: Padding(
              padding: const EdgeInsets.all(80),
              child: Form(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Forms(loginText: 'Email', controller: usernameController),
                    SizedBox(height: screenHeight * 0.05),
                    Forms(
                        loginText: 'Password', controller: passwordController),
                    SizedBox(height: screenHeight * 0.05),
                    const Forms(loginText: 'Confirm Password'),
                    SizedBox(height: screenHeight * 0.05),
                    SignUpButton(
                        buttonText: 'Sign Up',
                        email: usernameController.text,
                        password: passwordController.text),
                    SizedBox(height: screenHeight * 0.015),
                  ],
                ),
              ),
            ))
          ],
        ),
      )),
    );
  }
}
