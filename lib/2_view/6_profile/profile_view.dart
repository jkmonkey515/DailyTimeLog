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
            GetBuilder(
              init: controller,
              id: 'category_list',
              builder: (_)
              {
                return
                      Column(
                        children: controller.activityTypeWidgets,
                      );
              }),

            const Divider(),
            Obx(() =>
              Visibility(
                visible: controller.purchaseStatus.value==0?false: true,
                child: GestureDetector(
                  onTap: () {
                    controller.categoryInfoDialog(null);
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      '+ Add category',
                      style: textStyleDefault(),
                    ),
                  ),
                            ),
              )),

            // GestureDetector(
            //   onTap: () {
            //
            //   },
            //   child: Padding(
            //     padding: const EdgeInsets.all(8.0),
            //     child: Text(
            //       '+ Set reminder',
            //       style: textStyleDefault(),
            //     ),
            //   ),
            // ),

            const Spacer(),
            Obx(() =>
                Visibility(
                  visible: controller.purchaseStatus.value==0?true: false,
                  child: CustomButton(
                      title: 'Upgrade',
                      onPressed: () {
                        controller.gotoProfeatureView();
                      }),
                )
            ),
            
            const VSpaceWith(height: 30),
          ],
        ),
      ),
    );
  }




}