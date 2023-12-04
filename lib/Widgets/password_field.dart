import 'package:flutter/material.dart';

import 'package:car_pool_app/Static%20Data/colors.dart';

class PasswordField extends StatefulWidget {

  final TextEditingController controller;
  final String hint;
  final int length;
  final TextInputAction nextOrDone;
  final FocusNode focusNode;
  final Function submitted;

  static void emptyFunction() {}

  const PasswordField({
    super.key,
    required this.controller,
    this.hint = "************",
    this.length = 8,
    this.nextOrDone = TextInputAction.done,
    required this.focusNode,
    this.submitted = emptyFunction,
  });
  @override
  State<PasswordField> createState() => _PasswordFieldState();
}

class _PasswordFieldState extends State<PasswordField> {

  bool obscurePass = false, isIconVisible = true;

  late final String empty;
  late final String shortPassword;

  String? passValidator(String? password)
  {
    if(password == null || password.isEmpty) {
      return empty;
    }

    else if(password.length < 6) {
      return shortPassword;
    }

    return null;
  }

  bool togglePasswordVisible()
  {
    obscurePass = ! obscurePass;
    
    return obscurePass;
  }

  IconData toggleIcon()
  {
    isIconVisible = ! isIconVisible;

    if(isIconVisible) return Icons.visibility;

    return Icons.visibility_off;
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: togglePasswordVisible(),
      maxLength: widget.length,
      textInputAction: widget.nextOrDone,
      controller: widget.controller,
      focusNode: widget.focusNode,
      validator: passValidator,
      onFieldSubmitted: (String name) {
        widget.submitted();
      },

      style: const TextStyle(
        color: Colors.white,
      ),

      decoration: InputDecoration(
        labelText: 'Password',
        labelStyle: const TextStyle(
          color: Colors.white,
        ),

        hintText: widget.hint,
        hintStyle: const TextStyle(
          color: Colors.white38,
        ),

        counterText: '',

        prefixIcon: const Icon(Icons.lock),
        prefixIconColor: Colors.white,
        
        suffixIcon: IconButton(
          icon: Icon(toggleIcon()),
          onPressed: () {setState( () {} );},// toggle hide and view properties
        ),
        suffixIconColor: Colors.white,

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