import 'package:flutter/material.dart';

import 'package:driver_car_pool_app/Static%20Data/colors.dart';

class PromoCodeField extends StatelessWidget {

  final TextEditingController controller;
  final FocusNode focusNode;

  final String labelText;

  final int maxLength;

  const PromoCodeField({
    super.key,
    required this.controller,
    required this.focusNode,
    this.maxLength = 10,
    this.labelText = 'Promo Code',
  });

  String? nameValidator(String? name) {
    if(name?.isEmpty ?? true) {
      return 'Name cannot be Empty!';
    }

    int nameLength = name!.length;

    if(name.contains(RegExp('( ){$nameLength}'))) {
      return 'Name cannot be spaces only';
    }

    else if(nameLength > maxLength) {
      return 'Name is Too Long!';
    }

    return null;
  }
  
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      maxLength: maxLength,
      //keyboardType: TextInputType.text,
      controller: controller,
      focusNode: focusNode,
      textInputAction: TextInputAction.next,
      validator: nameValidator,
      cursorRadius: const Radius.circular(10),

      style: const TextStyle(
        color: Colors.white,
      ),

      decoration: InputDecoration(
        labelText: labelText,
        labelStyle: const TextStyle(
          color: Colors.white,
        ),

        hintText: 'Enter Promo Code',
        hintStyle: const TextStyle(
          color: Colors.white38,
        ),

        counterText: '',
        // icon: Icon(Icons.account_circle),

        prefixIcon: const Icon(Icons.discount),
        prefixIconColor: Colors.white,

        filled: true,
        fillColor: primaryColor,

        border: const OutlineInputBorder(),
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}