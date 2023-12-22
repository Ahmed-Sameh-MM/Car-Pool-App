import 'package:flutter/material.dart';

import 'package:driver_car_pool_app/Widgets/custom_container.dart';
import 'package:driver_car_pool_app/Widgets/custom_text.dart';
import 'package:driver_car_pool_app/Model%20Classes/driver.dart';
import 'package:driver_car_pool_app/Widgets/sized_box.dart';
import 'package:driver_car_pool_app/Static%20Data/colors.dart';
import 'package:driver_car_pool_app/Services/authenticate.dart';
import 'package:driver_car_pool_app/Widgets/custom_button.dart';
import 'package:driver_car_pool_app/Offline%20Storage/storage.dart';
import 'package:driver_car_pool_app/Services/realtime_db.dart';
import 'package:driver_car_pool_app/Widgets/custom_alert_dialog.dart';

class ProfileColumn extends StatefulWidget {
  const ProfileColumn({
    super.key,
    required this.driver,
  });

  final Driver driver;

  @override
  State<ProfileColumn> createState() => _ProfileColumnState();
}

class _ProfileColumnState extends State<ProfileColumn> {

  late bool disableValidation;
  late bool disableApproval;

  late bool isLoaded;
  late bool isError;

  Future initSwitchValue() async {
    final future = await getValidationSwitchValue();

    future.fold(
      (error) {
        setState(() {
          isError = true;
        });

        CustomAlertDialog(
          context: context,
          error: error,
        );
      },
      (validationValue) async {
        final approvalFuture = await getApprovalSwitchValue();

        approvalFuture.fold(
          (error) {
            setState(() {
              isError = true;
            });

            CustomAlertDialog(
              context: context,
              error: error,
            );
          },
          (approvalValue) {
            setState(() {
              isLoaded = true;
              disableValidation = validationValue;
              disableApproval = approvalValue;
            });
          },
        );
      },
    );
  }

  @override
  void initState() {
    isLoaded = false;
    isError = false;

    disableValidation = false;
    disableApproval = false;
    
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
              text: widget.driver.name,
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
                    text: 'Points: ${widget.driver.points}',
                    size: 18,
                    fontWeight: FontWeight.bold,
                  ),

                  const HSizedBox(
                    height: 15,
                  ),

                  CustomText(
                    text: 'Trips Taken: ${widget.driver.tripsCount}',
                    size: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ],
              ),
            ),

            const HSizedBox(
              height: 30,
            ),

            isLoaded ? Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const CustomText(
                      text: 'Disable Time Validation:',
                      size: 20,
                    ),

                    const WSizedBox(
                      width: 10,
                    ),

                    Switch(
                      value: disableValidation,
                      onChanged: (value) async {
                        final future = await setValidationSwitchValue(value);
                        
                        future.fold(
                          (error) {
                            CustomAlertDialog(
                              context: context,
                              error: error,
                            );
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
                ),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const CustomText(
                      text: 'Disable Approval Validation:',
                      size: 20,
                    ),

                    const WSizedBox(
                      width: 10,
                    ),

                    Switch(
                      value: disableApproval,
                      onChanged: (value) async {
                        final future = await setApprovalSwitchValue(value);
                        
                        future.fold(
                          (error) {
                            CustomAlertDialog(
                              context: context,
                              error: error,
                            );
                          },
                          (success) {
                            setState(() {
                              disableApproval = value;
                            });
                          },
                        );
                      },
                      trackColor: MaterialStateProperty.all<Color>(Colors.white),
                      thumbColor: MaterialStateProperty.all<Color>(Colors.red),
                      activeColor: Colors.red,
                    ),
                  ],
                ),
              ],
            ) : isError ? const CustomText(text: "Connection Error, Try Again Later", size: 20,) : const CircularProgressIndicator(
              color: Colors.white,
            ),

            const HSizedBox(
              height: 80,
            ),

            CustomButton(
              shadow: false,
              width: 150,
              height: 50,
              onTap: () async {
                await DriverStorage.deleteDriver();
                
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