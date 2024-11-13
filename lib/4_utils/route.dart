import 'package:dailytimelog/2_view/2_onboarding/onboarding_view.dart';
import 'package:dailytimelog/2_view/3_dashboard/dashboard_view.dart';
import 'package:dailytimelog/2_view/4_loghours/loghours_view.dart';
import 'package:dailytimelog/2_view/5_statistics/statistics_view.dart';
import 'package:dailytimelog/2_view/6_profile/profile_view.dart';
import 'package:dailytimelog/2_view/7_settings/settings_view.dart';
import 'package:dailytimelog/3_controller/1_splash/splash_controller.dart';
import 'package:dailytimelog/3_controller/2_onboarding/onboarding_controller.dart';
import 'package:dailytimelog/3_controller/3_dashboard/dashboard_controller.dart';
import 'package:dailytimelog/3_controller/4_loghours/loghours_controller.dart';
import 'package:dailytimelog/3_controller/5_statistics/statistics_controller.dart';
import 'package:dailytimelog/3_controller/6_profile/profile_controller.dart';
import 'package:dailytimelog/3_controller/7_settings/settings_controller.dart';
import 'package:get/get.dart';

import '../2_view/1_splash/splash_view.dart';

class RouteName {
  static const String splashView = "/SplashView";
  static const String onboardingView = "/OnboardingView";
  static const String dashboardView = "/DashboardView";
  static const String loghoursView = "/LoghoursView";
  static const String statisticsView = "/StatisticsView";
  static const String profileView = "/ProfileView";
  static const String settingsView = "/SettingsView";

}


abstract class Routes {
  static final routes = [
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
        name: RouteName.dashboardView,
        page: () => const DashboardView(),
        binding: BindingsBuilder(() {
          Get.put(DashboardController());
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