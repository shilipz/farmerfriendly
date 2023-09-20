import 'package:flutter/material.dart';

import '../../main.dart';
import '../../utils/constants/constants.dart';

class HomeContainer extends StatelessWidget {
  final String label;
  const HomeContainer({required this.label, super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: screenWidth * 0.92,
          height: screenWidth * 0.25,
          decoration: const BoxDecoration(
              color: Color.fromRGBO(239, 245, 241, 1),
              borderRadius: BorderRadius.all(Radius.circular(40))),
          child: Center(
            child: Text(label, style: commonText),
          ),
        ),
      ],
    );
  }
}
