import 'package:cucumber_app/main.dart';
import 'package:cucumber_app/presentation/widgets/contact_form_widgets.dart';
import 'package:cucumber_app/presentation/widgets/signing_widgets.dart';
import 'package:cucumber_app/utils/constants/constants.dart';
import 'package:flutter/material.dart';

class Payment extends StatelessWidget {
  const Payment({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: kblack,
        body: Stack(
          children: [
            Positioned(
                right: 0,
                child:
                    Image.asset('assets/sale info.png', fit: BoxFit.contain)),
            const Arrowback(backcolor: kwhite),
            const Captions(
                captions: 'Payment Information,', captionColor: kwhite),
            Padding(
              padding: EdgeInsets.only(top: screenHeight * 0.17, left: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text("Bank Details",
                      style: TextStyle(fontSize: 18, color: darkgreen)),
                  sheight,
                  const Text("Account holder's Name", style: commonText),
                  sheight,
                  const ContactForm(),
                  sheight,
                  const Text("Account Number", style: commonText),
                  sheight,
                  const ContactForm(),
                  const Text("Confirm Account Number", style: commonText),
                  sheight,
                  const ContactForm(),
                  sheight,
                  const Text("IFSC Code", style: commonText),
                  sheight,
                  const ContactForm(),
                  const SizedBox(height: 34),
                  Center(
                      child: InkWell(
                          onTap: () => Navigator.of(context).pop(),
                          child: const Next(
                            buttonText: 'Submit',
                            buttonColor: darkgreen,
                          ))),
                  sheight,
                  const Center(
                      child: Text(
                          'By clicking on the submit button, you agreed to our terms and conditions',
                          style: TextStyle(fontSize: 12))),
                  const SizedBox(height: 32),
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.list),
                      Text('Terms & Conditions', style: commonText)
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
