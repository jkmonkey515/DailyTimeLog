import 'package:dailytimelog/2_view/4_loghours/loghours_view.dart';
import 'package:dailytimelog/2_view/5_statistics/statistics_view.dart';
import 'package:dailytimelog/2_view/7_settings/settings_view.dart';
import 'package:dailytimelog/5_components/custom_spacers.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';

import '../../3_controller/3_maintab/maintab_controller.dart';

class MainTabView extends GetView<MainTabController> {
  const MainTabView({super.key});

  @override
  Widget build(BuildContext context) {
    Widget mainBodyView() {
      return TabBarView(
          physics: const NeverScrollableScrollPhysics(),
          controller: controller.tabController,
          children: const [
            LoghoursView(),
            StatisticsView(),
            SettingsView(),
          ]);
    }

    Widget bottomTabbar() {
      return GetBuilder(
        init: controller,
        id: 'mainTab',
        builder: (value) {
          return BottomNavigationBar(
            backgroundColor: Colors.black54,
            type: BottomNavigationBarType.fixed,
            items: const <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                  icon: Column(
                    children: [
                      Icon(Icons.add_circle),
                      SizedBox(height: 4)
                    ],
                  ),
                  activeIcon: Column(
                    children: [
                      Icon(Icons.add_circle),
                      VSpaceWith(height: 4)
                    ],
                  ),
                  label: 'Add Log'),
              BottomNavigationBarItem(
                  icon: Column(
                    children: [
                      Icon(Icons.view_timeline),
                      VSpaceWith(height: 4)
                    ],
                  ),
                  activeIcon: Column(
                    children: [
                      Icon(Icons.view_timeline),
                      VSpaceWith(height: 4)
                    ],
                  ),
                  label: 'Stats'),
              BottomNavigationBarItem(
                  icon: Column(
                    children: [
                      Icon(Icons.settings),
                      VSpaceWith(height: 4)
                    ],
                  ),
                  activeIcon: Column(
                    children: [
                      Icon(Icons.settings),
                      VSpaceWith(height: 4)
                    ],
                  ),
                  label: 'Settings'),
            ],
            selectedLabelStyle: const TextStyle(
              color: Color(0xFFFD7840),
              fontFamily: 'Quicksand',
              fontWeight: FontWeight.w700,
              height: 0,
            ),
            unselectedLabelStyle: const TextStyle(
              color: Color(0xFF59605F),
              fontFamily: 'Quicksand',
              fontWeight: FontWeight.w700,
              height: 0,
            ),
            selectedFontSize: 12,
            currentIndex: controller.currentPageIndex,
            selectedItemColor: Colors.white,
            unselectedItemColor: Colors.grey,
            onTap: (index) {
              controller.doChangeTab(index);
            },
          );
        },
      );
    }

    return
      Scaffold(
        body: mainBodyView(),
        bottomNavigationBar: bottomTabbar(),
      );
  }



}