import 'package:flutter/material.dart';

import 'package:car_pool_app/Static%20Data/colors.dart';

class NameField extends StatelessWidget {

  final TextEditingController controller;
  final FocusNode focusNode;

  final String labelText;

  final int maxLength;

  final bool autoFocus;

  const NameField({
    super.key,
    required this.controller,
    required this.focusNode,
    this.maxLength = 20,
    this.labelText = 'Name',
    this.autoFocus = false,
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
      autofocus: autoFocus,
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

        hintText: 'Enter Name here!',
        hintStyle: const TextStyle(
          color: Colors.white38,
        ),

        counterText: '',
        // icon: Icon(Icons.account_circle),

        prefixIcon: const Icon(Icons.account_circle),
        prefixIconColor: Colors.white,

        filled: true,
        fillColor: primaryColor,

        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(50.0),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(50.0),
          borderSide: const BorderSide(
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}