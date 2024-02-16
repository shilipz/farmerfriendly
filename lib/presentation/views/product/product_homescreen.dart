import 'package:FarmerFriendly/main.dart';
import 'package:FarmerFriendly/presentation/views/home/home_screen.dart';
import 'package:FarmerFriendly/presentation/views/product/in_sale_vegs.dart';
import 'package:FarmerFriendly/presentation/views/product/products.dart';

import 'package:FarmerFriendly/presentation/views/product/requests.dart';
import 'package:FarmerFriendly/presentation/widgets/contact_form_widgets.dart';
import 'package:FarmerFriendly/utils/constants/constants.dart';
import 'package:flutter/material.dart';

class ProductsHomescreen extends StatefulWidget {
  const ProductsHomescreen({super.key});

  @override
  State<ProductsHomescreen> createState() => _ProductsHomescreenState();
}

class _ProductsHomescreenState extends State<ProductsHomescreen> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: SafeArea(
        child: Scaffold(
          body: Container(
            height: screenHeight,
            width: screenWidth,
            decoration: const BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.topRight,
                    colors: [Colors.green, Colors.teal])),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: Row(
                    children: [
                      IconButton(
                          onPressed: () {
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const Home(),
                                ));
                          },
                          icon: const Icon(Icons.arrow_back_ios,
                              size: 25, color: kwhite)),
                      const Captions(
                          captionColor: kwhite, captions: 'Join Our Sales team')
                    ],
                  ),
                ),
                lheight,
                const TabBar(
                  labelColor: kwhite,
                  overlayColor: MaterialStatePropertyAll(kwhite),
                  indicatorColor: kwhite,
                  tabs: [
                    Tab(
                      text: 'Add Products',
                    ),
                    Tab(text: 'Current sales'),
                    Tab(
                      text: 'Pending Request',
                    )
                  ],
                ),
                const Expanded(
                  child: TabBarView(
                    children: [AddProducts(), InSale(), PendingVeggies()],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
