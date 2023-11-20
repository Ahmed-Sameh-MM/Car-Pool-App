import 'package:flutter/material.dart';

import 'package:shimmer/shimmer.dart';

class ShimmerTemplate extends StatelessWidget {

  final double width;
  final double height;
  final EdgeInsetsGeometry margin;

  const ShimmerTemplate({
    super.key,
    this.width = double.infinity,
    this.height = double.infinity,
    this.margin = EdgeInsets.zero,
  });

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey,
      highlightColor: Colors.grey[400]!,
      child: Container(
        width: width,
        height: height,
        color: Colors.white,
        margin: margin,
      ),
    );
  }
}