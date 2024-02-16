import 'dart:ffi';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:FarmerFriendly/utils/constants/constants.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class InSale extends StatelessWidget {
  const InSale({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      backgroundColor: Colors.yellow[100],
      body: Column(
        children: [
          sheight,
          Padding(
              padding: const EdgeInsets.all(12),
              child: Text(
                'Currently in sales',
                style: GoogleFonts.akshar(
                    textStyle: const TextStyle(color: kblack, fontSize: 20)),
              )),
          lheight,
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection('users')
                  .doc(FirebaseAuth.instance.currentUser?.uid)
                  .collection('selling_vegetables')
                  .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                }

                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (snapshot.data == null || snapshot.data!.docs.isEmpty) {
                  return const Center(child: Text('No vegetables in sales.'));
                }

                return ListView.builder(
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (context, index) {
                    var vegetable = snapshot.data!.docs[index];
                    var vegetableId = vegetable.id; // Document ID
                    var vegetableName = vegetable['vegetable_name'] ?? 'N/A';
                    //var isOnSale = vegetable['isOnSale'] ?? false;
                    var quantity = vegetable['quantity'] ?? 0;
                    var imageUrl = vegetable['imageURL'];
                    // var collectionDate =
                    //     DateTime.parse(vegetable['collection_date']);

                    var collectionDate = vegetable['collection_date'];
                    // var formattedDate = DateFormat('dd MMMM').format(
                    //   DateTime.fromMillisecondsSinceEpoch(
                    //     collectionDate.seconds * 1000,
                    //   ),
                    // );
                    return ListTile(
                        leading: Container(
                            decoration: const BoxDecoration(color: kwhite),
                            width: 70,
                            height: 70,
                            child: imageUrl != null
                                ? Image.network(imageUrl)
                                : Image.asset('assets/farmer.jpg')),
                        title: Text(
                          vegetableName,
                          style: const TextStyle(
                              fontSize: 18, fontWeight: FontWeight.w500),
                        ),
                        subtitle: Text(
                            ' \nQuantity:$quantity  \nReady for $collectionDate'),
                        trailing: IconButton(
                          onPressed: () {
                            _showEditDialog(context, vegetableId, vegetableName,
                                quantity, collectionDate, () {
                              ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                      backgroundColor: Colors.green,
                                      content:
                                          Text('Vegetable details updated.')));
                            }, () {
                              ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                      backgroundColor: kblack,
                                      content: Text(
                                          'Vegetable removed from next sale.')));
                            }, imageUrl);
                          },
                          icon: const Icon(
                            Icons.edit,
                            color: Colors.green,
                          ),
                        ));
                  },
                );
              },
            ),
          ),
        ],
      ),
    ));
  }
}

void _showEditDialog(
    BuildContext context,
    String vegetableId,
    String currentVegetableName,
    int currentQuantity,
    String currentCollectionDate,
    VoidCallback onEdit,
    VoidCallback onRemove,
    String imageUrl) {
  TextEditingController quantityController =
      TextEditingController(text: currentQuantity.toString());
  TextEditingController collectionDatecontroller =
      TextEditingController(text: currentCollectionDate.toString());
  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        // backgroundColor: Colors.yellow[300],
        title: const Text('Edit Vegetable', style: TextStyle(color: kblack)),
        content: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(width: 180, height: 180, child: Image.network(imageUrl)),
              const SizedBox(height: 32),
              TextField(
                decoration: InputDecoration(labelText: currentVegetableName),
              ),
              TextField(
                controller: quantityController,
                decoration: const InputDecoration(labelText: 'Quantity'),
                keyboardType: TextInputType.number,
              ),
              SizedBox(
                height: 20,
              ),
              InkWell(
                onTap: () async {
                  DateTime? pickedDate = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime.now(),
                    lastDate: DateTime(DateTime.now().year + 5),
                  );

                  if (pickedDate != null) {
                    var collectionDate = collectionDatecontroller.text =
                        DateFormat('dd MMMM').format(pickedDate);
                  }
                },
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text('Change date'),
                    Icon(Icons.calendar_today),
                  ],
                ),
              ),

              // TextField(
              //   decoration: InputDecoration(
              //     labelText: 'Change date',
              // prefixIcon: IconButton(
              //   onPressed: () async {
              //     DateTime? pickedDate = await showDatePicker(
              //       context: context,
              //       initialDate: DateTime.now(),
              //       firstDate: DateTime.now(),
              //       lastDate: DateTime(DateTime.now().year + 5),
              //     );

              //     if (pickedDate != null) {
              //       var collectionDate = collectionDatecontroller.text =
              //           DateFormat('dd MMMM').format(pickedDate);
              //     }
              //   },
              //   icon: const Icon(Icons.calendar_today),
              // ),
              //   ),
              // )
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text('Cancel', style: TextStyle(color: kblack)),
          ),
          TextButton(
            onPressed: () {
              _removeVegetable(vegetableId);
              onRemove();
              Navigator.pop(context);
            },
            child: const Text('Remove', style: TextStyle(color: kblack)),
          ),
          TextButton(
            onPressed: () {
              _editVegetable(
                vegetableId,
                int.parse(quantityController.text),
                collectionDatecontroller.text,
              );
              onEdit();
              Navigator.pop(context);
            },
            child: const Text('Save', style: TextStyle(color: kblack)),
          ),
        ],
      );
    },
  );
}

void _editVegetable(
  String vegetableId,
  int newQuantity,
  var collectionDate,
) {
  FirebaseFirestore.instance
      .collection('users')
      .doc(FirebaseAuth.instance.currentUser?.uid)
      .collection('selling_vegetables')
      .doc(vegetableId)
      .update({'quantity': newQuantity, 'collection_date': collectionDate});
  FirebaseFirestore.instance
      .collection('insales')
      .doc(vegetableId)
      .update({'quantity': newQuantity, 'collection_date': collectionDate});
}

void _removeVegetable(String vegetableId) {
  // Remove the vegetable from Firestore using the provided vegetableId
  FirebaseFirestore.instance
      .collection('users')
      .doc(FirebaseAuth.instance.currentUser?.uid)
      .collection('selling_vegetables')
      .doc(vegetableId)
      .delete();
}
