import 'package:flutter/material.dart';

class HSizedBox extends StatelessWidget {

  final double height;

  const HSizedBox({
    super.key,
    required this.height,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
    );
  }
}

class WSizedBox extends StatelessWidget {

  final double width;

  const WSizedBox({
    super.key,
    required this.width,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
    );
  }
}