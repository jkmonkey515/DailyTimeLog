import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import '../../4_utils/route.dart';


class ProfeaturesController extends GetxController {
  final cache = GetStorage();

  TextEditingController txtPassword = TextEditingController();
  var isPasswordVisible = false.obs;

  TextEditingController txtNewPassword = TextEditingController();
  var isNewPasswordVisible = false.obs;

  @override
  void onInit() {
    super.onInit();

  }

}