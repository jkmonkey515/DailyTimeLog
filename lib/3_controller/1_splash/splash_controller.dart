import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import '../../4_utils/route.dart';


class SplashController extends GetxController {
  final cache = GetStorage();
  @override
  void onInit() {
    super.onInit();

    Future.delayed(const Duration(seconds: 1), () {
      gotoNextView();
    });
  }

  gotoNextView() {
    Get.offNamed(RouteName.onboardingView);
  }
}