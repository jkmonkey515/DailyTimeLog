import 'package:dailytimelog/3_controller/2_onboarding/onboarding_controller.dart';
import 'package:dailytimelog/3_controller/7_settings/settings_controller.dart';
import 'package:dailytimelog/4_utils/theme.dart';
import 'package:dailytimelog/5_components/custom_button.dart';
import 'package:dailytimelog/5_components/custom_spacers.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';

import '../../4_utils/color.dart';

class SettingsView extends GetView<SettingsController> {
  const SettingsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colorBackground,
      appBar: AppBar(
        title: Text(
          'Settings',
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
            menuItem('Profile'),

            const VSpaceWith(height: 20),
            Obx(() =>
              Visibility(
              visible: controller.purchaseStatus.value==0?false: true,
              child:  menuItem('Export Data')
              )),

            const VSpaceWith(height: 20),
            menuItem('Change Password'),
            const VSpaceWith(height: 30),

            const Spacer(),

            // profeatureView(),
            const VSpaceWith(height: 20),
            Obx(() =>
              Visibility(
              visible: controller.purchaseStatus.value==1?false: true,
                      child: CustomButton(
                          title: 'Upgrade',
                          onPressed: () {
                            controller.gotoPurchaseScreen();
                          })
              )),
            const VSpaceWith(height: 30),
          ],
        ),
      ),
    );
  }

  Widget menuItem(String title) {
    return Container(
        height: 50,
        decoration: ShapeDecoration(
          color: const Color(0xFFE4E4E4),
          shape: RoundedRectangleBorder(
            side: const BorderSide(width: 1, color: appPrimaryColor),
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        child: GestureDetector(
          onTap: () {
            controller.gotoNextView(title);
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    title,
                    style: textStyleDefault(),
                  ),
                ),

                const Icon(Icons.arrow_forward_ios, color: appPrimaryColor,)
              ],
            ),
          ),
        )
    );
  }

}