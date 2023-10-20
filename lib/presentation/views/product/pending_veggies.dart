import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cucumber_app/presentation/widgets/contact_form_widgets.dart';
import 'package:cucumber_app/utils/constants/constants.dart';
import 'package:flutter/material.dart';

class PendingVeggies extends StatelessWidget {
  const PendingVeggies({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: lightgreen,
      body: Column(
        children: [
          const Captions(captionColor: kwhite, captions: 'Under Review'),
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection('pending_approval')
                  .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                  return const Center(child: Text('No vegetables available.'));
                } else {
                  var pending_approval = snapshot.data!.docs;

                  return ListView.builder(
                    itemCount: pending_approval.length,
                    itemBuilder: (context, index) {
                      var vegetable = pending_approval[index];
                      var name = vegetable['name'];
                      var price = vegetable['price'];

                      return Card(
                        child: ListTile(
                          leading: Container(
                            decoration: const BoxDecoration(color: kwhite),
                            width: 70,
                            height: 70,
                            child: Image.asset('assets/images.jpeg'),
                          ),
                          title: Text(name),
                          subtitle: Text('$price per Kg'),
                        ),
                      );
                    },
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
