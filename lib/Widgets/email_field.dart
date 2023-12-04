import 'package:car_pool_app/Static%20Data/colors.dart';
import 'package:flutter/material.dart';

import 'package:car_pool_app/Static%20Data/constants.dart';

class EmailField extends StatefulWidget {

  final TextEditingController controller;
  final String hint;
  final int length;
  final TextInputAction nextOrDone;
  final FocusNode focusNode;
  final Function submitted;
  final bool autoFocus;

  static void emptyFunction() {}

  const EmailField({
    super.key,
    required this.controller,
    this.hint = "example@eng.asu.edu.eg",
    this.length = 25,
    this.nextOrDone = TextInputAction.next,
    required this.focusNode,
    this.submitted = emptyFunction,
    this.autoFocus = false,
  });
  @override
  State<EmailField> createState() => _EmailFieldState();
}

class _EmailFieldState extends State<EmailField> {

  late final String empty;

  String? emailValidator(String? email)
  {
    if(email == null || email.isEmpty) {
      return empty;
    }

    else if(! email.endsWith(emailDomain)) {
      return 'Wrong Domain Name !';
    }

    return null;
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      autofocus: widget.autoFocus,
      maxLength: widget.length,
      textInputAction: widget.nextOrDone,
      controller: widget.controller,
      focusNode: widget.focusNode,
      validator: emailValidator,
      onFieldSubmitted: (String name) {
        widget.submitted();
      },

      style: const TextStyle(
        color: Colors.white,
      ),

      decoration: InputDecoration(
        labelText: 'Email',
        labelStyle: const TextStyle(
          color: Colors.white,
        ),

        hintText: widget.hint,
        hintStyle: const TextStyle(
          color: Colors.white38,
        ),

        counterText: '',

        prefixIcon: const Icon(Icons.email),
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