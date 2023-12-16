import 'package:flutter/material.dart';

import 'package:car_pool_app/Widgets/custom_container.dart';
import 'package:car_pool_app/Widgets/custom_text.dart';
import 'package:car_pool_app/Model%20Classes/user.dart';
import 'package:car_pool_app/Widgets/sized_box.dart';
import 'package:car_pool_app/Static%20Data/colors.dart';
import 'package:car_pool_app/Services/authenticate.dart';
import 'package:car_pool_app/Widgets/custom_button.dart';
import 'package:car_pool_app/Offline%20Storage/storage.dart';
import 'package:car_pool_app/Services/realtime_db.dart';

class ProfileColumn extends StatefulWidget {
  const ProfileColumn({
    super.key,
    required this.user,
  });

  final User user;

  @override
  State<ProfileColumn> createState() => _ProfileColumnState();
}

class _ProfileColumnState extends State<ProfileColumn> {

  late bool disableValidation;

  late bool isLoaded;

  Future initSwitchValue() async {
    final future = await getSwitchValue();

    future.fold(
      (error) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(error.errorMessage)));
      },
      (switchValue) {
        setState(() {
          isLoaded = true;
          disableValidation = switchValue;
        });
      },
    );
  }

  @override
  void initState() {
    isLoaded = false;
    disableValidation = false;
    
    initSwitchValue();

    super.initState();
  }

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
              text: widget.user.name,
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
                    text: 'Points: ${widget.user.points}',
                    size: 18,
                    fontWeight: FontWeight.bold,
                  ),

                  const HSizedBox(
                    height: 15,
                  ),

                  CustomText(
                    text: 'Trips Taken: ${widget.user.tripsCount}',
                    size: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ],
              ),
            ),

            const HSizedBox(
              height: 30,
            ),

            isLoaded ? Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const CustomText(
                  text: 'Disable Validation:',
                  size: 20,
                ),

                const WSizedBox(
                  width: 10,
                ),

                Switch(
                  value: disableValidation,
                  onChanged: (value) async {
                    final future = await setSwitchValue(value);
                    
                    future.fold(
                      (error) {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(error.errorMessage)));
                      },
                      (success) {
                        setState(() {
                          disableValidation = value;
                        });
                      },
                    );
                  },
                  trackColor: MaterialStateProperty.all<Color>(Colors.white),
                  thumbColor: MaterialStateProperty.all<Color>(Colors.red),
                  activeColor: Colors.red,
                ),
              ],
            ) : const CircularProgressIndicator(),

            const HSizedBox(
              height: 110,
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