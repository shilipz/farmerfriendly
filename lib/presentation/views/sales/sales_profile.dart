import 'package:FarmerFriendly/main.dart';
import 'package:FarmerFriendly/utils/constants/constants.dart';
import 'package:flutter/material.dart';

class SalesProfile extends StatelessWidget {
  const SalesProfile({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            Container(
              decoration: const BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('assets/714094.jpg'), fit: BoxFit.fill),
              ),
            ),
            Positioned(
              child: Container(
                decoration: const BoxDecoration(color: kwhite),
                width: screenHeight * 0.3,
                height: screenHeight * 0.1,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
