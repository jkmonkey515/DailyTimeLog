import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import '../../4_utils/constats.dart';
import '../../4_utils/route.dart';


class OnboardingController extends GetxController {
  final cache = GetStorage();
  TextEditingController passController = TextEditingController();
  var isPasswordVisible = false.obs;
  var isFieldsFilled = false.obs;
  var isLogin = false.obs;

  @override
  void onInit() {
    super.onInit();
    String password= cache.read('password')??"";
    if(password.isNotEmpty){
      isLogin.value = true;
    }
  }

  onChangeCallback(String returnValue){
    print(returnValue);
  }
  gotoNextView() {
    if(isLogin.value==false){
      if(passController.text.isEmpty){
        Constants.showInfoDialog("Caution!", "Password field can't be empty!");
      }else{
        cache.erase();
        cache.write('password', passController.text);
        Get.offNamed(RouteName.maintabView);
      }
    }else{
      String password= cache.read('password')??"";
      if(password == passController.text){
        Get.offNamed(RouteName.maintabView);
      }else{
        Constants.showInfoDialog("Caution!", "Wrong password");
      }
    }
  }

  void updatePasswordVisible() {
    isPasswordVisible.value = !isPasswordVisible.value;
  }

}