// ignore_for_file: use_build_context_synchronously
import 'package:FarmerFriendly/presentation/views/product/products_info.dart';
import 'package:FarmerFriendly/utils/constants/constants.dart';
import 'package:flutter/material.dart';

class SaleItem extends StatelessWidget {
  final String name;
  final int price;
  final int? quantity;
  final String imageUrl;

  const SaleItem({
    super.key,
    required this.name,
    required this.price,
    this.quantity,
    required this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: Container(
          decoration: const BoxDecoration(color: kwhite),
          width: 70,
          height: 70,
          child: imageUrl.isNotEmpty
              ? Image.network(imageUrl) // Load image from URL
              : Image.asset('assets/farmer.jpg'),
          // child: const Icon(Icons.business),
        ),
        title: Text(name),
        subtitle: Text(' Rs.$price per Kg'),
        trailing: ElevatedButton(
          onPressed: () {
            Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => ProductDetails(
                imageURL: imageUrl,
                vegetablePrice: price,
                vegetableName: name,
              ),
            ));
          },
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all<Color>(Colors.yellow),
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(25),
              ),
            ),
          ),
          child: const Text('Add to Sale', style: TextStyle(color: kblack)),
        ),
      ),
    );
  }
}
