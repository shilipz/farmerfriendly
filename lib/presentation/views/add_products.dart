import 'package:cucumber_app/main.dart';
import 'package:cucumber_app/presentation/views/products_info.dart';
import 'package:cucumber_app/presentation/widgets/contact_form_widgets.dart';
import 'package:cucumber_app/presentation/widgets/signing_widgets.dart';
import 'package:cucumber_app/utils/constants/constants.dart';
import 'package:flutter/material.dart';

class AddProducts extends StatelessWidget {
  const AddProducts({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            Image.asset('assets/reg.jpg'),
            const Arrowback(backcolor: kwhite),
            const Captions(
                captions: 'Join Cucumber Sales Team', captionColor: kwhite),
            Padding(
              padding: EdgeInsets.only(top: screenHeight * 0.15),
              child: Container(
                width: screenWidth,
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                      begin: AlignmentDirectional.topStart,
                      end: Alignment.bottomCenter,
                      colors: [kwhite, homeorange]),
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
                      const Text('Select Products',
                          style: TextStyle(fontSize: 20, color: homeorange)),
                      lheight,
                      InkWell(
                        onTap: () =>
                            Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => const ProductDetails(),
                        )),
                        child: Container(
                          width: screenWidth * 0.35,
                          height: screenHeight * 0.06,
                          decoration: const BoxDecoration(
                              color: kwhite,
                              borderRadius: BorderRadiusDirectional.all(
                                  Radius.circular(25))),
                          child: const Center(
                              child: Text(
                            'Onion',
                            style: commonText,
                          )),
                        ),
                      ),
                      const Spacer(),
                      const Next(buttonText: 'Done', buttonColor: lightgreen),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
