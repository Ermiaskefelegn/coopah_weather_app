import 'package:flutter/material.dart';

class CustomNormalButton extends StatelessWidget {
  const CustomNormalButton({
    super.key,
    required this.text,
    required this.padding,
    required this.onPressed,
    required this.buttoncolor,
    required this.textcolor,
    this.borderRadius,
    this.textStyle,
  });

  ///button text
  final String text;

  ///button text
  final TextStyle? textStyle;

  ///button right icon conditional
  final EdgeInsets padding;

  ///background color for normal button
  final Color buttoncolor;

  ///text color for normal button
  final Color textcolor;

  ///on pressed function
  final VoidCallback onPressed;

  ///button left icon conditional
  final double? borderRadius;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(
        borderRadius != null ? borderRadius! : 0.0,
      ),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom().copyWith(
          backgroundColor: WidgetStateProperty.all<Color>(buttoncolor),
        ),
        onPressed: onPressed,
        child: Padding(
          padding: padding,
          child: ClipRRect(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  text,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                      fontFamily: "Circular Std",
                      fontWeight: FontWeight.bold,
                      color: textcolor,
                      fontSize: 18,
                      fontStyle: FontStyle.normal),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
