import 'package:flutter/material.dart';

import 'package:driver_car_pool_app/Widgets/sized_box.dart';
import 'package:driver_car_pool_app/Widgets/custom_text.dart';

class TrackingItem extends StatelessWidget {

  const TrackingItem({
    super.key,
    required this.icon,
    this.iconColor = Colors.white,
    required this.title,
    required this.message,
    this.enabled = false,
  });

  final IconData icon;
  final Color iconColor;
  final String title;
  final String message;
  final bool enabled;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          Opacity(
            opacity: enabled ? 1 : 0.3,
            child: Icon(
              icon,
              color: iconColor,
              size: 30,
            ),
          ),

          const WSizedBox(
            width: 16,
          ),

          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              CustomText(
                text: title,
                size: 18,
                fontWeight: FontWeight.w500,
                textColor: enabled ? Colors.white : const Color(0xFFBABABA),
              ),

              const HSizedBox(
                height: 6
              ),

              CustomText(
                text: message,
                size: 16,
                textColor: enabled ? Colors.white : const Color(0xFFD5D5D5),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
