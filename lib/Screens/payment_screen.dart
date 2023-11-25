import 'package:flutter/material.dart';

import 'package:car_pool_app/Widgets/custom_button.dart';
import 'package:car_pool_app/Widgets/custom_text.dart';
import 'package:car_pool_app/Widgets/sized_box.dart';

class PaymentScreen extends StatelessWidget {
  const PaymentScreen({ super.key });

  static const routeName = '/payment';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Payment Methods'),
        centerTitle: true,
      ),

      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CustomButton(
              shadow: false,
              child: const Padding(
                padding: EdgeInsets.all(10),
                child: CustomText(
                  text: 'Cash',
                  size: 20,
                ),
              ),
              onTap: () {},
            ),
      
            const HSizedBox(
              height: 50,
            ),
      
            CustomButton(
              shadow: false,
              child: const Padding(
                padding: EdgeInsets.all(10),
                child: CustomText(
                  text: 'App Credit',
                  size: 20,
                ),
              ),
              onTap: () {},
            ),
      
            const HSizedBox(
              height: 50,
            ),
            
            CustomButton(
              shadow: false,
              child: const Padding(
                padding: EdgeInsets.all(8.0),
                child: CustomText(
                  text: 'Credit Card',
                  size: 20,
                ),
              ),
              onTap: () {},
            ),
          ],
        ),
      ),
      
    );
  }
}