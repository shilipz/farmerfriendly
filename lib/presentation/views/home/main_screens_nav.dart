import 'package:cucumber_app/presentation/views/chat/chat_screen.dart';
import 'package:cucumber_app/presentation/views/contact_details/contact_details.dart';
import 'package:cucumber_app/presentation/views/home/home_screen_widget.dart';
import 'package:cucumber_app/presentation/views/payment.dart';
import 'package:cucumber_app/presentation/views/product/products.dart';
import 'package:cucumber_app/presentation/views/sales/sales_history.dart';
import 'package:cucumber_app/utils/constants/constants.dart';
import 'package:flutter/material.dart';

class MainSreensNav extends StatelessWidget {
  const MainSreensNav({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    const adminId = 'Qftvv6wlDIeNXl8UtXZcvuN3ZYr1';
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          InkWell(
              onTap: () => Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => const AddProducts())),
              child: const HomeContainer(
                title: 'Product Selection',
                subtitle: 'Add products for your next sale',
              )),
          sheight,
          InkWell(
              onTap: () => Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => ContactDetails(),
                  )),
              child: const HomeContainer(
                title: 'Contact Details',
                subtitle: 'Add/update collection address',
              )),
          sheight,
          InkWell(
              onTap: () => Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => const Payment(),
                  )),
              child: const HomeContainer(title: 'Payment Details')),
          sheight,
          InkWell(
              onTap: () => Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => const SalesHistory(),
                  )),
              child: const HomeContainer(
                title: 'Sales History',
                subtitle: 'See previous sales history',
              )),
          sheight,
          InkWell(
              onTap: () => Navigator.of(context).push(
                    MaterialPageRoute(
                        builder: (context) =>
                            const ChatScreen(adminId: adminId)),
                  ),
              child: const HomeContainer(
                title: 'Chat Support',
                subtitle: 'Talk to our customer executive',
              )),
          // vlheight,
          // vlheight
        ],
      ),
    );
  }
}
