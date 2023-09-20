import 'package:cucumber_app/main.dart';
import 'package:cucumber_app/presentation/views/contact_details.dart';
import 'package:cucumber_app/presentation/views/payment.dart';
import 'package:cucumber_app/presentation/views/products_info.dart';
import 'package:cucumber_app/presentation/widgets/signing_widgets.dart';
import 'package:cucumber_app/utils/constants/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'add_products.dart';
import 'home_screen_widget.dart';

class Home extends StatelessWidget {
  Home({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      backgroundColor: homeorange,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Stack(
            children: [
              SizedBox(
                  width: screenWidth,
                  height: screenWidth - 120,
                  child: Image.asset('assets/final_home_img.png',
                      fit: BoxFit.fill)),
              Positioned(
                  child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Arrowback(backcolor: kblack),
                  IconButton(
                      onPressed: () {},
                      icon: const Icon(Icons.settings, size: 32))
                ],
              ))
            ],
          ),
          InkWell(
              onTap: () => Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => const AddProducts(),
                  )),
              child: const HomeContainer(label: 'Product Selection')),
          InkWell(
              onTap: () => Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => const FarmReg(),
                  )),
              child: const HomeContainer(label: 'Contact Details')),
          InkWell(
              onTap: () => Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => const Payment(),
                  )),
              child: const HomeContainer(label: 'Payment Details')),
          InkWell(
              onTap: () => Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => const FarmReg(),
                  )),
              child: const HomeContainer(label: 'Sales History')),
          const SizedBox(height: 3)
        ],
      ),
    ));
  }
}
