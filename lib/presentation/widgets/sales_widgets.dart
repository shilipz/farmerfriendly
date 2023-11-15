// ignore_for_file: constant_identifier_names

import 'package:cucumber_app/utils/constants/constants.dart';
import 'package:flutter/material.dart';

import '../../main.dart';

enum DayOfWeek {
  Monday,
  Tuesday,
  Wednesday,
  Thursday,
  Friday,
  Saturday,
}

class QuantityButton extends StatelessWidget {
  final IconData? quantityIcon;
  final String? buttonText;
  final Function()? onpressed;

  const QuantityButton({
    this.buttonText,
    this.quantityIcon,
    Key? key,
    this.onpressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(25),
          child: Container(
            width: 40,
            height: 40,
            color: transOrange,
            child: IconButton(
              onPressed: onpressed,
              icon: Icon(
                quantityIcon, // Default icon is Icons.add
                color: kblack,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class SalesContainer extends StatelessWidget {
  final String saleText;
  const SalesContainer({required this.saleText, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: const BoxDecoration(
            color: kwhite, borderRadius: BorderRadius.all(Radius.circular(20))),
        width: screenWidth * 0.15,
        height: screenHeight * 0.04,
        child: Center(child: Text(saleText, style: commonText)));
  }
}

class DayDropdown extends StatelessWidget {
  final DayOfWeek? selectedDay;
  final void Function(DayOfWeek?) onDayChanged;

  const DayDropdown({
    this.selectedDay,
    required this.onDayChanged,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(23),
      child: Container(
        width: screenWidth * 0.5,
        height: screenHeight * 0.05,
        decoration: BoxDecoration(color: transOrange),
        child: Center(
          child: DropdownButton<DayOfWeek>(
            items: DayOfWeek.values.map((DayOfWeek day) {
              return DropdownMenuItem<DayOfWeek>(
                value: day,
                child: Text(_dayToString(day)),
              );
            }).toList(),
            onChanged: onDayChanged,
            value: selectedDay,
            icon: const Icon(
              Icons.arrow_drop_down,
              color: kblack,
            ),
          ),
        ),
      ),
    );
  }

  String _dayToString(DayOfWeek day) {
    switch (day) {
      case DayOfWeek.Monday:
        return 'Every Monday';
      case DayOfWeek.Tuesday:
        return 'Every Tuesday';
      case DayOfWeek.Wednesday:
        return 'Every Wednesday';
      case DayOfWeek.Thursday:
        return 'Every Thursday';
      case DayOfWeek.Friday:
        return 'Every Friday';
      case DayOfWeek.Saturday:
        return 'Every Saturday';
    }
  }
}
