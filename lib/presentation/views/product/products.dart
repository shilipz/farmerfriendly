import 'package:FarmerFriendly/main.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:FarmerFriendly/presentation/presentation_logic/product_search/product_search_bloc.dart';
import 'package:FarmerFriendly/presentation/views/product/approvals.dart';
import 'package:FarmerFriendly/presentation/views/product/sale_item_widget.dart';
import 'package:FarmerFriendly/presentation/widgets/contact_form_widgets.dart';
import 'package:FarmerFriendly/utils/constants/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

// ignore: must_be_immutable
class AddProducts extends StatefulWidget {
  const AddProducts({super.key});

  @override
  State<AddProducts> createState() => _AddProductsState();
}

class _AddProductsState extends State<AddProducts> {
  TextEditingController searchController = TextEditingController();

  late QuerySnapshot snapshot;
  bool showAllItems = false;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          color: Colors.yellow[100],
          child: Column(
            children: [
              sheight,
              Padding(
                  padding: const EdgeInsets.all(12),
                  child: Text(
                    'Select your Veggie',
                    style: GoogleFonts.akshar(
                        textStyle:
                            const TextStyle(color: kblack, fontSize: 20)),
                  )),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: TextField(
                  controller: searchController,
                  onChanged: (query) {
                    context
                        .read<ProductSearchBloc>()
                        .add(ProductSearchEvent(query));
                  },
                  decoration: InputDecoration(
                    hintText: 'Search Vegetables...',
                    suffixIcon: IconButton(
                      icon: const Icon(Icons.clear),
                      onPressed: () {
                        searchController.clear();
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
                child: Column(
                  children: [
                    const Center(
                      child: Text(
                        'Click here to add new vegetable',
                        style: TextStyle(
                          decoration: TextDecoration.underline,
                          fontSize: 16,
                          color: kblack,
                        ),
                      ),
                    ),
                    SizedBox(height: screenHeight * 0.03),
                  ],
                ),
              ),
              BlocBuilder<ProductSearchBloc, ProductSearchState>(
                builder: (context, state) {
                  return Flexible(
                    child: StreamBuilder<QuerySnapshot>(
                      stream: FirebaseFirestore.instance
                          .collection('vegetables')
                          .snapshots(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const Center(
                              child: CircularProgressIndicator());
                        } else if (snapshot.hasError) {
                          return Center(
                              child: Text('Error: ${snapshot.error}'));
                        } else if (!snapshot.hasData ||
                            snapshot.data!.docs.isEmpty) {
                          return const Center(
                              child: Text('No vegetables available.'));
                        } else {
                          this.snapshot = snapshot.data!;
                          var vegetables = searchController.text.isEmpty
                              ? snapshot.data!.docs
                              : state.filteredVegetables;

                          return ListView.builder(
                            itemCount: vegetables.length,
                            itemBuilder: (context, index) {
                              var vegetable = vegetables[index];
                              var name = vegetable['name'];
                              var price = vegetable['price'].toInt();
                              var imageUrl = vegetable['imageUrl'];
                              return SaleItem(
                                  name: name, price: price, imageUrl: imageUrl);
                            },
                          );
                        }
                      },
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
