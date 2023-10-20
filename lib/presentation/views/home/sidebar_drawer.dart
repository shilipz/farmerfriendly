import 'package:cucumber_app/presentation/views/contact_details.dart';
import 'package:cucumber_app/presentation/views/payment.dart';
import 'package:cucumber_app/presentation/views/product/add_products.dart';
import 'package:cucumber_app/presentation/views/sales_profile.dart';
import 'package:cucumber_app/utils/constants/constants.dart';
import 'package:flutter/material.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    DateTime now = DateTime.now();
    int hour = now.hour;

    String greeting;
    if (hour >= 6 && hour < 12) {
      greeting = 'Good Morning';
    } else if (hour >= 12 && hour < 18) {
      greeting = 'Good Afternoon';
    } else {
      greeting = 'Good Evening';
    }

    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            decoration: const BoxDecoration(
              color: lightgreen,
            ),
            child: Text(
              greeting,
              style: const TextStyle(
                color: kwhite,
                fontSize: 28,
              ),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.production_quantity_limits),
            title: const Text('Product Selection'),
            onTap: () => Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => const AddProducts(),
            )),
          ),
          ListTile(
            leading: const Icon(Icons.contact_emergency),
            title: const Text('Contact Details'),
            onTap: () => Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => ContactDetails(),
            )),
          ),
          ListTile(
            leading: const Icon(Icons.payment),
            title: const Text('Payment Details'),
            onTap: () => Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => const Payment(),
            )),
          ),
          ListTile(
            leading: const Icon(Icons.money),
            title: const Text('Sales History'),
            onTap: () => Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => const SalesProfile(),
            )),
          ),
          ListTile(
            leading: const Icon(Icons.chat),
            title: const Text('Chat Support'),
            onTap: () => Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => const SalesProfile(),
            )),
          ),
        ],
      ),
    );
  }
}
