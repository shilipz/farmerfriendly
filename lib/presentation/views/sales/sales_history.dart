// ignore_for_file: prefer_const_constructors

import 'package:FarmerFriendly/main.dart';
import 'package:FarmerFriendly/presentation/widgets/contact_form_widgets.dart';
import 'package:FarmerFriendly/utils/constants/constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../widgets/signing_widgets.dart';

class SalesHistory extends StatelessWidget {
  final String docId;

  const SalesHistory({
    super.key,
    required this.docId,
  });

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<QuerySnapshot>(
      future: FirebaseFirestore.instance
          .collection('users')
          .doc(docId)
          .collection('collected_vegetables')
          .get(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return SafeArea(
            child: Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
            ),
          );
        } else if (snapshot.hasError || !snapshot.hasData) {
          return SafeArea(
            child: Scaffold(
              body: Center(
                child: Text('Something went wrong'),
              ),
            ),
          );
        } else if (snapshot.data!.docs.isEmpty) {
          return SafeArea(
            child: Scaffold(
              appBar: PreferredSize(
                preferredSize: Size.fromHeight(screenHeight * 0.099),
                child: AppBar(
                  flexibleSpace: Container(
                    decoration: const BoxDecoration(
                        gradient: LinearGradient(
                            colors: [Colors.green, Colors.teal])),
                  ),
                  leading: const Arrowback(backcolor: kwhite),
                  title: const Captions(
                      captionColor: kwhite, captions: 'Sales so far'),
                ),
              ),
              body: Center(
                child: Text('No sales so far'),
              ),
            ),
          );
        } else {
          var vegetablesList = snapshot.data!.docs;

          return Scaffold(
            body: CompleteInvoiceDetailsWidget(vegetablesList: vegetablesList),
          );
        }
      },
    );
  }
}

class CompleteInvoiceDetailsWidget extends StatelessWidget {
  final List<QueryDocumentSnapshot> vegetablesList;

  const CompleteInvoiceDetailsWidget({Key? key, required this.vegetablesList})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var totalAmount = 0;
    for (var vegetable in vegetablesList) {
      totalAmount += vegetable['veg_total_price'] as int;
    }

    return SafeArea(
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(screenHeight * 0.099),
          child: AppBar(
            flexibleSpace: Container(
              decoration: const BoxDecoration(
                  gradient:
                      LinearGradient(colors: [Colors.green, Colors.teal])),
            ),
            leading: const Arrowback(backcolor: kwhite),
            title:
                const Captions(captionColor: kwhite, captions: 'Sales so far'),
          ),
        ),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                children: const [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Admin,\nFarmFriendly Wholesalers,\n Market road'),
                      SizedBox(
                          height: 50, width: 50, child: Icon(Icons.qr_code)),
                    ],
                  ),
                  SizedBox(height: 22),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Shilpa,\nShilpas farm,\n Market road'),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            children: [
                              Text(
                                'Invoice Number:',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              Text(
                                'Invoice Date:',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              Text(
                                'Payment status:',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                          Column(
                            children: [
                              Text('12/01/2024'),
                              Text('12/01/2024'),
                              Text('Paid'),
                            ],
                          )
                        ],
                      ),
                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.all(24),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 30),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'INVOICE',
                              style: TextStyle(
                                  fontSize: 24, fontWeight: FontWeight.bold),
                            ),
                            Text(
                              'print pdf',
                              style: TextStyle(
                                  decoration: TextDecoration.underline),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            DataTable(
              headingRowColor: MaterialStatePropertyAll(Colors.grey),
              columnSpacing: 6,
              columns: const [
                DataColumn(label: Text('Date')),
                DataColumn(label: Text('Vegetable')),
                DataColumn(label: Text('Quantity')),
                DataColumn(label: Text('Unit Price')),
                DataColumn(label: Text('Total Price')),
              ],
              rows: vegetablesList.map<DataRow>((vegetable) {
                var collectionDate =
                    (vegetable['collection_date'] as Timestamp).toDate();
                var formattedDate =
                    DateFormat('dd/MM/yy').format(collectionDate);

                var vegetableName = vegetable['vegetable_name'];
                var unitPrice = vegetable['price_per_unit'];
                var quantity = vegetable['quantity'];

                var totalPrice = vegetable['veg_total_price'];

                return DataRow(
                  cells: [
                    DataCell(Text(formattedDate)),
                    DataCell(Text(vegetableName)),
                    DataCell(Text(quantity.toString())),
                    DataCell(Text('₹$unitPrice')),
                    DataCell(Text('₹$totalPrice')),
                  ],
                );
              }).toList(),
            ),
            Divider(),
            Row(
              children: [
                SizedBox(width: 118),
                Text('Total amount paid : '),
                Text('₹${totalAmount.toString()}'),
              ],
            ),
            const SizedBox(height: 20),
            Divider(),
            const SizedBox(height: 20),
            Center(
              child: Text(
                'Thank You!',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            )
          ],
        ),
      ),
    );
  }
}
