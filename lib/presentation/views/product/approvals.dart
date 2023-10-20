import 'dart:developer';

import 'package:cucumber_app/utils/constants/constants.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Approvals extends StatefulWidget {
  Approvals({Key? key}) : super(key: key);

  @override
  State<Approvals> createState() => _ApprovalsState();
}

final TextEditingController nameController = TextEditingController();
final TextEditingController priceController = TextEditingController();

class _ApprovalsState extends State<Approvals> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(22),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Center(
                child: Text(
                  'Add new Veggie',
                  style: TextStyle(fontSize: 22),
                ),
              ),
              lheight,
              lheight,
              TextFormField(
                controller: nameController,
                decoration: const InputDecoration(labelText: 'Vegetable Name'),
              ),
              lheight,
              TextFormField(
                controller: priceController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(labelText: 'Expected Price'),
              ),
              const SizedBox(height: 20),
              Center(
                child: SizedBox(
                  width: 90,
                  height: 40,
                  child: ElevatedButton(
                    onPressed: () {
                      _submit();
                    },
                    style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all<Color>(lightgreen),
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25),
                        ))),
                    child: const Text(
                      'Done',
                      style: TextStyle(fontSize: 18, color: kwhite),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _submit() async {
    String name = nameController.text;
    String price = priceController.text;

    log("1");
    // Get the current user

    final pending =
        FirebaseFirestore.instance.collection('pending_approval').doc();
    log("2");
    await pending.set({
      'name': name,
      'price': double.parse(price),
      'status': 'pending',
      'id': pending.id
    });
    log("3");
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: const Text('Vegetable added. It is pending approval.'),
    ));
    nameController.clear();
    priceController.clear();
    Navigator.of(context).pop();
  }
}
