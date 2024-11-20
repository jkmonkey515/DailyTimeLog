import 'package:dailytimelog/3_controller/1_splash/splash_controller.dart';
import 'package:dailytimelog/3_controller/2_onboarding/onboarding_controller.dart';
import 'package:dailytimelog/3_controller/6_profile/profile_controller.dart';
import 'package:dailytimelog/4_utils/theme.dart';
import 'package:dailytimelog/5_components/custom_button.dart';
import 'package:dailytimelog/5_components/custom_spacers.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';

import '../../4_utils/color.dart';

class ProfileView extends GetView<ProfileController> {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colorBackground,
      appBar: AppBar(
        title: Text(
          'Profile Setup',
          textAlign: TextAlign.center,
          style: textStyleNavigationTitle(),
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
            const VSpaceWith(height: 20),
            Text(
              'Default activity type:',
              style: textStyleDefault(),
            ),

            Row(
              children: [
                Obx(() =>
                  Checkbox(
                    value: controller.checkedValue.value,
                    onChanged: (bool? newValue) {
                      controller.updateCheckbox();
                    },
                  )
                ),
                Text(
                  'College days',
                  style: textStyleDefault(),
                ),
                const Spacer(),
                editIconButton('college'),
              ],
            ),
            Row(
              children: [
                Obx(() =>
                    Checkbox(
                      value: controller.checkedValue.value,
                      onChanged: (bool? newValue) {
                        controller.updateCheckbox();
                      },
                    )
                ),
                Text(
                  'Skills practice',
                  style: textStyleDefault(),
                ),
                const Spacer(),
                editIconButton('skills'),
              ],
            ),
            Row(
              children: [
                Obx(() =>
                    Checkbox(
                      value: controller.checkedValue.value,
                      onChanged: (bool? newValue) {
                        controller.updateCheckbox();
                      },
                    )
                ),
                Text(
                  'Therapy',
                  style: textStyleDefault(),
                ),
                const Spacer(),
                editIconButton('therapy'),
              ],
            ),
            Row(
              children: [
                Obx(() =>
                    Checkbox(
                      value: controller.checkedValue.value,
                      onChanged: (bool? newValue) {
                        controller.updateCheckbox();
                      },
                    )
                ),
                Text(
                  'Placement',
                  style: textStyleDefault(),
                ),
                const Spacer(),
                editIconButton('placement'),
                editButton('placement'),
              ],
            ),

            const Divider(),

            GestureDetector(
              onTap: () {

              },
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  '+ Add category',
                  style: textStyleDefault(),
                ),
              ),
            ),

            GestureDetector(
              onTap: () {

              },
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  '+ Set reminder',
                  style: textStyleDefault(),
                ),
              ),
            ),

            const Spacer(),

            CustomButton(
                title: 'Upgrade',
                onPressed: () {
                  controller.gotoProfeatureView();
                }),
            
            const VSpaceWith(height: 30),
          ],
        ),
      ),
    );
  }

  Widget editIconButton(String item) {
    return IconButton(
      icon: const Icon(Icons.edit_note),
      onPressed: () {
        if(item.contains('college')) {
        }
        if(item.contains('skills')) {
        }
        if(item.contains('therapy')) {
        }
        if(item.contains('placement')) {
        }
      },
    );
  }
  Widget editButton(String item) {
    return GestureDetector(
      onTap: () {
        if(item.contains('college')) {
        }
        if(item.contains('skills')) {
        }
        if(item.contains('therapy')) {
        }
        if(item.contains('placement')) {
        }
      },
      child: const Text(
        'Edit',
        style: TextStyle(
          color: Color(0xFF828282),
          fontSize: 15,
          fontFamily: 'Odin Rounded',
          fontWeight: FontWeight.w700,
          decoration: TextDecoration.underline,
          height: 0,
        ),
      ),
    );
  }

}