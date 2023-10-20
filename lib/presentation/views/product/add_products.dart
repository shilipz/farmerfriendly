import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cucumber_app/main.dart';
import 'package:cucumber_app/presentation/views/product/approvals.dart';
import 'package:cucumber_app/presentation/views/product/pending_veggies.dart';
import 'package:cucumber_app/presentation/views/product/sale_item_widget.dart';
import 'package:cucumber_app/presentation/widgets/contact_form_widgets.dart';
import 'package:cucumber_app/presentation/widgets/signing_widgets.dart';
import 'package:cucumber_app/utils/constants/constants.dart';
import 'package:flutter/material.dart';

class AddProducts extends StatefulWidget {
  const AddProducts({super.key});

  @override
  State<AddProducts> createState() => _AddProductsState();
}

class _AddProductsState extends State<AddProducts> {
  bool isOnSale = false;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          body: Column(
            children: [
              Padding(
                  padding: EdgeInsets.only(right: screenWidth * 0.8),
                  child: const Arrowback(backcolor: darkgreen)),
              const Captions(
                  captionColor: darkgreen, captions: 'Select your Veggie'),
              lheight,
              GestureDetector(
                  onTap: () => Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => Approvals(),
                      )),
                  child: Container(
                      decoration: const BoxDecoration(
                          color: homeorange,
                          borderRadius: BorderRadius.all(Radius.circular(22))),
                      width: 245,
                      height: 42,
                      child: const Center(
                          child: Text(
                        'Click here to add new vegetable',
                        style: TextStyle(fontSize: 16, color: kwhite),
                      )))),
              Flexible(
                child: StreamBuilder<QuerySnapshot>(
                  stream: FirebaseFirestore.instance
                      .collection('vegetables')
                      .snapshots(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (snapshot.hasError) {
                      return Center(child: Text('Error: ${snapshot.error}'));
                    } else if (!snapshot.hasData ||
                        snapshot.data!.docs.isEmpty) {
                      return const Center(
                          child: Text('No vegetables available.'));
                    } else {
                      var vegetables = snapshot.data!.docs;

                      return ListView.builder(
                        itemCount: vegetables.length,
                        itemBuilder: (context, index) {
                          var vegetable = vegetables[index];
                          var name = vegetable['name'];
                          var price = vegetable['price'].toInt();

                          return SaleItem(name: name, price: price);
                        },
                      );
                    }
                  },
                ),
              )
            ],
          ),
          floatingActionButton: FloatingActionButton.extended(
            backgroundColor: darkgreen,
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => const PendingVeggies(),
              ));
            },
            label: const Text('Requested'),
          )),
    );
  }
}
