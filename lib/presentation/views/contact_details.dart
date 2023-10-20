import 'package:cucumber_app/main.dart';
import 'package:cucumber_app/presentation/views/map.dart';
import 'package:cucumber_app/presentation/widgets/contact_form_widgets.dart';
import 'package:cucumber_app/presentation/widgets/signing_widgets.dart';
import 'package:cucumber_app/utils/constants/constants.dart';
import 'package:flutter/material.dart';

class ContactDetails extends StatelessWidget {
  ContactDetails({super.key});
  final _formkey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldMessengerState> _scaffoldKey =
      GlobalKey<ScaffoldMessengerState>();

  // ... Your other variables and methods

  void _showSnackBar(String message) {
    final snackBar = SnackBar(content: Text(message));
    _scaffoldKey.currentState!.showSnackBar(snackBar);
  }

  String? validateFullName(String? value) {
    if (value == null || value.isEmpty) {
      return 'Full name cant be empty';
    }

    return null;
  }

  String? validatePhoneNumber(String? value) {
    if (value == null || value.isEmpty) {
      return 'Phone Number is required';
    }

    return null;
  }

  String? validateFarmName(String? value) {
    if (value == null || value.isEmpty) {
      return 'House/Farm name  is required';
    }

    return null;
  }

  String? validateStreetName(String? value) {
    if (value == null || value.isEmpty) {
      return 'Street name is required';
    }

    return null;
  }

  String? validatePincode(String? value) {
    if (value == null || value.isEmpty) {
      return 'Pincode is required';
    }

    return null;
  }

  final TextEditingController nameController = TextEditingController();
  final TextEditingController phoneNumberController = TextEditingController();
  final TextEditingController farmNameController = TextEditingController();
  final TextEditingController streetNameController = TextEditingController();
  final TextEditingController landMarkController = TextEditingController();
  final TextEditingController pincodeController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        key: _scaffoldKey,
        body: SingleChildScrollView(
          child: Column(
            children: [
              // Image.asset('assets/reg.jpg'),
              Padding(
                padding: EdgeInsets.only(right: screenWidth * 0.8),
                child: const Arrowback(backcolor: darkgreen),
              ),
              const Captions(
                  captions: 'Join Cucumber Sales Team',
                  captionColor: darkgreen),
              Container(
                height: screenHeight,
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
                  padding: const EdgeInsets.all(25),
                  child: Form(
                    key: _formkey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('Contact Details',
                            style: TextStyle(fontSize: 18, color: darkgreen)),
                        sheight,
                        ContactForm(
                            inputController: nameController,
                            customValidator: validateFullName,
                            formHints: 'Full Name'),
                        sheight,
                        ContactForm(
                            inputController: phoneNumberController,
                            customValidator: validatePhoneNumber,
                            formHints: 'Contact Number'),
                        sheight,
                        // const ContactForm(formHints: 'Email Id'),
                        // sheight,
                        const Text('Address for Collection',
                            style: TextStyle(fontSize: 18, color: darkgreen)),
                        sheight,
                        ContactForm(
                            inputController: farmNameController,
                            customValidator: validateFarmName,
                            formHints: 'House/Farm name'),
                        sheight,
                        ContactForm(
                            inputController: streetNameController,
                            customValidator: validateStreetName,
                            formHints: 'Street Name'),
                        sheight,
                        ContactForm(
                            inputController: landMarkController,
                            formHints: 'Landmark(optional)'),
                        sheight,
                        ContactForm(
                            inputController: pincodeController,
                            customValidator: validatePincode,
                            formHints: 'Pincode'),
                        sheight,
                        const Text('also pin your location on map',
                            style: TextStyle(fontSize: 18, color: darkgreen)),
                        SizedBox(height: screenHeight * 0.01),
                        Center(
                          child: IconButton(
                              onPressed: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => const MapSample(),
                                ));
                              },
                              icon: const Icon(
                                Icons.location_pin,
                                size: 42,
                                color: Colors.red,
                              )),
                        ),
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
