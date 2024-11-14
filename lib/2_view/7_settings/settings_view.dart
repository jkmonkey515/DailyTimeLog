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
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          'Settings',
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

            menuItem('Profile'),
            const VSpaceWith(height: 20),
            menuItem('Password'),
            const VSpaceWith(height: 30),
            const Divider(),

            const Spacer(),

            profeatureView(),
            const VSpaceWith(height: 20),
            CustomButton(
                title: 'Upgrade',
                onPressed: () {
                  controller.doChangePassword();
                }),
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
            side: const BorderSide(width: 1, color: Color(0xFFC8C8C8)),
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
                    style: appDefaultTextStyle(),
                  ),
                ),

                const Icon(Icons.arrow_forward_ios, color: appPrimaryColor,)
              ],
            ),
          ),
        )
    );
  }

  Widget profeatureView() {
    return const Padding(
      padding: EdgeInsets.all(8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text(
            'Pro:',
            style: TextStyle(
              color: appPrimaryColor,
              fontSize: 24,
              fontFamily: 'Inter',
              fontWeight: FontWeight.w600,
            ),
          ),

          HSpaceWith(width: 10),

          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '1. Data export',
                textAlign: TextAlign.left,
                style: TextStyle(
                  color: Color(0xFF171717),
                  fontSize: 20,
                  fontFamily: 'Quicksand',
                  fontWeight: FontWeight.w400,
                  height: 0,
                ),
              ),

              Text(
                '   - Export to CSV or PDF',
                textAlign: TextAlign.left,
                style: TextStyle(
                  color: Color(0xFF171717),
                  fontSize: 14,
                  fontFamily: 'Quicksand',
                  fontWeight: FontWeight.w400,
                  height: 0,
                ),
              ),

              VSpaceWith(height: 10),
              Text(
                '2. Categories',
                textAlign: TextAlign.left,
                style: TextStyle(
                  color: Color(0xFF171717),
                  fontSize: 20,
                  fontFamily: 'Quicksand',
                  fontWeight: FontWeight.w400,
                  height: 0,
                ),
              ),
              Text(
                '   - Edit existing categories or add new ones',
                textAlign: TextAlign.left,
                style: TextStyle(
                  color: Color(0xFF171717),
                  fontSize: 14,
                  fontFamily: 'Quicksand',
                  fontWeight: FontWeight.w400,
                  height: 0,
                ),
              ),

              VSpaceWith(height: 10),
              Text(
                '3. Offline sync',
                textAlign: TextAlign.left,
                style: TextStyle(
                  color: Color(0xFF171717),
                  fontSize: 20,
                  fontFamily: 'Quicksand',
                  fontWeight: FontWeight.w400,
                  height: 0,
                ),
              ),
              Text(
                '   - Toggle to manage offline functionality',
                textAlign: TextAlign.left,
                style: TextStyle(
                  color: Color(0xFF171717),
                  fontSize: 14,
                  fontFamily: 'Quicksand',
                  fontWeight: FontWeight.w400,
                  height: 0,
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}