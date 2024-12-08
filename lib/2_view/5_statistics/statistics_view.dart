import 'package:dailytimelog/3_controller/5_statistics/statistics_controller.dart';
import 'package:dailytimelog/4_utils/color.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import '../../4_utils/theme.dart';
import '../../5_components/custom_button.dart';
import '../../5_components/custom_spacers.dart';
import '../../5_components/custom_textfield.dart';

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
            child: Column(
              children: [
                const VSpaceWith(height: 10),
                GetBuilder(
                    init: controller,
                    id: 'graph_type_item',
                    builder: (_) {
                      return
                        Column(
                          children: [
                            SizedBox(
                              width:double.infinity,
                              child: CupertinoSegmentedControl(
                                padding: EdgeInsets.zero,
                                children: const <int, Widget>{
                                  0: Padding(
                                      padding:  EdgeInsets.zero,
                                      child: Text('Weekly',
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            fontSize: 19,
                                            fontFamily: 'Odin Rounded',
                                            fontWeight: FontWeight.w600,
                                          ))),
                                  1: Padding(
                                      padding: EdgeInsets.all(7.0),
                                      child: Text('Monthly',
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            fontSize: 19,
                                            fontFamily: 'Odin Rounded',
                                            fontWeight: FontWeight.w600,
                                          ))),
                                  2: Padding(
                                      padding: EdgeInsets.all(7.0),
                                      child: Text('Yearly',
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            fontSize: 19,
                                            fontFamily: 'Odin Rounded',
                                            fontWeight: FontWeight.w600,
                                          ))),
                                  3: Padding(
                                      padding: EdgeInsets.all(7.0),
                                      child: Text('Custom',
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            fontSize: 19,
                                            fontFamily: 'Odin Rounded',
                                            fontWeight: FontWeight.w600,
                                          ))),
                                },
                                onValueChanged: (value) {
                                  if(value==3 && controller.purchaseStatus.value==0){
                                    controller.refreshPage();
                                    controller.showPurchaseDialog();
                                  }else{
                                    controller.updateType(value);
                                  }
                                },
                                selectedColor: appPrimaryColor,
                                unselectedColor: CupertinoColors.systemGrey5,
                                borderColor: appPrimaryColor,
                                pressedColor: appPrimaryColor,
                                groupValue: controller.selectedTypePosition,
                              ),
                            ),
                            const VSpaceWith(height: 10),
                            Visibility(
                              visible: controller.selectedTypePosition == 3? true: false,
                              child: const VSpaceWith(height: 10),
                            ),
                            Visibility(
                              visible: controller.selectedTypePosition == 3? true: false,
                              child: Row(
                                children: [
                                  SizedBox(
                                    width: (MediaQuery.of(context).size.width-150)/2,
                                    child: GestureDetector(
                                      onTap: () {
                                        controller.showDatePicker(controller.startDateController);
                                      },
                                      child: Theme(
                                          data: ThemeData(disabledColor: Colors.blue, ),
                                          child: CustomTextfield(
                                            placeholder: 'Select Date',
                                            controller: controller.startDateController,
                                            onChangeCallback: controller.onChangeHoursCallback, isEnabled: false,)),
                                    ),
                                  ),
                                  const Padding(
                                    padding: EdgeInsets.only(left: 5, right: 5),
                                    child: SizedBox(
                                      width: 15,
                                      child: Divider(
                                        height: 2,
                                        color: appPrimaryColor,
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: (MediaQuery.of(context).size.width-150)/2,
                                    child: GestureDetector(
                                      onTap: () {
                                        controller.showDatePicker(controller.endDateController);
                                      },
                                      child: Theme(
                                          data: ThemeData(disabledColor: Colors.blue, ),
                                          child: CustomTextfield(
                                            placeholder: 'Select Date',
                                            controller: controller.endDateController,
                                            onChangeCallback: controller.onChangeHoursCallback, isEnabled: false,)),
                                    ),
                                  ),
                                  const SizedBox(width: 5),
                                  Expanded(
                                    child: CustomButton(
                                        title: 'Filter',
                                        onPressed: () {
                                          controller.showDataWithCustomRange();
                                        }),
                                  )
                                ],
                              ),
                            ),
                          ],
                        );

                    }),
                const VSpaceWith(height: 10),
                Expanded(child: graphSection()),

              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget graphSection() {
    return
      GetBuilder(
        init: controller,
        id: 'graph_item',
        builder: (_)
    {
      return
        SingleChildScrollView(
          child: Column(
            children: [
              Row(
                children: [
                  Visibility(visible: controller.selectedTypePosition==3? false: true, child: IconButton(onPressed: (){
                    controller.newGraph(-1);
                  }, icon: Icon(Icons.arrow_back_ios))),
                  Expanded(child: Container()),
                  Text(
                    controller.graphTitle,
                    style: TextStyle(color: Colors.black, fontSize: 15),
                  ),
                  Expanded(child: Container()),
                  Visibility(visible: controller.selectedTypePosition==3? false: true, child: IconButton(onPressed: (){
                    controller.newGraph(1);
                  }, icon: Icon(Icons.arrow_forward_ios))),
                ],
              ),
              SizedBox(
                //height: 300,
                child: SfCartesianChart(
                  zoomPanBehavior: ZoomPanBehavior(enableDoubleTapZooming: true, enablePanning: true),
                  plotAreaBorderWidth: 0,
                  primaryXAxis: const CategoryAxis(
                      majorGridLines: MajorGridLines(width: 0),
                      labelIntersectAction: AxisLabelIntersectAction.wrap,
                      crossesAt: 0, //_crossAt,
                      placeLabelsNearAxisLine: false,
                      //labelRotation: 10,
                  ),
                  primaryYAxis: NumericAxis(
                      axisLine: AxisLine(width: 0),
                      minimum: 0,
                      maximum: controller.maxValueOfBarchart,
                      majorTickLines: MajorTickLines(size: 0)),
                  series: controller.getSeries(),
                  tooltipBehavior: TooltipBehavior(
                      enable: true, header: '', canShowMarker: false),
                ),
              ),
              const VSpaceWith(height: 20),
              SfCircularChart(
                legend: const Legend(
                    isVisible: true,
                    overflowMode: LegendItemOverflowMode.wrap
                ),
                series: controller.getDefaultDoughnutSeries(),
                tooltipBehavior: TooltipBehavior(
                    enable: true, format: 'point.x : point.y%'),
              ),
            ],
          ),
        );
    });
  }


}