import 'package:animated_segmented_tab_control/animated_segmented_tab_control.dart';
import 'package:dailytimelog/3_controller/2_onboarding/onboarding_controller.dart';
import 'package:dailytimelog/3_controller/5_statistics/statistics_controller.dart';
import 'package:dailytimelog/4_utils/color.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';

import '../../4_utils/theme.dart';
import '../../5_components/custom_spacers.dart';

class StatisticsView extends GetView<StatisticsController> {
  const StatisticsView({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        backgroundColor: colorBackground,
        appBar: AppBar(
          title: Text(
            'Statistics',
            textAlign: TextAlign.center,
            style: textStyleNavigationTitle(),
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
                const VSpaceWith(height: 20),
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
        Text(
          'weekly data here',
          style: textStyleDefault(),
        ),

        Image.asset('assets/barchart.png', height: 200, fit: BoxFit.fitHeight,),

        const VSpaceWith(height: 20),

        Image.asset('assets/piechart.jpg'),
      ],
    );
  }
  Widget monthlyView() {
    return Column(
      children: [
         Text(
          'monthly data here',
           style: textStyleDefault(),
        ),

        Image.asset('assets/barchart.png'),

        const VSpaceWith(height: 20),

        Image.asset('assets/piechart.jpg'),
      ],
    );
  }
  Widget yearlyView() {
    return Column(
      children: [
        Text(
          'yearly data here',
          style: textStyleDefault(),
        ),

        Image.asset('assets/barchart.png'),

        const VSpaceWith(height: 20),

        Image.asset('assets/piechart.jpg'),
      ],
    );
  }

}