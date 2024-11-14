import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import '../../4_utils/route.dart';


class ProfileController extends GetxController {
  final cache = GetStorage();

  var checkedValue = false.obs;

  @override
  void onInit() {
    super.onInit();

  }

  gotoNextView() {
    // Get.offNamed(RouteName.onboardingView);
  }
  void updateCheckbox() {
    checkedValue.value = !checkedValue.value;
  }

}