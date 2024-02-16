import 'dart:developer';
import 'package:FarmerFriendly/domain/repositories/auth.dart';
import 'package:FarmerFriendly/main.dart';
import 'package:FarmerFriendly/presentation/views/home/home_screen.dart';
import 'package:FarmerFriendly/presentation/views/signing/sign_up.dart';
import 'package:FarmerFriendly/presentation/widgets/signing_widgets.dart';
import 'package:FarmerFriendly/utils/constants/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:rive/rive.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final FirebaseAuthServices _auth = FirebaseAuthServices();

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green.shade300,
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                Card(
                  elevation: 8.0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16.0),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const LoginHeading(
                          signingText: 'FarmerFriendly',
                          textcolor: Colors.teal,
                        ),
                        const SizedBox(height: 16),
                        Forms(
                          loginText: 'Email',
                          inputController: emailController,
                        ),
                        const SizedBox(height: 16),
                        Forms(
                          obscureText: true,
                          loginText: 'Password',
                          inputController: passwordController,
                        ),
                        const SizedBox(height: 16),
                        SignUpButton(
                          buttonText: 'Login',
                          onPressed: () {
                            _signIn(
                              context,
                              emailController.text,
                              passwordController.text,
                            );
                          },
                        ),
                        const SizedBox(height: 16),
                        const Text('Forgot your password?'),
                        const SizedBox(height: 8),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            TextButton(
                              onPressed: () {
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (context) => const SignUpScreen(),
                                  ),
                                );
                              },
                              child: const Text(
                                'Don\'t have an account? Sign Up',
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.blueAccent,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _signIn(
    BuildContext context,
    String email,
    String password,
  ) async {
    try {
      showLoading(context);

      User? user = await _auth.signInWithEmailAndPassword(email, password);
      if (user != null) {
        _navigateToHome(context);
      } else if (_isFieldEmpty(email, password)) {
        _showSnackBar(
            context, "Please fill in all required fields", Colors.red);
      } else {
        _showSnackBar(context, "Invalid email or password", Colors.orange);
      }
    } catch (e) {
      _logSignInError(e);
      _showErrorDialog(context, "Invalid email or password");
    }
  }

  void _navigateToHome(BuildContext context) {
    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(builder: (context) => const Home()),
      (route) => false,
    );
  }

  bool _isFieldEmpty(String email, String password) {
    return email.isEmpty || password.isEmpty;
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

  void _logSignInError(dynamic error) {
    log("Sign-in error: $error");
  }

  void _showErrorDialog(BuildContext context, String message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(message),
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
}
