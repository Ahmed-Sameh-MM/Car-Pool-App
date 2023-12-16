import 'package:driver_car_pool_app/Static%20Data/colors.dart';
import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {

  final Widget child;

  final Function() onTap;

  final double? width;
  final double? height;

  final Color color;
  final Color childrenColor;
  final Color selectedColor;
  final Color selectedChildrenColor;

  final EdgeInsetsGeometry? margin;
  final double hPadding;
  final double vPadding;
  final double borderRadius;

  final bool shadow;

  final bool selected;

  final bool centerChildren;

  const CustomButton({
    Key? key,
    required this.child,
    required this.onTap,
    this.width,
    this.height,
    this.color = primaryColor,
    this.childrenColor = Colors.white,
    this.selectedColor = Colors.greenAccent,
    this.selectedChildrenColor = Colors.black,
    this.margin,
    this.hPadding = 0,
    this.vPadding = 0,
    this.borderRadius = 10,
    this.selected = false,
    this.shadow = true,
    this.centerChildren = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final theme = Theme.of(context);
    
    final childrenStyle = TextStyle(
      color: selected ? selectedChildrenColor : childrenColor,
      fontSize: theme.textTheme.titleMedium?.fontSize,
    );

    final children = DefaultTextStyle(
      style: childrenStyle,
      child: child,
    );

    return Container(
      width: width,
      height: height,
      margin: margin,
      padding: EdgeInsets.symmetric(
        horizontal: hPadding,
        vertical: vPadding,
      ),
      decoration: BoxDecoration(
        color: selected ? selectedColor : color,
        borderRadius: BorderRadius.circular(borderRadius),
        boxShadow: shadow ? [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 1,
            blurRadius: 10,
            offset: const Offset(0, 3), // changes position of shadow
          ),
        ] : null,
      ),
      child: InkWell(
        onTap: onTap,
        child: centerChildren ? Center(
          child: children,
        ) : children,
      ),
    );
  }
}