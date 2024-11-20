import 'package:dailytimelog/2_view/2_onboarding/onboarding_view.dart';
import 'package:dailytimelog/2_view/3_maintab/maintab_view.dart';
import 'package:dailytimelog/2_view/4_loghours/loghours_view.dart';
import 'package:dailytimelog/2_view/5_statistics/statistics_view.dart';
import 'package:dailytimelog/2_view/6_profile/profile_view.dart';
import 'package:dailytimelog/2_view/7_settings/change_password_view.dart';
import 'package:dailytimelog/2_view/7_settings/profeatures_view.dart';
import 'package:dailytimelog/2_view/7_settings/settings_view.dart';
import 'package:dailytimelog/3_controller/1_splash/splash_controller.dart';
import 'package:dailytimelog/3_controller/2_onboarding/onboarding_controller.dart';
import 'package:dailytimelog/3_controller/3_maintab/maintab_controller.dart';
import 'package:dailytimelog/3_controller/4_loghours/loghours_controller.dart';
import 'package:dailytimelog/3_controller/5_statistics/statistics_controller.dart';
import 'package:dailytimelog/3_controller/6_profile/profile_controller.dart';
import 'package:dailytimelog/3_controller/7_settings/change_password_controller.dart';
import 'package:dailytimelog/3_controller/7_settings/profeatures_controller.dart';
import 'package:dailytimelog/3_controller/7_settings/settings_controller.dart';
import 'package:get/get.dart';

import '../2_view/1_splash/splash_view.dart';

class RouteName {
  static const String splashView = "/SplashView";
  static const String onboardingView = "/OnboardingView";
  static const String maintabView = "/MainTabView";
  static const String loghoursView = "/LoghoursView";
  static const String statisticsView = "/StatisticsView";
  static const String profileView = "/ProfileView";
  static const String settingsView = "/SettingsView";
  static const String changePasswordView = "/ChangePasswordView";
  static const String profeaturesView = "/ProfeaturesView";

}


abstract class Routes {
  static final routes = [
    GetPage(
        name: RouteName.profeaturesView,
        page: () => const ProfeaturesView(),
        binding: BindingsBuilder(() {
          Get.put(ProfeaturesController());
        })),
    GetPage(
        name: RouteName.changePasswordView,
        page: () => const ChangePasswordView(),
        binding: BindingsBuilder(() {
          Get.put(ChangePasswordController());
        })),
    GetPage(
        name: RouteName.splashView,
        page: () => const SplashView(),
        binding: BindingsBuilder(() {
          Get.put(SplashController());
        })),
    GetPage(
        name: RouteName.onboardingView,
        page: () => const OnboardingView(),
        binding: BindingsBuilder(() {
          Get.put(OnboardingController());
        })),
    GetPage(
        name: RouteName.maintabView,
        page: () => const MainTabView(),
        binding: BindingsBuilder(() {
          Get.put(MainTabController());
          Get.put(LoghoursController());
          Get.put(StatisticsController());
          Get.put(SettingsController());
        })),
    GetPage(
        name: RouteName.loghoursView,
        page: () => const LoghoursView(),
        binding: BindingsBuilder(() {
          Get.put(LoghoursController());
        })),
    GetPage(
        name: RouteName.statisticsView,
        page: () => const StatisticsView(),
        binding: BindingsBuilder(() {
          Get.put(StatisticsController());
        })),
    GetPage(
        name: RouteName.profileView,
        page: () => const ProfileView(),
        binding: BindingsBuilder(() {
          Get.put(ProfileController());
        })),
    GetPage(
        name: RouteName.settingsView,
        page: () => const SettingsView(),
        binding: BindingsBuilder(() {
          Get.put(SettingsController());
        })),




  ];
}