import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import '../../4_utils/constats.dart';
import '../../4_utils/route.dart';


class ChangePasswordController extends GetxController {
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
    String password= cache.read('password')??"";
    if(txtPassword.text ==password){
      if(txtNewPassword.text.isEmpty){
        Constants.showInfoDialog("Caution!", "New password field can't be empty");
      }else{
        cache.remove('password');
        cache.write('password', txtNewPassword.text);
        Constants.showInfoDialog("Caution!", "Password changed successfully");
      }
    }else{
      Constants.showInfoDialog("Caution!", "Current password is wrong");
    }
  }

  gotoNextView(String menuTitle) {

  }
}