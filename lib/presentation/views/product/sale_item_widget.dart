import 'package:cucumber_app/presentation/views/product/products_info.dart';
import 'package:cucumber_app/utils/constants/constants.dart';
import 'package:flutter/material.dart';

class SaleItem extends StatefulWidget {
  final String name;
  final int price;
  // final int quantity;

  const SaleItem({
    super.key,
    required this.name,
    required this.price,
    // required this.quantity
  });

  @override
  // ignore: library_private_types_in_public_api
  _SaleItemState createState() => _SaleItemState();
}

class _SaleItemState extends State<SaleItem> {
  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: Container(
          decoration: const BoxDecoration(color: kwhite),
          width: 70,
          height: 70,
          child: Image.asset('assets/images.jpeg'),
        ),
        title: Text(widget.name),
        subtitle: Text(' Rs.${widget.price} per Kg'),
        trailing: ElevatedButton(
          onPressed: () {
            setState(() {
              // _addVegetableToFirestore(context, widget.name);
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => ProductDetails(
                  vegetablePrice: widget.price,
                  vegetableName: widget.name,
                ),
              ));
            });
          },
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all<Color>(homeorange),
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(25),
              ),
            ),
          ),
          child: Text('Add to Sale'),
        ),
      ),
    );
  }
}
