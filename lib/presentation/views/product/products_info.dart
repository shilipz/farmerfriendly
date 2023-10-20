import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cucumber_app/main.dart';
import 'package:cucumber_app/presentation/widgets/contact_form_widgets.dart';
import 'package:cucumber_app/presentation/widgets/sales_widgets.dart';
import 'package:cucumber_app/presentation/widgets/signing_widgets.dart';
import 'package:cucumber_app/utils/constants/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class ProductDetails extends StatelessWidget {
  final String vegetableName;
  final int vegetablePrice;
  // final int quantity;
  // final DateTime collectionDate;
  const ProductDetails({
    super.key,
    required this.vegetableName,
    required this.vegetablePrice,
    // required this.quantity,
    // required this.collectionDate
  });
  void _addVegetableDetailsToFirestore(context) async {
    User? user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      try {
        // Reference to the specific vegetable document in the 'vegetables' collection
        DocumentReference vegetableDocument = FirebaseFirestore.instance
            .collection('vegetables')
            .doc(vegetableName);

        // Update the vegetable details including quantity and collection date
        await vegetableDocument.update({
          'isOnSale': true,
          // 'quantity': quantity,
          //  'collectionDate':
          //      collectionDate, // Assuming 'collectionDate' is the field in Firestore
        });

        // Show a toast or a snackbar to indicate success
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          backgroundColor: Colors.green,
          content: Text('$vegetableName details updated successfully.'),
        ));
      } catch (error) {
        print('Error updating vegetable details: $error');
        // Handle error as needed
      }
    } else {
      // User is not signed in, handle accordingly
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
            child: Stack(
          children: [
            Image.asset('assets/sale info.png', fit: BoxFit.cover),
            const Arrowback(backcolor: kwhite),
            const Center(
              child: Captions(
                  captions: 'Tell us  about your Sales', captionColor: kwhite),
            ),
            Padding(
              padding: EdgeInsets.only(top: screenHeight * 0.17, left: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const Text("Today's Price", style: commonText),
                      kwidth,
                      SalesContainer(saleText: "$vegetablePrice"),
                      kwidth,
                      const Text("per Kg ", style: commonText),
                    ],
                  ),
                  const Text('(for successful quality analysis)'),
                  sheight,
                  Text(vegetableName, style: commonHeading),
                  sheight,
                  Row(
                    children: [
                      const Text('Quantity', style: commonText),
                      kwidth,
                      const QuantityButton(quantityIcon: Icons.remove),
                      kwidth,
                      const SalesContainer(saleText: '3'),
                      kwidth,
                      const QuantityButton(quantityIcon: Icons.add),
                    ],
                  ),
                  sheight,
                  Row(
                    children: [
                      const Text('Availability Schedule', style: commonText),
                      const Spacer(),
                      DayDropdown(
                        selectedDay: DayOfWeek.Monday,
                        onDayChanged: (newDay) {},
                      ),
                    ],
                  ),
                  sheight,
                  const Center(child: Text('Or', style: commonText)),
                  sheight,
                  const Center(
                      child:
                          Text('pick a day from calendar', style: commonText)),
                  sheight,
                  Padding(
                    padding: const EdgeInsets.only(left: 12, right: 12),
                    child: Container(
                      decoration: const BoxDecoration(
                          color: kwhite,
                          borderRadius: BorderRadius.all(Radius.circular(20))),
                      child: TableCalendar(
                          rowHeight: 35,
                          focusedDay: today,
                          firstDay: DateTime.utc(2010, 10, 16),
                          lastDay: DateTime.utc(2030, 3, 14)),
                    ),
                  ),
                  sheight,
                  Center(
                    child: SizedBox(
                      width: 90,
                      height: 40,
                      child: ElevatedButton(
                        onPressed: () {
                          _addVegetableToFirestore(context, vegetableName);
                        },
                        style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all<Color>(lightgreen),
                            shape: MaterialStateProperty.all<
                                RoundedRectangleBorder>(RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(25),
                            ))),
                        child: const Text(
                          'Done',
                          style: TextStyle(fontSize: 18, color: kwhite),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            )
          ],
        )),
      ),
    );
  }

  void _addVegetableToFirestore(
      BuildContext context, String vegetableName) async {
    // Get the current user
    log('collection created');
    User? user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      // Reference to the users' collection
      CollectionReference users =
          FirebaseFirestore.instance.collection('users');

      // Reference to the specific user's document
      DocumentReference userDocument = users.doc(user.uid);

      // Create a subcollection 'selling_vegetables' and add vegetable name
      await userDocument.collection('selling_vegetables').add({
        'vegetable_name': vegetableName,
         'isOnSale': false,
        // 'quantity': 0,
        // 'collection_date': ''
        // Add more properties if necessary
      });

      // Show a toast or a snackbar to indicate success
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('Vegetable added to your next sale.'),
      ));
    } else {
      // User is not signed in, handle accordingly
    }
  }
}

DateTime today = DateTime.now();
