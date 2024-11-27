import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class ProfeaturesController extends GetxController {
  final cache = GetStorage();

  @override
  void onInit() {
    super.onInit();

  }


  void tryIap() {
    // cache.remove('ispurchase');
    // cache.write("ispurchase", 1);
    // bool isProfileController = Get.isRegistered<ProfileController>();
    // if(isProfileController){
    //   ProfileController profileController = Get.find();
    //   profileController.initData();
    // }
    // Get.back();
  }

}