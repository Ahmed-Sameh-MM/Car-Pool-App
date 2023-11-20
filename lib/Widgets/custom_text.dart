import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';

class CustomText extends StatelessWidget {

  final String text;
  final double size;
  final double? height;
  final Color? textColor;
  final FontWeight? fontWeight;
  final String? fontFamily;

  const CustomText({
    Key? key,
    required this.text,
    this.size = 15,
    this.height,
    this.textColor = Colors.white,
    this.fontWeight,
    this.fontFamily,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        color: textColor,
        fontSize: size,
        height: height,
        fontWeight: fontWeight,
        fontFamily: fontFamily ?? GoogleFonts.montserrat().fontFamily,
      ),
    );
  }
}