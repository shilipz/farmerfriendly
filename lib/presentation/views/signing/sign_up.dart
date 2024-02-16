// ignore_for_file: public_member_api_docs, sort_constructors_first
// ignore_for_file: use_build_context_synchronously

import 'dart:developer';

import 'package:FarmerFriendly/domain/models/user_model.dart';
import 'package:FarmerFriendly/domain/repositories/auth.dart';
import 'package:FarmerFriendly/main.dart';
import 'package:FarmerFriendly/presentation/views/home/home_screen.dart';
import 'package:FarmerFriendly/presentation/views/signing/login.dart';
import 'package:FarmerFriendly/presentation/widgets/signing_widgets.dart';
import 'package:FarmerFriendly/utils/constants/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rive/rive.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({
    Key? key,
    this.customValidator,
  }) : super(key: key);

  final String? Function(String?)? customValidator;

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final FirebaseAuthServices _auth = FirebaseAuthServices();

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController usernameController = TextEditingController();

  @override
  void dispose() {
    // Dispose the controllers when they are no longer needed to prevent memory leaks
    emailController.dispose();
    passwordController.dispose();
    usernameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.green.shade300,
        body: SingleChildScrollView(
          child: Column(
            children: [
              lheight,
              const LoginHeading(
                signingText: 'Sign Up',
                textcolor: kwhite,
              ),
              Padding(
                padding: const EdgeInsets.all(80),
                child: Form(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _buildUsernameField(),
                      SizedBox(height: screenHeight * 0.05),
                      Forms(
                          loginText: 'Email', inputController: emailController),
                      SizedBox(height: screenHeight * 0.05),
                      Forms(
                        loginText: 'Password',
                        obscureText: true,
                        inputController: passwordController,
                      ),
                      SizedBox(height: screenHeight * 0.05),
                      Forms(
                        loginText: 'Confirm Password',
                        obscureText: true,
                      ),
                      SizedBox(height: screenHeight * 0.05),
                      SignUpButton(
                        buttonText: 'Sign Up',
                        onPressed: () async {
                          await _signup(context);
                        },
                      ),
                      SizedBox(height: screenHeight * 0.015),
                      _buildLoginText(),
                      lheight,
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildUsernameField() {
    return SizedBox(
      height: 50,
      child: TextFormField(
        textCapitalization: TextCapitalization.words,
        validator: (value) {
          if (widget.customValidator != null) {
            final customError = widget.customValidator!(value);
            if (customError != null) {
              return customError;
            }
          }
          return null;
        },
        controller: usernameController,
        decoration: InputDecoration(
          hintText: 'Username',
          hintStyle: const TextStyle(color: hintcolor),
          prefix: const SizedBox(width: 25, height: 30),
          filled: true,
          fillColor: Colors.grey[300],
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide.none,
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide.none,
          ),
          border: InputBorder.none,
        ),
      ),
    );
  }

  Widget _buildLoginText() {
    return Center(
      child: InkWell(
        onTap: () {
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) => const Login()));
        },
        child: const Text('Back to login page', style: TextStyle(fontSize: 15)),
      ),
    );
  }

  showLoading(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return const RiveAnimation.asset(
            'assets/511-976-dot-loading-loaders.riv');
      },
    );
  }

  Future<void> _signup(BuildContext context) async {
    UserModel userModel = UserModel(
      email: emailController.text,
      password: passwordController.text,
      username: _capitalizeFirstLetter(usernameController.text),
    );

    showLoading(context);

    User? user = await _auth.signUpWithEmailAndPassword(userModel);

    if (user != null) {
      _navigateToHome(context);
    } else if (emailController.text.isEmpty ||
        passwordController.text.isEmpty) {
      _showSnackBar(context, "Please fill all fields", Colors.red);
      Navigator.of(context).pop();
    } else {
      _showSnackBar(
          context, "Password should be atleast 6 letters long", Colors.orange);
      Navigator.of(context).pop();
      _showSnackBar(context, "Profile created successfully", Colors.green);
      // _logError("User is null - some error happened");
    }
  }

  void _navigateToHome(BuildContext context) {
    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => const Login(),
    ));
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
      backgroundColor: Colors.orange,
      content: Text('Profile created successfully'),
    ));
  }

  String _capitalizeFirstLetter(String text) {
    return text.isEmpty ? text : text[0].toUpperCase() + text.substring(1);
  }

  void _showSnackBar(
      BuildContext context, String message, Color backgroundColor) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: backgroundColor,
        content: Text(message),
      ),
    );
  }
}
