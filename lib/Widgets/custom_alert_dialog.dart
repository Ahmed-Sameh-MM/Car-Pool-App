import 'package:flutter/material.dart';

import 'package:car_pool_app/Services/errors.dart';
import 'package:car_pool_app/Widgets/custom_text.dart';

class CustomAlertDialog {
  
  final BuildContext context;
  final ErrorTypes error;
  final bool isDismissible;
  final VoidCallback? onPressed;

  CustomAlertDialog({
    required this.context,
    required this.error,
    this.onPressed,
    this.isDismissible = true,
  }) {
    _showCustomAlertDialog();
  }

  Future<void> _showCustomAlertDialog() {
    return showDialog(
      barrierDismissible: isDismissible,
      context: context,
      builder: (_) {
        return AlertDialog(
          title: Center(
            child: CustomText(
              text: error.errorTitle,
              textColor: Colors.black,
            ),
          ),
          content: CustomText(
            text: error.errorMessage,
            textColor: Colors.black,
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                if(onPressed != null) {
                  onPressed!();
                }
              },
              child: const CustomText(
                text: 'OK',
                textColor: Colors.black,
              ),
            ),
          ],
        );
      },
    );
  }
}