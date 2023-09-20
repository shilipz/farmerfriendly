import 'package:cucumber_app/main.dart';
import 'package:cucumber_app/presentation/widgets/contact_form_widgets.dart';
import 'package:cucumber_app/presentation/widgets/sales_widgets.dart';
import 'package:cucumber_app/presentation/widgets/signing_widgets.dart';
import 'package:cucumber_app/utils/constants/constants.dart';
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class ProductDetails extends StatelessWidget {
  const ProductDetails({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
            child: Stack(
          children: [
            Image.asset('assets/sale info.png', fit: BoxFit.cover),
            const Arrowback(backcolor: kwhite),
            const Center(
              child: Captions(
                  captions: 'Tell us  about your Sales', captionColor: kwhite),
            ),
            Padding(
              padding: EdgeInsets.only(top: screenHeight * 0.17, left: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const Text("Today's price", style: commonText),
                      kwidth,
                      const SalesContainer(saleText: '34.00'),
                      kwidth,
                      const Text("per Kg ", style: commonText),
                    ],
                  ),
                  const Text('(for successful quality analysis)'),
                  sheight,
                  const Text('Onion', style: commonHeading),
                  sheight,
                  Row(
                    children: [
                      const Text('Quantity', style: commonText),
                      kwidth,
                      const QuantityButton(quantityIcon: Icons.remove),
                      kwidth,
                      const SalesContainer(saleText: '3'),
                      kwidth,
                      const QuantityButton(quantityIcon: Icons.add),
                    ],
                  ),
                  sheight,
                  Row(
                    children: [
                      const Text('Availability Schedule', style: commonText),
                      const Spacer(),
                      DayDropdown(
                        selectedDay: DayOfWeek.Monday,
                        onDayChanged: (newDay) {},
                      ),
                    ],
                  ),
                  sheight,
                  const Center(child: Text('Or', style: commonText)),
                  sheight,
                  const Center(
                      child:
                          Text('pick a day from calendar', style: commonText)),
                  sheight,
                  Padding(
                    padding: const EdgeInsets.only(left: 12, right: 12),
                    child: Container(
                      decoration: const BoxDecoration(
                          color: kwhite,
                          borderRadius: BorderRadius.all(Radius.circular(20))),
                      child: TableCalendar(
                          rowHeight: 35,
                          focusedDay: today,
                          firstDay: DateTime.utc(2010, 10, 16),
                          lastDay: DateTime.utc(2030, 3, 14)),
                    ),
                  ),
                  sheight,
                  Center(
                      child: InkWell(
                          onTap: () => Navigator.of(context).pop(),
                          child: const Next(
                            buttonText: 'Done',
                            buttonColor: lightgreen,
                          )))
                ],
              ),
            )
          ],
        )),
      ),
    );
  }
}

DateTime today = DateTime.now();
