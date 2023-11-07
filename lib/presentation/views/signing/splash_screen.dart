import 'package:cucumber_app/utils/constants/constants.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 189, 196, 8),
      body: SizedBox(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: const Center(
            child: Text(
              'Cucumber',
              style: TextStyle(color: kwhite, fontSize: 42),
            ),
          )),
    );
  }
}
