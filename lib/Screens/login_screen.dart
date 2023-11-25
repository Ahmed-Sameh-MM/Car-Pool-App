import 'package:flutter/material.dart';

import 'package:car_pool_app/Widgets/email_field.dart';
import 'package:car_pool_app/Widgets/password_field.dart';
import 'package:car_pool_app/Widgets/sized_box.dart';
import 'package:car_pool_app/Widgets/custom_button.dart';
import 'package:car_pool_app/Screens/path_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  static const routeName = '/login';

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  
  final _loginFormKey = GlobalKey<FormState>();

  final _emailController = TextEditingController();

  final _passController = TextEditingController();

  late FocusNode _emailNode;

  late FocusNode _passNode;

  @override
  void initState() {

    _emailNode = FocusNode();
    _passNode = FocusNode();

    _emailNode.requestFocus();

    super.initState();
  }

  @override
  void dispose() {
    _emailNode.dispose();
    _passNode.dispose();
    
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login Screen'),
        centerTitle: true,
      ),

      body: Form(
        key: _loginFormKey,
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
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
                  // if(_loginFormKey.currentState!.validate()) {}
                  Navigator.pushNamed(context, PathScreen.routeName);
                },
                width: 100,
                height: 50,
                child: const Text('Login'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}