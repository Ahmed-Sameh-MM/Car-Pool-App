import 'package:car_pool_app/Offline%20Storage/storage.dart';
import 'package:flutter/material.dart';

import 'package:car_pool_app/Widgets/custom_container.dart';
import 'package:car_pool_app/Widgets/custom_text.dart';
import 'package:car_pool_app/Model%20Classes/user.dart';
import 'package:car_pool_app/Widgets/sized_box.dart';
import 'package:car_pool_app/Static%20Data/colors.dart';
import 'package:car_pool_app/Services/authenticate.dart';
import 'package:car_pool_app/Widgets/custom_button.dart';

class ProfileColumn extends StatelessWidget {
  const ProfileColumn({
    super.key,
    required this.user,
  });

  final User user;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.only(top: 15.0),
        child: Column(
          children: [
            const CircleAvatar(
              backgroundColor: Color(0xFFE7E4E4),
              foregroundColor: Colors.black,
              radius: 50,
              child: Icon(
                Icons.person,
                size: 50,
              ),
            ),

            const HSizedBox(
              height: 8,
            ),

            CustomText(
              text: user.name,
              size: 28,
              fontWeight: FontWeight.bold,
            ),

            const HSizedBox(
              height: 20,
            ),

            CustomContainer(
              width: MediaQuery.of(context).size.width * 0.9,
              vpadding: 20,
              color: primaryColor,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomText(
                    text: 'Points: ${user.points}',
                    size: 18,
                    fontWeight: FontWeight.bold,
                  ),

                  const HSizedBox(
                    height: 15,
                  ),

                  CustomText(
                    text: 'Trips Taken: ${user.tripsCount}',
                    size: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ],
              ),
            ),

            const HSizedBox(
              height: 180,
            ),

            CustomButton(
              shadow: false,
              width: 150,
              height: 50,
              onTap: () async {
                await UserStorage.deleteUser();
                
                await signout();
              },
              child: const CustomText(
                text: 'Sign Out',
                size: 30,
                textColor: Colors.red,
              ),
            ),
          ],
        ),
      ),
    );
  }
}