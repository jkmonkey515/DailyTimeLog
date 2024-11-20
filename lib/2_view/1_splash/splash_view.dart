import 'package:dailytimelog/4_utils/color.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import '../../3_controller/1_splash/splash_controller.dart';

class SplashView extends GetView<SplashController>{
  const SplashView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:  Container(
        color: colorBackground,
        child: Center(child: Image.asset('assets/logo.jpg', width: 180, height: 180,)),
      ),
    );
  }
}