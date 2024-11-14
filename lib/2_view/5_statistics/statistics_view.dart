import 'package:animated_segmented_tab_control/animated_segmented_tab_control.dart';
import 'package:dailytimelog/3_controller/2_onboarding/onboarding_controller.dart';
import 'package:dailytimelog/3_controller/5_statistics/statistics_controller.dart';
import 'package:dailytimelog/4_utils/color.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';

class StatisticsView extends GetView<StatisticsController> {
  const StatisticsView({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: const Text(
            'Statistics',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Color(0xFF171717),
              fontSize: 20,
              fontFamily: 'Quicksand',
              fontWeight: FontWeight.w700,
              height: 0,
            ),
          ),
          centerTitle: true,
          scrolledUnderElevation: 0,
          backgroundColor: Colors.white,
          elevation: 0,
        ),
        body:  SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Stack(
              children: [
                const SegmentedTabControl(
                  tabTextColor: Colors.white,
                  selectedTabTextColor:  Colors.black,
                  indicatorPadding: EdgeInsets.all(4),
                  squeezeIntensity: 2,
                  // tabPadding: const EdgeInsets.symmetric(horizontal: 8),
                  textStyle: TextStyle(
                    fontSize: 15,
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w500,
                  ),
                  selectedTextStyle: TextStyle(
                    fontSize: 15,
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w500,
                  ),
                  // Options for selection
                  // All specified values will override the [SegmentedTabControl] setting
                  tabs: [
                    SegmentTab(
                      label: 'Weekly',
                      color: Colors.white,
                      backgroundColor: appPrimaryColor,
                    ),
                    SegmentTab(
                      label: 'Monthly',
                      color: Colors.white,
                      backgroundColor: appPrimaryColor,
                    ),
                    SegmentTab(
                      label: 'Yearly',
                      color: Colors.white,
                      backgroundColor: appPrimaryColor,
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 70),
                  child: TabBarView(
                    physics: const BouncingScrollPhysics(),
                    children: [
                      weeklyView(),
                      monthlyView(),
                      yearlyView(),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget weeklyView() {
    return Column(
      children: [
        const Text(
          'weekly data here'
        ),
        
        Image.asset('assets/barchart.png')
      ],
    );
  }
  Widget monthlyView() {
    return Column(
      children: [
        const Text(
          'monthly data here'
        ),

        Image.asset('assets/piechart.jpg'),
      ],
    );
  }
  Widget yearlyView() {
    return Column(
      children: [
        const Text(
          'yearly data here'
        ),

        Image.asset('assets/barchart.png'),

        Image.asset('assets/piechart.jpg'),
      ],
    );
  }

}