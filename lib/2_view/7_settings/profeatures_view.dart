import 'package:dailytimelog/3_controller/2_onboarding/onboarding_controller.dart';
import 'package:dailytimelog/3_controller/7_settings/profeatures_controller.dart';
import 'package:dailytimelog/3_controller/7_settings/settings_controller.dart';
import 'package:dailytimelog/4_utils/theme.dart';
import 'package:dailytimelog/5_components/custom_button.dart';
import 'package:dailytimelog/5_components/custom_spacers.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';

import '../../4_utils/color.dart';

class ProfeaturesView extends GetView<ProfeaturesController> {
  const ProfeaturesView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colorBackground,
      appBar: AppBar(
        title: Text(
          'Pro Features',
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
            profeatureView(),

            const Spacer(),

            const VSpaceWith(height: 20),
            CustomButton(
                title: 'Upgrade',
                onPressed: () {
                  controller.tryIap();
                }),
            const VSpaceWith(height: 30),
          ],
        ),
      ),
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
                  fontFamily: 'Odin Rounded',
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
                  fontFamily: 'Odin Rounded',
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
                  fontFamily: 'Odin Rounded',
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
                  fontFamily: 'Odin Rounded',
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
                  fontFamily: 'Odin Rounded',
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
                  fontFamily: 'Odin Rounded',
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