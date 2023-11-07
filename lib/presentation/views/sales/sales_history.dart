import 'package:cucumber_app/presentation/widgets/contact_form_widgets.dart';
import 'package:cucumber_app/presentation/widgets/signing_widgets.dart';
import 'package:cucumber_app/utils/constants/constants.dart';
import 'package:flutter/material.dart';

class SalesHistory extends StatelessWidget {
  const SalesHistory({super.key});

  @override
  Widget build(BuildContext context) {
    return const SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            Row(
              children: [
                Arrowback(backcolor: darkgreen),
                Captions(captionColor: darkgreen, captions: 'Sales so far'),
              ],
            )
          ],
        ),
      ),
    );
  }
}
