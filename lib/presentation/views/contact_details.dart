import 'package:cucumber_app/main.dart';
import 'package:cucumber_app/presentation/widgets/contact_form_widgets.dart';
import 'package:cucumber_app/presentation/widgets/signing_widgets.dart';
import 'package:cucumber_app/utils/constants/constants.dart';
import 'package:flutter/material.dart';

class FarmReg extends StatelessWidget {
  const FarmReg({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Stack(
            children: [
              Image.asset('assets/reg.jpg'),
              const Arrowback(backcolor: kwhite),
              Captions(
                  captions: 'Join Cucumber Sales Team', captionColor: kwhite),
              Padding(
                padding: EdgeInsets.only(top: screenHeight * 0.15),
                child: Container(
                  width: screenWidth,
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                        begin: AlignmentDirectional.topStart,
                        end: Alignment.bottomCenter,
                        colors: [kwhite, lightgreen]),
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(40),
                      topRight: Radius.circular(40),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(33),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('Contact Details',
                            style: TextStyle(fontSize: 18, color: darkgreen)),
                        sheight,
                        const ContactForm(formHints: 'Full Name'),
                        sheight,
                        const ContactForm(formHints: 'Contact Number'),
                        sheight,
                        const ContactForm(formHints: 'Email Id'),
                        sheight,
                        const Text('Address for Collection',
                            style: TextStyle(fontSize: 18, color: darkgreen)),
                        sheight,
                        const ContactForm(formHints: 'House/Farm name'),
                        sheight,
                        const ContactForm(formHints: 'Street Name'),
                        sheight,
                        const ContactForm(formHints: 'Landmark(optional)'),
                        sheight,
                        const ContactForm(formHints: 'Pincode'),
                        sheight,
                        const Text('also pin your location on map',
                            style: TextStyle(fontSize: 18, color: darkgreen)),
                        SizedBox(height: screenHeight * 0.01),
                        const Next(buttonText: 'Next', buttonColor: lightgreen),
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
