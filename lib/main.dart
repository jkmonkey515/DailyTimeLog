import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '2_view/1_splash/splash_view.dart';
import '3_controller/1_splash/splash_controller.dart';
import '4_utils/route.dart';

void main() async {
  await GetStorage.init();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State {
  final cache = GetStorage();
  @override
  void initState() {
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      locale: const Locale('en'),
      fallbackLocale: const Locale('en'),
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        // textTheme: GoogleFonts.latoTextTheme()//.nunitoTextTheme(),//.robotoTextTheme(),
      ),
      home: const SplashView(),
      initialRoute: '/',
      initialBinding: BindingsBuilder(() {
        Get.put(SplashController());
      }),
      getPages: Routes.routes,
      defaultTransition: Transition.rightToLeftWithFade,
    );
  }
}
