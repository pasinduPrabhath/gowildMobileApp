import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Stat extends StatelessWidget {
  const Stat({
    super.key,
    required this.title,
    required this.value,
  });

  final String title;
  final int value;
  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Text(title, style: Theme.of(context).textTheme.displayMedium),
      Text(NumberFormat.decimalPattern().format(value),
          style: Theme.of(context).textTheme.labelMedium)
    ]);
  }
}
