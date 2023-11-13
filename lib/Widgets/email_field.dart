import 'package:flutter/material.dart';

class EmailField extends StatefulWidget {

  final TextEditingController controller;
  final String hint;
  final int length;
  final TextInputAction nextOrDone;
  final FocusNode focusNode;
  final Function submitted;

  static void emptyFunction() {}

  const EmailField({
    super.key,
    required this.controller,
    this.hint = "************",
    this.length = 30,
    this.nextOrDone = TextInputAction.next,
    required this.focusNode,
    this.submitted = emptyFunction,
  });
  @override
  State<EmailField> createState() => _EmailFieldState();
}

class _EmailFieldState extends State<EmailField> {

  bool obscurePass = false, isIconVisible = true;

  late final String empty;
  late final String shortPassword;

  String? emailValidator(String? password)
  {
    if(password == null || password.isEmpty) {
      return empty;
    }

    else if(password.length < 6) {
      return shortPassword;
    }

    return null;
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      maxLength: widget.length,
      textInputAction: widget.nextOrDone,
      controller: widget.controller,
      focusNode: widget.focusNode,
      validator: emailValidator,
      onFieldSubmitted: (String name) {
        widget.submitted();
      },
      decoration: InputDecoration(
        labelText: 'Email',
        hintText: widget.hint,
        icon: const Icon(Icons.email),
      ),
    );
  }
}