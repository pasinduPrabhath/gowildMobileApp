import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Stat extends StatelessWidget {
  const Stat({
    super.key,
    required this.title,
    required this.value,
    this.isLoading = false,
  });

  final String title;
  final int value;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return Column(
        children: [
          Text(title, style: Theme.of(context).textTheme.displayMedium),
          SizedBox(
              height: MediaQuery.of(context).size.height * 0.03,
              width: MediaQuery.of(context).size.height * 0.03,
              child: const CircularProgressIndicator()),
        ],
      );
    } else {
      return Column(
        children: [
          Text(title, style: Theme.of(context).textTheme.displayMedium),
          Text(
            NumberFormat.decimalPattern().format(value),
            style: Theme.of(context).textTheme.labelMedium,
          ),
        ],
      );
    }
  }
}
