import 'package:cucumber_app/main.dart';
import 'package:cucumber_app/presentation/views/home_screen.dart';
import 'package:cucumber_app/presentation/views/sign_up.dart';
import 'package:cucumber_app/presentation/widgets/signing_widgets.dart';
import 'package:cucumber_app/utils/constants/constants.dart';
import 'package:flutter/material.dart';

class Login extends StatelessWidget {
  const Login({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController userNameController = TextEditingController();
    final TextEditingController passwordController = TextEditingController();
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Stack(
            children: [
              ClipRRect(
                borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(65),
                    bottomRight: Radius.circular(65)),
                child: Image.asset(
                  'assets/signup_img.jpg',
                  width: screenWidth,
                  height: screenHeight * 0.35,
                  fit: BoxFit.cover,
                ),
              ),
              Positioned(
                top: screenHeight * 0.13,
                left: screenWidth * 0.25,
                child: const Text('Cucumber',
                    style: TextStyle(color: kwhite, fontSize: 42)),
              ),
              Padding(
                padding: EdgeInsets.only(
                    top: screenHeight * 0.33,
                    right: screenWidth * 0.13,
                    left: screenWidth * 0.13),
                child: Column(children: [
                  Forms(
                    loginText: 'Username',
                    controller: userNameController,
                  ),
                  SizedBox(height: screenHeight * 0.05),
                  Forms(loginText: 'Password', controller: passwordController),
                  SizedBox(height: screenHeight * 0.05),
                  InkWell(
                      onTap: () => Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => Home(),
                          )),
                      child: LoginButton(
                        buttonText: 'Login',
                        email: userNameController.text,
                        password: passwordController.text,
                      )),
                  SizedBox(height: screenHeight * 0.015),
                  const Text('forgot your password?'),
                  SizedBox(
                    height: screenHeight * 0.13,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      TextButton(
                          onPressed: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => const SignUp()));
                          },
                          child: const Text(
                            'SignUp',
                            style: TextStyle(fontSize: 25, color: darkgreen),
                          )),
                      const SigninButton()
                    ],
                  )
                ]),
              )
            ],
          ),
        ),
      ),
    );
  }
}
