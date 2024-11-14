import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';


class LoghoursController extends GetxController {
  final cache = GetStorage();

  TextEditingController txtHours = TextEditingController();

  @override
  void onInit() {
    super.onInit();

  }

  onChangeHoursCallback(int value){
    print(value);
  }


  doSaveAction() {

  }
}