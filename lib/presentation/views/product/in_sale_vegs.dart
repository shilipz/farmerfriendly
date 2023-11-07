import 'package:cucumber_app/presentation/views/home/home_screen.dart';
import 'package:cucumber_app/presentation/views/product/approvals.dart';
import 'package:cucumber_app/presentation/views/product/products.dart';
import 'package:cucumber_app/presentation/views/product/requests.dart';
import 'package:cucumber_app/presentation/widgets/contact_form_widgets.dart';
import 'package:cucumber_app/presentation/widgets/signing_widgets.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cucumber_app/utils/constants/constants.dart';
import 'package:intl/intl.dart';

class InSale extends StatefulWidget {
  const InSale({Key? key});

  @override
  State<InSale> createState() => _InSaleState();
}

class _InSaleState extends State<InSale> {
  int _currentIndex = 1;

  void _onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
      switch (index) {
        case 0:
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const AddProducts(),
              ));
          break;
        case 1:
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const InSale(),
              ));
          break;
        case 2:
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const PendingVeggies(),
              ));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: Column(
        children: [
          Row(
            children: [
              IconButton(
                  onPressed: () {
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const Home(),
                        ));
                  },
                  icon: const Icon(Icons.arrow_back_ios,
                      size: 25, color: darkgreen)),
              const Captions(
                  captionColor: darkgreen, captions: 'Ready for next sale')
            ],
          ),
          lheight,
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
                    var vegetableName = vegetable['vegetable_name'] ?? 'N/A';
                    var isOnSale = vegetable['isOnSale'] ?? false;
                    var quantity = vegetable['quantity'] ?? 0;
                    var collectionDate =
                        vegetable['collection_date'] as Timestamp;
                    var formattedDate = DateFormat('dd MMMM').format(
                        DateTime.fromMillisecondsSinceEpoch(
                            collectionDate.seconds * 1000));
                    return ListTile(
                      title: Text(
                        vegetableName,
                        style: const TextStyle(
                            fontSize: 18, fontWeight: FontWeight.w500),
                      ),
                      subtitle: Text(
                          ' \nQuantity:$quantity  \nReady for $formattedDate'),
                      trailing: isOnSale
                          ? const Icon(Icons.edit, color: Colors.green)
                          : const Icon(Icons.edit, color: Colors.red),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
          backgroundColor: lightgreen,
          selectedItemColor: kwhite,
          selectedFontSize: 20,
          currentIndex: _currentIndex,
          onTap: _onTabTapped,
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.list), label: 'Products'),
            BottomNavigationBarItem(
                icon: Icon(Icons.business), label: 'In Sales'),
            BottomNavigationBarItem(
                icon: Icon(Icons.approval), label: 'Requests')
          ]),
    ));
  }
}
