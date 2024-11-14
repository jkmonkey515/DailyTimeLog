import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import '../../4_utils/route.dart';


class OnboardingController extends GetxController {
  final cache = GetStorage();
  TextEditingController textController = TextEditingController();

  TextEditingController passController = TextEditingController();
  var isPasswordVisible = false.obs;
  var isFieldsFilled = false.obs;

  @override
  void onInit() {
    super.onInit();

  }

  onChangeCallback(String returnValue){
    print(returnValue);
  }
  gotoNextView() {
    Get.offNamed(RouteName.maintabView);
    // textController.text="test";
  }

  void updatePasswordVisible() {
    isPasswordVisible.value = !isPasswordVisible.value;
  }

}