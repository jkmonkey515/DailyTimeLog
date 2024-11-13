import 'package:dailytimelog/3_controller/2_onboarding/onboarding_controller.dart';
import 'package:dailytimelog/5_components/custom_button.dart';
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
          'Create account',
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

            CustomTextfield(hintText: "Enter password", controller: controller.textController,maxLength: 20, onChangeCallback: controller.onChangeCallback,),

            CustomButton(
              title: "SAVE",
              onPressed: () {

              }
            ),

          ],
        ),
      ),
    );
  }

}