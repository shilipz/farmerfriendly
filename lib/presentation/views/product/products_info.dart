// ignore_for_file: public_member_api_docs, sort_constructors_first
// ignore_for_file: use_build_context_synchronously

import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';

import 'package:FarmerFriendly/main.dart';
import 'package:FarmerFriendly/presentation/presentation_logic/quantity_button/quantity_button_bloc.dart';
import 'package:FarmerFriendly/presentation/widgets/contact_form_widgets.dart';
import 'package:FarmerFriendly/presentation/widgets/sales_widgets.dart';
import 'package:FarmerFriendly/presentation/widgets/signing_widgets.dart';
import 'package:FarmerFriendly/utils/constants/constants.dart';

class ProductDetails extends StatefulWidget {
  final String vegetableName;
  final int vegetablePrice;
  final int? quantity;
  final String imageURL;
  // final DateTime collectionDate;
  const ProductDetails({
    Key? key,
    required this.vegetableName,
    required this.vegetablePrice,
    this.quantity,
    required this.imageURL,
  }) : super(key: key);

  @override
  State<ProductDetails> createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {
  DateTime today = DateTime.now();

  final QuantityButtonBloc quantityButtonBloc = QuantityButtonBloc();
  @override
  Widget build(BuildContext context) {
    DateTime selectedDay = today;
    return SafeArea(
      child: Scaffold(
        body: Container(
          height: screenHeight,
          width: screenWidth,
          decoration: BoxDecoration(
            color: Colors.yellow[100],
          ),
          child: SingleChildScrollView(
            child: Column(
              children: [
                // Image.asset('assets/sale info.png', fit: BoxFit.cover),
                Container(
                  decoration: const BoxDecoration(
                      gradient:
                          LinearGradient(colors: [Colors.green, Colors.teal])),
                  child: const Padding(
                    padding: EdgeInsets.all(10),
                    child: Row(
                      children: [
                        Arrowback(backcolor: kwhite),
                        Captions(
                            captions: 'Tell us  about your Sales',
                            captionColor: kwhite),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: screenHeight * 0.08, left: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          const Text("Today's Price", style: commonText),
                          kwidth,
                          SalesContainer(saleText: "${widget.vegetablePrice}"),
                          kwidth,
                          const Text("per Kg ", style: commonText),
                        ],
                      ),
                      const Text(
                        '(for successful quality analysis)',
                        style: TextStyle(color: kblack),
                      ),
                      sheight,
                      Text(widget.vegetableName, style: commonHeading),
                      sheight,
                      Row(
                        children: [
                          const Text('Quantity', style: commonText),
                          kwidth,
                          QuantityButton(
                              onpressed: () {
                                BlocProvider.of<QuantityButtonBloc>(context)
                                    .add(DecreaseQuantity());
                              },
                              quantityIcon: Icons.remove),
                          kwidth,
                          BlocBuilder<QuantityButtonBloc, QuantityButtonState>(
                            builder: (context, state) {
                              return SalesContainer(
                                  saleText: state.quantity.toString());
                            },
                          ),
                          kwidth,
                          QuantityButton(
                              onpressed: () {
                                BlocProvider.of<QuantityButtonBloc>(context)
                                    .add(IncreaseQuantity());
                              },
                              quantityIcon: Icons.add),
                        ],
                      ),
                      sheight,
                      const Row(
                        children: [
                          Text('Availability Schedule', style: commonText),
                          Spacer(),
                        ],
                      ),
                      lheight,
                      const Center(
                          child: Text('pick a day from calendar',
                              style: commonText)),
                      lheight,
                      Padding(
                        padding: const EdgeInsets.only(left: 12, right: 12),
                        child: Container(
                          decoration: const BoxDecoration(
                              color: kwhite,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20))),
                          child: TableCalendar(
                              selectedDayPredicate: (day) {
                                // Use the _selectedDay variable to highlight the selected day
                                return isSameDay(today, day);
                              },
                              onDaySelected: (selectedDay, focusedDay) {
                                // Update the _selectedDay variable when a day is selected
                                setState(() {
                                  today = selectedDay;
                                });
                              },
                              rowHeight: 35,
                              focusedDay: today,
                              firstDay: DateTime.utc(2010, 10, 16),
                              lastDay: DateTime.utc(2030, 3, 14)),
                        ),
                      ),
                      sheight,
                      Center(
                        child: SizedBox(
                          // width: 90,
                          // height: 60,
                          child: BlocBuilder<QuantityButtonBloc,
                              QuantityButtonState>(
                            builder: (context, state) {
                              return ElevatedButton(
                                onPressed: () {
                                  _addVegetableToFirestore(
                                      context,
                                      widget.vegetableName,
                                      widget.vegetablePrice,
                                      selectedDay,
                                      state.quantity,
                                      widget.imageURL);
                                },
                                style: ButtonStyle(
                                    backgroundColor:
                                        MaterialStateProperty.all<Color>(
                                            Colors.yellow),
                                    shape: MaterialStateProperty.all<
                                            RoundedRectangleBorder>(
                                        RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(25),
                                    ))),
                                child: const Text(
                                  'Done',
                                  style: TextStyle(fontSize: 18, color: kblack),
                                ),
                              );
                            },
                          ),
                        ),
                      )
                    ],
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

void _addVegetableToFirestore(
    BuildContext context,
    String vegetableName,
    int vegetablePrice,
    DateTime selectedDay,
    int quantity,
    String imageURL) async {
  // Get the current user
  log('collection created');
  User? user = FirebaseAuth.instance.currentUser;

  if (user != null) {
    DateTime today = DateTime.now();

    if (selectedDay.isBefore(today) || selectedDay.isAtSameMomentAs(today)) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        backgroundColor: Colors.red,
        content: Text(
          'Please select a date after today.',
        ),
      ));
      return;
    } else {
      CollectionReference users =
          FirebaseFirestore.instance.collection('users');

      DocumentReference userDocument = users.doc(user.uid);

      // Check if the vegetable with the same name and collection date already exists
      QuerySnapshot existingVegetables = await userDocument
          .collection('selling_vegetables')
          .where('vegetable_name', isEqualTo: vegetableName)
          .where('collection_date', isEqualTo: selectedDay)
          .get();

      if (existingVegetables.docs.isNotEmpty) {
        // If the vegetable already exists, display a SnackBar and return
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content:
                Text('This vegetable is already added for the selected date.'),
          ),
        );
        return;
      }
      await userDocument.collection('selling_vegetables').add({
        'vegetable_name': vegetableName,
        'isOnSale': false,
        'quantity': quantity,
        'timestamp': FieldValue.serverTimestamp(),
        'collection_date':
            DateFormat('dd MMMM').format(selectedDay), // Format DateTime
        'vegPrice': vegetablePrice,
        'imageURL': imageURL
      });
      final email = FirebaseAuth.instance.currentUser!.email;
      FirebaseFirestore.instance.collection('insales').doc().set({
        'vegetable_name': vegetableName,
        'isOnSale': false,
        'quantity': quantity,
        'timestamp': FieldValue.serverTimestamp(),
        'collection_date':
            DateFormat('dd MMMM').format(selectedDay), // Format DateTime
        'email': email,
        'username': user.displayName,
        'vegPrice': vegetablePrice,
        'imageURL': imageURL
      });
// FirebaseFirestore.
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        backgroundColor: Colors.green,
        content: Text('Vegetable added to your next sale.'),
      ));
      Navigator.of(context).pop();
    }
  }
  return null;
}
