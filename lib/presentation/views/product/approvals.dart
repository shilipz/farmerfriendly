import 'dart:developer';

import 'package:cucumber_app/presentation/widgets/contact_form_widgets.dart';
import 'package:cucumber_app/presentation/widgets/signing_widgets.dart';
import 'package:cucumber_app/utils/constants/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Approvals extends StatefulWidget {
  const Approvals({Key? key}) : super(key: key);

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
              const Row(
                children: [
                  Arrowback(backcolor: darkgreen),
                  Captions(captionColor: darkgreen, captions: 'Add new Veggie'),
                ],
              ),
              lheight,
              CircleAvatar(
                radius: 50,
                backgroundColor: Colors.grey,
                child: IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.image, color: Colors.white)),
              ),
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
    String name = formatText(nameController.text);
    String price = priceController.text;

    User? user = FirebaseAuth.instance.currentUser;

    final pending =
        FirebaseFirestore.instance.collection('pending_approval').doc();
    CollectionReference pendingRef =
        FirebaseFirestore.instance.collection('pending_approval');

    final email = FirebaseAuth.instance.currentUser!.email;
    CollectionReference vegRef =
        FirebaseFirestore.instance.collection('vegetables');
    QuerySnapshot vegQuerySnapshot =
        await vegRef.where('name', isEqualTo: name).get();
    vegRef
        .where('name', isEqualTo: name)
        .get()
        .then((QuerySnapshot vegQuerySnapshot) async {
      if (vegQuerySnapshot.docs.isNotEmpty) {
        return ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            backgroundColor: Colors.red,
            content: Text('$name is already available for sale')));
      } else {
        QuerySnapshot pendingQuerySnapshot =
            await pendingRef.where('name', isEqualTo: name).get();
        if (pendingQuerySnapshot.docs.isNotEmpty) {
          return ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
              backgroundColor: Colors.red,
              content: Text('This vegetable is already under review')));
        }
        await pending.set({
          'name': name,
          'price': double.parse(price),
          'status': 'pending',
          'id': pending.id,
          'email': email,
          'username': user!.displayName,
        });
        nameController.clear();
        priceController.clear();
        log("3");
        Navigator.of(context).pop();

        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            backgroundColor: darkgreen,
            content: Text('Vegetable requested for approval.')));
      }
    });
  }

  String formatText(String text) {
    if (text.isEmpty) {
      return text;
    }
    return text[0].toUpperCase() + text.substring(1).toLowerCase();
  }
}
