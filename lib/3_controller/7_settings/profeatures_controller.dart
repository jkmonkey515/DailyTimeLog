import 'package:dailytimelog/3_controller/6_profile/profile_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import '../../4_utils/constats.dart';
import '../../4_utils/route.dart';


class ProfeaturesController extends GetxController {
  final cache = GetStorage();



  @override
  void onInit() {
    super.onInit();

  }

  void tryIap() {
    cache.remove('ispurchase');
    cache.write("ispurchase", 1);
    bool isProfileController = Get.isRegistered<ProfileController>();
    if(isProfileController){
      ProfileController profileController = Get.find();
      profileController.initData();
    }
    Get.back();
  }

}