import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cucumber_app/presentation/views/home/home_screen.dart';
import 'package:cucumber_app/presentation/views/product/approvals.dart';
import 'package:cucumber_app/presentation/views/product/in_sale_vegs.dart';
import 'package:cucumber_app/presentation/views/product/requests.dart';
import 'package:cucumber_app/presentation/views/product/sale_item_widget.dart';
import 'package:cucumber_app/presentation/widgets/contact_form_widgets.dart';
import 'package:cucumber_app/utils/constants/constants.dart';
import 'package:flutter/material.dart';

class AddProducts extends StatefulWidget {
  const AddProducts({super.key});

  @override
  State<AddProducts> createState() => _AddProductsState();
}

class _AddProductsState extends State<AddProducts> {
  TextEditingController searchController = TextEditingController();
  late QuerySnapshot snapshot;
  List<DocumentSnapshot> filteredVegetables = [];

  void filterVegetables(String query) {
    setState(() {
      filteredVegetables.clear();
      filteredVegetables.addAll(snapshot.docs
          .where((vegetable) {
            var vegetableName = vegetable['name'].toString().toLowerCase();
            return vegetableName.contains(query.toLowerCase());
          })
          .map((queryDocumentSnapshot) => queryDocumentSnapshot)
          .toList());
    });
  }

  int _currentIndex = 0;
  void _onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
      switch (index) {
        case 0:
          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => const AddProducts(),
              ));
          break;
        case 1:
          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => const InSale(),
              ));
          break;
        case 2:
          Navigator.pushReplacement(
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
                    captionColor: darkgreen, captions: 'Select your Veggie'),
              ],
            ),
            lheight,
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: TextField(
                controller: searchController,
                onChanged: (query) {
                  filterVegetables(query);
                },
                decoration: InputDecoration(
                  hintText: 'Search Vegetables...',
                  suffixIcon: IconButton(
                    icon: const Icon(Icons.clear),
                    onPressed: () {
                      searchController.clear();
                      filterVegetables('');
                    },
                  ),
                ),
              ),
            ),
            sheight,
            GestureDetector(
                onTap: () => Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => const Approvals(),
                    )),
                child: const Center(
                    child: Text(
                  'Click here to add new vegetable',
                  style: TextStyle(fontSize: 16, color: darkgreen),
                ))),
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
                  } else if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                    return const Center(
                        child: Text('No vegetables available.'));
                  } else {
                    this.snapshot = snapshot.data!;
                    var vegetables = searchController.text.isEmpty
                        ? snapshot.data!.docs
                        : filteredVegetables;

                    return ListView.builder(
                      itemCount: vegetables.length,
                      itemBuilder: (context, index) {
                        var vegetable = vegetables[index];
                        var name = vegetable['name'];
                        var price = vegetable['price'].toInt();
                        // var quantity = vegetable['quantity'].toInt();

                        return SaleItem(name: name, price: price);
                      },
                    );
                  }
                },
              ),
            )
          ],
        ),
        bottomNavigationBar: BottomNavigationBar(
            backgroundColor: lightgreen,
            selectedItemColor: kwhite,
            selectedFontSize: 20,
            currentIndex: _currentIndex,
            onTap: _onTabTapped,
            items: const [
              BottomNavigationBarItem(
                  icon: Icon(Icons.list), label: 'Products'),
              BottomNavigationBarItem(
                  icon: Icon(Icons.business), label: 'In Sales'),
              BottomNavigationBarItem(
                  icon: Icon(Icons.approval), label: 'Requests')
            ]),

        // floatingActionButton: FloatingActionButton.extended(
        //   backgroundColor: darkgreen,
        //   onPressed: () {
        //     Navigator.of(context).push(MaterialPageRoute(
        //       builder: (context) => const PendingVeggies(),
        //     ));
        //   },
        //   label: const Text('Requested'),
        // )
      ),
    );
  }
}
