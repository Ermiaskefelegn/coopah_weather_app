import 'package:flutter/material.dart';

class LabeledText extends StatelessWidget {
  final String label;
  final FontWeight weight;
  final double fontsize;

  const LabeledText({
    super.key,
    required this.label,
    required this.weight,
    required this.fontsize,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      label,
      style: TextStyle(
        fontFamily: "Circular Std",
        fontWeight: weight,
        fontSize: fontsize,
        fontStyle: FontStyle.normal,
      ),
    );
  }
}
