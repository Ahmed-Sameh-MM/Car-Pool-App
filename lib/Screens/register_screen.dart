import 'package:driver_car_pool_app/Widgets/custom_alert_dialog.dart';
import 'package:flutter/material.dart';

import 'package:driver_car_pool_app/Widgets/email_field.dart';
import 'package:driver_car_pool_app/Widgets/password_field.dart';
import 'package:driver_car_pool_app/Widgets/sized_box.dart';
import 'package:driver_car_pool_app/Widgets/custom_button.dart';
import 'package:driver_car_pool_app/Widgets/name_field.dart';
import 'package:driver_car_pool_app/Services/authenticate.dart';
import 'package:driver_car_pool_app/Screens/login_screen.dart';
import 'package:driver_car_pool_app/Services/realtime_db.dart';
import 'package:driver_car_pool_app/Model%20Classes/driver.dart';
import 'package:driver_car_pool_app/Offline%20Storage/storage.dart';

import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;

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

    super.initState();
  }

  @override
  void dispose() {
    _nameNode.dispose();
    _emailNode.dispose();
    _passNode.dispose();
    
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Register Screen'),
        centerTitle: true,
      ),

      body: Center(
        child: SingleChildScrollView(
          child: Form(
            key: _registerFormKey,
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  NameField(
                    autoFocus: true,
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
                    onTap: () async {
                      if(_registerFormKey.currentState!.validate()) {
                        final registrationResult = await registerWithEmail(
                          email: _emailController.text,
                          password: _passController.text,
                        );
        
                        registrationResult.fold(
                          (error) {
                            CustomAlertDialog(
                              context: context,
                              error: error,
                            );
                          },
                          (success) async {
                            final uid = context.read<auth.User>().uid;
        
                            final driver = Driver(
                              uid: uid,
                              email: _emailController.text,
                              name: _nameContoller.text,
                              points: 0,
                              tripsCount: 0,
                            );
        
                            final addResult = await Realtime(uid: driver.uid).addDriverData(driver);
        
                            addResult.fold(
                              (error) {
                                CustomAlertDialog(
                                  context: context,
                                  error: error,
                                );
                              },
                              (success) async {
                                await DriverStorage.addDriver(driver);
                              },
                            );
                            
                            if(context.mounted) {
                              Navigator.pop(context);
                            }
                          },
                        );
                      }
                    },
                    width: 100,
                    height: 50,
                    child: const Text('Register'),
                  ),
        
                  const HSizedBox(
                    height: 30,
                  ),
        
                  CustomButton(
                    onTap: () {
                      Navigator.pushReplacementNamed(context, LoginScreen.routeName);
                    },
                    width: 170,
                    height: 50,
                    child: const Text('Want to Login Instead ?'),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}