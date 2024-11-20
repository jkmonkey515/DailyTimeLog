import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import '../../4_utils/route.dart';


class SettingsController extends GetxController {
  final cache = GetStorage();

  TextEditingController txtPassword = TextEditingController();
  var isPasswordVisible = false.obs;

  TextEditingController txtNewPassword = TextEditingController();
  var isNewPasswordVisible = false.obs;

  @override
  void onInit() {
    super.onInit();

  }

  void updatePasswordVisible() {
    isPasswordVisible.value = !isPasswordVisible.value;
  }

  void updateConfirmVisible() {
    isNewPasswordVisible.value = !isNewPasswordVisible.value;
  }

  doChangePassword() {

  }

  gotoNextView(String menuTitle) {
    if(menuTitle.contains('Export')) {
      // do export data action
    }
    if(menuTitle.contains('Password')) {
      Get.toNamed(RouteName.changePasswordView);
    }

    if(menuTitle.contains('Profile')) {
      Get.toNamed(RouteName.profileView);
    }
  }
}