import 'package:dailytimelog/3_controller/2_onboarding/onboarding_controller.dart';
import 'package:dailytimelog/3_controller/4_loghours/loghours_controller.dart';
import 'package:dailytimelog/5_components/custom_button.dart';
import 'package:dailytimelog/5_components/custom_spacers.dart';
import 'package:dailytimelog/5_components/custom_textfield.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';

import '../../4_utils/color.dart';
import '../../4_utils/theme.dart';

class LoghoursView extends GetView<LoghoursController> {
  const LoghoursView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colorBackground,
      appBar: AppBar(
        title: Text(
          'Log Hours',
          textAlign: TextAlign.center,
          style: textStyleNavigationTitle(),
        ),
        scrolledUnderElevation: 0,
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body:  Container(
        padding: const EdgeInsets.only(left: 20, right: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const VSpaceWith(height: 20),
            Text(
              'Select Date:',
              style: textStyleDefault(),
            ),
            const VSpaceWith(height: 8),

            CustomTextfield(
                placeholder: 'Select Date',
                controller: controller.txtHours,
                onChangeCallback: controller.onChangeHoursCallback),

            const VSpaceWith(height: 20),

            Text(
              'Activity Type:',
              textAlign: TextAlign.center,
              style: textStyleDefault(),
            ),
            const VSpaceWith(height: 8),
            CustomTextfield(
                placeholder: 'Enter hours',
                controller: controller.txtHours,
                onChangeCallback: controller.onChangeHoursCallback),

            const VSpaceWith(height: 20),
            Text(
              'Hours:',
              textAlign: TextAlign.center,
              style: textStyleDefault(),
            ),
            const VSpaceWith(height: 8),
            CustomTextfield(
                placeholder: 'Enter hours',
                controller: controller.txtHours,
                onChangeCallback: controller.onChangeHoursCallback),

            const Spacer(),
            CustomButton(
              title: "SAVE",
              onPressed: () {
                controller.doSaveAction();
              }
            ),

            const VSpaceWith(height: 30),
          ],
        ),
      ),
    );
  }

  Widget selectDateView() {
    return Text(
      'Select Date:',
      textAlign: TextAlign.center,
      style: textStyleDefault(),
    );
  }

  Widget activityTypeView() {
    return Text(
      'Activity Type',
      textAlign: TextAlign.center,
      style: textStyleDefault(),
    );
  }

}