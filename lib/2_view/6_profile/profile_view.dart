import 'package:dailytimelog/3_controller/1_splash/splash_controller.dart';
import 'package:dailytimelog/3_controller/2_onboarding/onboarding_controller.dart';
import 'package:dailytimelog/3_controller/6_profile/profile_controller.dart';
import 'package:dailytimelog/4_utils/theme.dart';
import 'package:dailytimelog/5_components/custom_spacers.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';

class ProfileView extends GetView<ProfileController> {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          'Profile Setup',
          textAlign: TextAlign.center,
          style: TextStyle(
              fontSize: 24.0,
              color: Color(0xFF171717),
              fontFamily: 'Quicksand',
              fontWeight: FontWeight.w700
          ),
        ),
        scrolledUnderElevation: 0,
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body:  Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.only(left: 20, right: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            Text(
              'Default activity type:',
              style: appDefaultTextStyle(),
            ),

            Obx(() =>
                CheckboxListTile(
                  title: const Text(
                    'College days'
                  ),
                  value: controller.checkedValue.value,
                  onChanged: (newValue) {
                    controller.updateCheckbox();
                  },
                  controlAffinity: ListTileControlAffinity.leading,
                )
            ),
            Obx(() =>
                CheckboxListTile(
                  title: const Text(
                      'Skills practice hours'
                  ),
                  value: controller.checkedValue.value,
                  onChanged: (newValue) {
                    controller.updateCheckbox();
                  },
                  controlAffinity: ListTileControlAffinity.leading,
                )
            ),
            Obx(() =>
                CheckboxListTile(
                  title: const Text(
                      'Therapy hours'
                  ),
                  value: controller.checkedValue.value,
                  onChanged: (newValue) {
                    controller.updateCheckbox();
                  },
                  controlAffinity: ListTileControlAffinity.leading,
                )
            ),
            Obx(() =>
                CheckboxListTile(
                  title: const Text(
                      'Placement hours'
                  ),
                  value: controller.checkedValue.value,
                  onChanged: (newValue) {
                    controller.updateCheckbox();
                  },
                  controlAffinity: ListTileControlAffinity.leading,
                )
            ),

            const Divider(),

            Text(
              'Pro features:',
              style: appDefaultTextStyle(),
            ),

            Text(
              'Add category',
              style: appDefaultTextStyle(),
            ),

            Text(
              'Reminders',
              style: appDefaultTextStyle(),
            ),
          ],
        ),
      ),
    );
  }

}