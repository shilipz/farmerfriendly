// ignore_for_file: public_member_api_docs, sort_constructors_first, must_be_immutable
// ignore_for_file: use_build_context_synchronously

import 'dart:developer';
import 'package:FarmerFriendly/main.dart';
import 'package:FarmerFriendly/presentation/views/settings/settings.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:FarmerFriendly/presentation/views/contact_details/contact_profile.dart';
import 'package:FarmerFriendly/presentation/views/product/product_homescreen.dart';
import 'package:FarmerFriendly/presentation/views/sales/sales_history.dart';
import 'package:FarmerFriendly/presentation/widgets/contact_form_widgets.dart';
import 'package:FarmerFriendly/utils/constants/constants.dart';
import 'package:google_fonts/google_fonts.dart';

class MainSreensNav extends StatelessWidget {
  const MainSreensNav({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(19),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            InkWell(
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => const ProductsHomescreen(),
                ));
              },
              child: Hometiles(
                heading: "Shall we add some sales today??",
                subheading: 'Click to schedule next sale',
              ),
            ),
            lheight,
            InkWell(
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => ContactProfile(),
                ));
              },
              child: Hometiles(
                  heading: "Is your contact details up-to-date?",
                  subheading: 'Click to add/update contact details'),
            ),
            lheight,
            InkWell(
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => SalesHistory(
                    docId: FirebaseAuth.instance.currentUser!.uid,
                  ),
                ));
              },
              child: Hometiles(
                  heading: "How is our sales so far?",
                  subheading: "Click to see sales history"),
            ),
            lheight,
            InkWell(
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => const SettingScreen(),
                  ));
                },
                child: Hometiles(
                    heading: 'Learn more about us', subheading: 'Settings'))
          ],
        ),
      ),
    );
  }

  Future<bool> checkPaymentSubcollection() async {
    log('payment');
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      // Get the reference to the user's document
      final userDoc =
          FirebaseFirestore.instance.collection('users').doc(user.uid);
      log('payment1');
      // Check if the "payment" subcollection exists
      var paymentSubcollection = await userDoc.get();
      return paymentSubcollection.exists;
    }
    log('payment2');
    return false;
  }
}

class Hometiles extends StatelessWidget {
  String heading;
  String subheading;

  Hometiles({
    Key? key,
    required this.heading,
    required this.subheading,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: screenHeight * 0.15,
      width: double.infinity,
      decoration: BoxDecoration(
          color: Colors.green[300],
          borderRadius: const BorderRadius.all(Radius.circular(20))),
      child: Column(
        children: [
          SizedBox(height: screenHeight * 0.011),
          Text(heading,
              style: GoogleFonts.abyssinicaSil(
                  textStyle: const TextStyle(
                      color: kwhite,
                      fontSize: 18,
                      fontWeight: FontWeight.bold))),
          sheight,
          Next(buttonText: subheading, buttonColor: Colors.yellow.shade500),
        ],
      ),
    );
  }
}
