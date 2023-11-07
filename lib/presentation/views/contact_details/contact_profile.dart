import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cucumber_app/main.dart';
import 'package:cucumber_app/presentation/views/contact_details/location.dart';
import 'package:cucumber_app/presentation/widgets/contact_form_widgets.dart';
import 'package:cucumber_app/presentation/widgets/signing_widgets.dart';
import 'package:cucumber_app/utils/constants/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ContactProfile extends StatelessWidget {
  ContactProfile({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.only(right: screenWidth * 0.8),
                child: const Arrowback(backcolor: darkgreen),
              ),
              const Captions(
                  captions: 'Contact Profile', captionColor: darkgreen),
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
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('Contact Details',
                            style: TextStyle(fontSize: 18, color: darkgreen)),
                        sheight,
                        //------------------------------contact---------------------------------------
                        Container(
                          height: screenHeight * 0.065,
                          width: screenWidth * 0.76,
                          decoration: BoxDecoration(
                              color: transOrange,
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(60))),
                          child: const Padding(
                            padding: EdgeInsets.only(left: 34, top: 12),
                            child: Text(
                              'data',
                              style: TextStyle(fontSize: 18),
                            ),
                          ),
                        ),
                        sheight,
                        Container(
                          height: screenHeight * 0.065,
                          width: screenWidth * 0.76,
                          decoration: BoxDecoration(
                              color: transOrange,
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(60))),
                          child: const Padding(
                            padding: EdgeInsets.only(left: 34, top: 12),
                            child: Text(
                              'data',
                              style: TextStyle(fontSize: 18),
                            ),
                          ),
                        ),
                        sheight,
                        const Text('Address for Collection',
                            style: TextStyle(fontSize: 18, color: darkgreen)),
                        sheight,
                        Container(
                          height: screenHeight * 0.065,
                          width: screenWidth * 0.76,
                          decoration: BoxDecoration(
                              color: transOrange,
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(60))),
                          child: const Padding(
                            padding: EdgeInsets.only(left: 34, top: 12),
                            child: Text(
                              'data',
                              style: TextStyle(fontSize: 18),
                            ),
                          ),
                        ),
                        sheight,
                        Container(
                          height: screenHeight * 0.065,
                          width: screenWidth * 0.76,
                          decoration: BoxDecoration(
                              color: transOrange,
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(60))),
                          child: const Padding(
                            padding: EdgeInsets.only(left: 34, top: 12),
                            child: Text(
                              'data',
                              style: TextStyle(fontSize: 18),
                            ),
                          ),
                        ),
                        sheight,
                        Container(
                          height: screenHeight * 0.065,
                          width: screenWidth * 0.76,
                          decoration: BoxDecoration(
                              color: transOrange,
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(60))),
                          child: const Padding(
                            padding: EdgeInsets.only(left: 34, top: 12),
                            child: Text(
                              'data',
                              style: TextStyle(fontSize: 18),
                            ),
                          ),
                        ),
                        sheight,
                        Container(
                          height: screenHeight * 0.065,
                          width: screenWidth * 0.76,
                          decoration: BoxDecoration(
                              color: transOrange,
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(60))),
                          child: const Padding(
                            padding: EdgeInsets.only(left: 34, top: 12),
                            child: Text(
                              'data',
                              style: TextStyle(fontSize: 18),
                            ),
                          ),
                        ),
                        sheight,
                        SizedBox(height: screenHeight * 0.01),
                        Next(
                            onPressed: () {
                              {
                                return addUserDetails(context);
                              }
                            },
                            buttonText: 'Save',
                            buttonColor: darkgreen),
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

  Future<void> addUserDetails(BuildContext context) async {
    ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Contact details saved successfully')));
  }

  String formatText(String text) {
    if (text.isEmpty) {
      return text;
    }
    return text[0].toUpperCase() + text.substring(1).toLowerCase();
  }
}
