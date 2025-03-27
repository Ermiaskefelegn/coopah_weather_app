import 'package:flutter/material.dart';

// A stateless widget that displays a labeled text with customizable font weight and size.
class LabeledText extends StatelessWidget {
  final String label; // The text to display.
  final FontWeight weight; // The font weight of the text.
  final double fontsize; // The font size of the text.

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
        fontFamily: "Circular Std", // Custom font family.
        fontWeight: weight,
        fontSize: fontsize,
        fontStyle: FontStyle.normal, // Normal font style.
      ),
    );
  }
}
