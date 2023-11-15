// ignore_for_file: use_build_context_synchronously

import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cucumber_app/main.dart';
import 'package:cucumber_app/presentation/presentation_logic/quantity_button/quantity_button_bloc.dart';
import 'package:cucumber_app/presentation/widgets/contact_form_widgets.dart';
import 'package:cucumber_app/presentation/widgets/sales_widgets.dart';
import 'package:cucumber_app/presentation/widgets/signing_widgets.dart';
import 'package:cucumber_app/utils/constants/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:table_calendar/table_calendar.dart';

class ProductDetails extends StatefulWidget {
  final String vegetableName;
  final int vegetablePrice;
  final int? quantity;
  // final DateTime collectionDate;
  const ProductDetails({
    super.key,
    required this.vegetableName,
    required this.vegetablePrice,
    this.quantity,
    // required this.collectionDate
  });

  @override
  State<ProductDetails> createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {
  final QuantityButtonBloc quantityButtonBloc = QuantityButtonBloc();
  @override
  Widget build(BuildContext context) {
    DateTime selectedDay = today;
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Stack(
            children: [
              Image.asset('assets/sale info.png', fit: BoxFit.cover),
              const Arrowback(backcolor: kwhite),
              const Center(
                child: Captions(
                    captions: 'Tell us  about your Sales',
                    captionColor: kwhite),
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
                        SalesContainer(saleText: "${widget.vegetablePrice}"),
                        kwidth,
                        const Text("per Kg ", style: commonText),
                      ],
                    ),
                    const Text('(for successful quality analysis)'),
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
                    sheight,
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
                        width: 90,
                        height: 40,
                        child: BlocBuilder<QuantityButtonBloc,
                            QuantityButtonState>(
                          builder: (context, state) {
                            return ElevatedButton(
                              onPressed: () {
                                _addVegetableToFirestore(
                                    context,
                                    widget.vegetableName,
                                    selectedDay,
                                    state.quantity);
                              },
                              style: ButtonStyle(
                                  backgroundColor:
                                      MaterialStateProperty.all<Color>(
                                          lightgreen),
                                  shape: MaterialStateProperty.all<
                                          RoundedRectangleBorder>(
                                      RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(25),
                                  ))),
                              child: const Text(
                                'Done',
                                style: TextStyle(fontSize: 18, color: kwhite),
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
    );
  }
}

void _addVegetableToFirestore(BuildContext context, String vegetableName,
    DateTime selectedDay, int quantity) async {
  // Get the current user
  log('collection created');
  User? user = FirebaseAuth.instance.currentUser;

  if (user != null) {
    CollectionReference users = FirebaseFirestore.instance.collection('users');

    DocumentReference userDocument = users.doc(user.uid);

    await userDocument.collection('selling_vegetables').add({
      'vegetable_name': vegetableName,
      'isOnSale': false,
      'quantity': quantity,
      'timestamp': FieldValue.serverTimestamp(),
      'collection_date': selectedDay
    });

    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
      content: Text('Vegetable added to your next sale.'),
    ));
    Navigator.of(context).pop();
  } else {}
}

DateTime today = DateTime.now();
