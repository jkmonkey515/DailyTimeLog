import 'package:dailytimelog/5_components/custom_button.dart';
import 'package:dailytimelog/5_components/custom_spacers.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';

import '../../3_controller/7_settings/change_password_controller.dart';
import '../../4_utils/color.dart';
import '../../4_utils/theme.dart';

class ChangePasswordView extends GetView<ChangePasswordController> {
  const ChangePasswordView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colorBackground,
      appBar: AppBar(
        title: Text(
          'Change Password',
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

            const Text(
                'Old Password:'
            ),

            const VSpaceWith(height: 10),
            currentPasswordTextField(),

            const VSpaceWith(height: 20),
            const Text(
                'New Password:'
            ),
            const VSpaceWith(height: 10),
            newPasswordTextField(),

            const Spacer(),
            CustomButton(
              title: 'Change Password',
              onPressed: () {
                controller.doChangePassword();
              }),
            const VSpaceWith(height: 30),
          ],
        ),
      ),
    );
  }

  Widget currentPasswordTextField() {
    return Container(
        padding: const EdgeInsets.only(left: 12, right: 5, ),
        decoration: BoxDecoration(
          border: Border.all(
            color: appPrimaryColor,
            width: 2.0, // Border width
          ),
          borderRadius: BorderRadius.circular(10), // Border radius
        ),
        height: 50,
        child: Row(
          children: [
            Obx(() =>
                Expanded(
                  child: TextField(
                    controller: controller.txtPassword,
                    style: const TextStyle(
                      fontSize: 17.0,
                      color: Colors.black, // You can customize the text color as well
                    ),
                    obscureText: !controller.isPasswordVisible.value,
                    onChanged: (text){
                      //controller.updateButtonBg();
                    },
                    decoration: InputDecoration.collapsed(
                      hintText: 'current password',
                      hintStyle: TextStyle(color: Colors.grey[300]),
                    ),
                  ),
                ),
            ),

            Obx(() =>
                IconButton(
                  onPressed: () {
                    controller.updatePasswordVisible();
                  },
                  icon: Icon(
                    controller.isPasswordVisible.value ? Icons.visibility_off :  Icons.visibility ,
                    color: appPrimaryColor,
                    size: 24,
                  ),
                ),
            ),
          ],
        )

    );
  }

  Widget newPasswordTextField() {
    return Container(
        padding: const EdgeInsets.only(left: 12, right: 5, ),
        decoration: BoxDecoration(
          border: Border.all(
            color: appPrimaryColor,
            width: 2.0, // Border width
          ),
          borderRadius: BorderRadius.circular(10), // Border radius
        ),
        height: 50,
        child: Row(
          children: [
            Obx(() =>
                Expanded(
                  child: TextField(
                    controller: controller.txtNewPassword,
                    style: const TextStyle(
                      fontSize: 17.0,
                      color: Colors.black, // You can customize the text color as well
                    ),
                    obscureText: !controller.isNewPasswordVisible.value,
                    onChanged: (text){
                      //controller.updateButtonBg();
                    },
                    decoration: InputDecoration.collapsed(
                      hintText: 'new password',
                      hintStyle: TextStyle(color: Colors.grey[300]),
                    ),
                  ),
                ),
            ),

            Obx(() =>
                IconButton(
                  onPressed: () {
                    controller.updateConfirmVisible();
                  },
                  icon: Icon(
                    controller.isNewPasswordVisible.value ? Icons.visibility_off :  Icons.visibility ,
                    color: appPrimaryColor,
                    size: 24,
                  ),
                ),
            ),
          ],
        )

    );
  }

}