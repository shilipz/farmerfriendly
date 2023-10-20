
import 'package:cucumber_app/presentation/views/product/products_info.dart';
import 'package:cucumber_app/utils/constants/constants.dart';
import 'package:flutter/material.dart';

class SaleItem extends StatefulWidget {
  final String name;
  final int price;

  const SaleItem({super.key, required this.name, required this.price});

  @override
  // ignore: library_private_types_in_public_api
  _SaleItemState createState() => _SaleItemState();
}

class _SaleItemState extends State<SaleItem> {
  bool isOnSale = false;

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
              isOnSale = !isOnSale;
              // _addVegetableToFirestore(context, widget.name);
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => ProductDetails(
                  vegetableName: widget.name,
                  vegetablePrice: widget.price,
                ),
              ));
            });
            // String buttonText = isOnSale ? 'In Sale Now' : 'not for Sale';
            // Color buttonColor = isOnSale ? Colors.green : homeorange;
            // ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            //   content:
            //       Text('Item is ${isOnSale ? 'in sales now' : 'not for sale'}'),
            //   backgroundColor: buttonColor,
            // ));
          },
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all<Color>(
                isOnSale ? Colors.green : homeorange),
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(25),
              ),
            ),
          ),
          child: Text(isOnSale ? 'In Sale Now' : 'Ready to Sale'),
        ),
      ),
    );
  }
}
