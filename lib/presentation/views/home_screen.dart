import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cucumber_app/main.dart';
import 'package:cucumber_app/presentation/views/contact_details.dart';
import 'package:cucumber_app/presentation/views/home/home_screen_widget.dart';
import 'package:cucumber_app/presentation/views/payment.dart';
import 'package:cucumber_app/presentation/views/product/add_products.dart';
import 'package:cucumber_app/presentation/views/settings.dart';
import 'package:cucumber_app/presentation/widgets/contact_form_widgets.dart';
import 'package:cucumber_app/utils/constants/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    final User? user = FirebaseAuth.instance.currentUser;
    return SafeArea(
        child: Scaffold(
      backgroundColor: homeorange,
      body: Stack(
        children: [
          Positioned.fill(
              child: Image.asset('assets/signin.png', fit: BoxFit.fill)),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                  color: kwhite,
                  onPressed: () {},
                  icon: const Icon(Icons.person)),
              IconButton(
                  color: kwhite,
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => const SettingScreen(),
                    ));
                  },
                  icon: const Icon(Icons.settings, size: 32))
            ],
          ),
          FutureBuilder<DocumentSnapshot>(
            future: FirebaseFirestore.instance
                .collection('users')
                .doc(user?.uid)
                .get(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return Center(child: Text('Error ${snapshot.error}'));
              } else if (!snapshot.hasData) {
                return const Center(child: Text("user not found"));
              } else {
                var userData = snapshot.data!.data() as Map<String, dynamic>;
                var username = userData['username'];
                return Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(
                          bottom: screenHeight * 0.1, top: screenHeight * 0.1),
                      child: Captions(
                          captionColor: kwhite, captions: 'Hey , $username'),
                    ),
                    Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          InkWell(
                              onTap: () =>
                                  Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => const AddProducts(),
                                  )),
                              child: const HomeContainer(
                                title: 'Product Selection',
                                subtitle: 'Add products for your next sale',
                              )),
                          sheight,
                          InkWell(
                              onTap: () =>
                                  Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => ContactDetails(),
                                  )),
                              child: const HomeContainer(
                                title: 'Contact Details',
                                subtitle: 'Add/update collection address',
                              )),
                          sheight,
                          InkWell(
                              onTap: () =>
                                  Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => const Payment(),
                                  )),
                              child: const HomeContainer(
                                  title: 'Payment Details')),
                          sheight,
                          InkWell(
                              onTap: () =>
                                  Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => ContactDetails(),
                                  )),
                              child: const HomeContainer(
                                title: 'Sales History',
                                subtitle: 'See previous sales history',
                              )),
                        ],
                      ),
                    ),
                  ],
                );
              }
            },
          ),
        ],
      ),
    ));
  }
}
