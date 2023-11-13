import 'package:flutter/material.dart';

import 'package:car_pool_app/Widgets/email_field.dart';
import 'package:car_pool_app/Widgets/password_field.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});

  final loginFormKey = GlobalKey<FormState>();

  final emailController = TextEditingController();
  final passController = TextEditingController();

  final emailNode = FocusNode();
  final passNode = FocusNode();

  static const routeName = '/login';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login Screen'),
        centerTitle: true,
      ),

      body: Form(
        key: loginFormKey,
        child: Column(
          children: [
            EmailField(controller: emailController, focusNode: emailNode,),
            PasswordField(controller: passController, focusNode: passNode),
          ],
        ),
      ),
    );
  }
}