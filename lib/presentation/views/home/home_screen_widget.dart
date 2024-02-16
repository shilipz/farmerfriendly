import 'package:FarmerFriendly/main.dart';
import 'package:FarmerFriendly/utils/constants/constants.dart';
import 'package:flutter/material.dart';

class HomeContainer extends StatelessWidget {
  final String title;
  final String? subtitle;
  final IconData? notificatn;
  const HomeContainer(
      {this.notificatn, super.key, required this.title, this.subtitle});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: screenWidth * 0.8,
          height: screenHeight * 0.1,
          decoration: const BoxDecoration(
              color: Colors.white70,
              borderRadius: BorderRadius.all(Radius.circular(25))),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(title,
                  style: const TextStyle(
                      fontSize: 23,
                      color: kblack,
                      fontWeight: FontWeight.w500)),
              Text(subtitle ?? "")
            ],
          ),
        ),
      ],
    );
  }
}
