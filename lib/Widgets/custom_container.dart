// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';

class CustomContainer extends StatelessWidget {

  Color? color;
  double? hpadding;
  double? vpadding;
  double? width;
  double? margin;
  double? borderRadius;
  bool shadow;
  Widget child;
  double? height;
  Border? border;
  
  CustomContainer({
    super.key,
    required this.child,
    this.color,
    this.width,
    this.margin,
    this.borderRadius,
    this.hpadding,
    this.vpadding,
    this.shadow = false,
    this.height,
    this.border,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      margin: EdgeInsets.only(top: margin ?? 0),
      padding: EdgeInsets.symmetric(
        horizontal: hpadding ?? 10,
        vertical: vpadding ?? 10,
      ),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(borderRadius ?? 10),
          color: color ?? Colors.white,
          border: border,
          boxShadow: [
            if (shadow)
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 1,
                blurRadius: 10,
                offset: const Offset(0, 3), // changes position of shadow
              ),
          ]),
      child: child,
    );
  }
}
