import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../main.dart';
import '../../utils/constants/constants.dart';

class ContactForm extends StatelessWidget {
  final String? formHints;
  final TextEditingController? inputController;
  final String? Function(String?)? customValidator;
  final Color? nameBorder;
  const ContactForm(
      {this.formHints,
      super.key,
      this.inputController,
      this.customValidator,
      this.nameBorder});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 300,
      height: 50,
      child: TextFormField(
        validator: (value) {
          if (customValidator != null) {
            final customError = customValidator!(value);
            if (customError != null) {
              return customError;
            }
          }
          return null;
        },
        controller: inputController,
        decoration: InputDecoration(
          hintText: formHints,
          hintStyle: const TextStyle(color: Colors.white),
          prefix: const SizedBox(width: 25, height: 30),
          filled: true,
          fillColor: transOrange,
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(100),
            borderSide: BorderSide.none,
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(100),
            borderSide: BorderSide.none,
          ),
          border: InputBorder.none,
        ),
      ),
    );
  }
}

class Next extends StatelessWidget {
  final String buttonText;
  final Color buttonColor;
  final Function()? onPressed;
  const Next(
      {required this.buttonText,
      required this.buttonColor,
      super.key,
      this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: 90,
        height: 40,
        child: ElevatedButton(
          onPressed: onPressed,
          style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all<Color>(buttonColor),
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(25),
              ))),
          child: Text(
            buttonText,
            style: const TextStyle(fontSize: 18, color: kwhite),
          ),
        ),
      ),
    );
  }
}

class Captions extends StatelessWidget {
  final String captions;
  final Color captionColor;
  const Captions(
      {required this.captionColor, required this.captions, super.key});

  @override
  Widget build(BuildContext context) {
    return Text(captions,
        style: GoogleFonts.playfairDisplay(
            textStyle: TextStyle(
                color: captionColor,
                fontSize: 28,
                fontWeight: FontWeight.bold)));
  }
}
