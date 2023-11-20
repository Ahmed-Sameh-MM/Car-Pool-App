import 'package:flutter/material.dart';

class NameField extends StatelessWidget {

  final TextEditingController controller;
  final FocusNode focusNode;

  final String labelText;

  final int maxLength;

  const NameField({
    super.key,
    required this.controller,
    required this.focusNode,
    this.maxLength = 20,
    this.labelText = 'Name',
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
      decoration: InputDecoration(
        labelText: labelText,
        labelStyle: const TextStyle(
          color: Colors.white,
        ),

        hintText: 'Enter Name here!',
        counterText: '',
        // icon: Icon(Icons.account_circle),

        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(50.0),
        ),
      ),
    );
  }
}