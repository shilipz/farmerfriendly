import 'package:cucumber_app/utils/constants/constants.dart';
import 'package:flutter/material.dart';
import '../../main.dart';
import '../widgets/signing_widgets.dart';

class SignIn extends StatelessWidget {
  const SignIn({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          body: Stack(
        children: [
          Container(
              decoration: const BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage('assets/signin.png'),
                      fit: BoxFit.cover))),
          const Arrowback(backcolor: kwhite),
          Positioned(
              child: Padding(
            padding: const EdgeInsets.all(80),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SignInCard(cardtext: 'SignUp to Sell'),
                SizedBox(height: screenHeight * 0.09),
                const SignInCard(cardtext: 'SignUp to Buy'),
              ],
            ),
          ))
        ],
      )),
    );
  }
}
