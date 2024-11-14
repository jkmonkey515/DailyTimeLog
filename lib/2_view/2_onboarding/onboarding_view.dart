import 'package:dailytimelog/3_controller/2_onboarding/onboarding_controller.dart';
import 'package:dailytimelog/4_utils/color.dart';
import 'package:dailytimelog/5_components/custom_button.dart';
import 'package:dailytimelog/5_components/custom_spacers.dart';
import 'package:dailytimelog/5_components/custom_textfield.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';

class OnboardingView extends GetView<OnboardingController> {
  const OnboardingView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          'Register',
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
          children: [

            const Spacer(),

            passwordTextField(),

            // CustomTextfield(
            //   placeholder: "Enter password",
            //   controller: controller.textController,
            //   onChangeCallback: controller.onChangeCallback,
            // ),

            const VSpaceWith(height: 30),

            CustomButton(
              title: "SAVE",
              onPressed: () {
                controller.gotoNextView();
              }
            ),

            const Spacer(),
          ],
        ),
      ),
    );
  }

  Widget passwordTextField() {
    return Container(
        padding: const EdgeInsets.only(left: 12, right: 5, ),
        decoration: BoxDecoration(
          border: Border.all(
            color: appGray, // Custom border color
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
                    controller: controller.passController,
                    style: const TextStyle(
                      fontSize: 17.0,
                      color: Colors.black, // You can customize the text color as well
                    ),
                    obscureText: !controller.isPasswordVisible.value,
                    onChanged: (text){
                      //controller.updateButtonBg();
                    },
                    decoration: InputDecoration.collapsed(
                      hintText: '********',
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
                    color: Colors.red,
                    size: 24,
                  ),
                ),
            ),
          ],
        )

    );
  }
}