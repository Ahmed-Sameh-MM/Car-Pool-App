import 'package:flutter/material.dart';

import 'package:car_pool_app/Widgets/email_field.dart';
import 'package:car_pool_app/Widgets/password_field.dart';
import 'package:car_pool_app/Widgets/sized_box.dart';
import 'package:car_pool_app/Widgets/custom_button.dart';
import 'package:car_pool_app/Widgets/name_field.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  static const routeName = '/register';

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  
  final _registerFormKey = GlobalKey<FormState>();

  final _nameContoller = TextEditingController();

  final _emailController = TextEditingController();

  final _passController = TextEditingController();

  late FocusNode _nameNode;

  late FocusNode _emailNode;

  late FocusNode _passNode;

  @override
  void initState() {

    _nameNode = FocusNode();
    _emailNode = FocusNode();
    _passNode = FocusNode();

    _nameNode.requestFocus();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Register Screen'),
        centerTitle: true,
      ),

      body: Form(
        key: _registerFormKey,
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              NameField(
                controller: _nameContoller,
                focusNode: _nameNode,
              ),

              const HSizedBox(
                height: 20,
              ),

              EmailField(
                controller: _emailController,
                focusNode: _emailNode,
              ),

              const HSizedBox(
                height: 20,
              ),

              PasswordField(
                controller: _passController,
                focusNode: _passNode,
              ),

              const HSizedBox(
                height: 20,
              ),

              CustomButton(
                onTap: () {
                  if(_registerFormKey.currentState!.validate()) {}
                },
                width: 100,
                height: 50,
                child: const Text('Register'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}