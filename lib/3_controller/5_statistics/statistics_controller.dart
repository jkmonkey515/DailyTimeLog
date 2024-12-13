import 'dart:math';
import 'dart:ui';
import 'package:dailytimelog/6_models/category_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import '../../4_utils/chat_sample.dart';
import 'package:flutter_datetime_picker_plus/flutter_datetime_picker_plus.dart'
as picker;

import '../../4_utils/color.dart';
import '../../4_utils/constats.dart';
import '../../4_utils/database_helper.dart';
import '../../4_utils/route.dart';

class StatisticsController extends GetxController {
  final cache = GetStorage();
  TextEditingController startDateController = TextEditingController();
  TextEditingController endDateController = TextEditingController();
  int selectedTypePosition = 0;
  var dbHelper = DatabaseHelper.instance;
  List<ChartSampleData> barChartItems = [];
  List<ChartSampleData> pieChartItems = [];
  double maxValueOfBarchart=50;
  var purchaseStatus = 0.obs;
  String graphTitle="";
  int currentFilterIndex = 0;
  @override
  void onInit() {
    super.onInit();
    var date = DateTime.now();
    var prevMonth =  DateTime(date.year, date.month - 1, date.day);
    startDateController.text =Constants.getFormatedDate(prevMonth);
    endDateController.text =Constants.getFormatedDate(date);
    var isProUser = cache.read("ispurchase")??0;
    updatePurchaseStatus(isProUser);
    initData();
  }
  void updatePurchaseStatus(int isProUser) {
    purchaseStatus.value = isProUser;
  }

  List<CartesianSeries<ChartSampleData, String>> getSeries() {
    return <CartesianSeries<ChartSampleData, String>>[
      ColumnSeries<ChartSampleData, String>(
           dataSource: barChartItems,
          xValueMapper: (ChartSampleData sales, _) => sales.x as String,
          yValueMapper: (ChartSampleData sales, _) => sales.y,
          pointColorMapper: (ChartSampleData sales, _) => sales.pointColor,
          dataLabelSettings: const DataLabelSettings(
              isVisible: true, labelAlignment: ChartDataLabelAlignment.middle)),
    ];
  }

  List<DoughnutSeries<ChartSampleData, String>> getDefaultDoughnutSeries() {
    return <DoughnutSeries<ChartSampleData, String>>[
      DoughnutSeries<ChartSampleData, String>(
          explode: true,
          dataSource: pieChartItems,
          xValueMapper: (ChartSampleData data, _) => data.x as String,
          yValueMapper: (ChartSampleData data, _) => data.y,
          dataLabelMapper: (ChartSampleData data, _) => data.text,
          pointColorMapper: (ChartSampleData sales, _) => sales.pointColor,
          dataLabelSettings: const DataLabelSettings(isVisible: true))
    ];
  }

  showDatePicker(TextEditingController itemController){
    picker.DatePicker.showDatePicker(Get.context!,
        showTitleActions: true,
        minTime: DateTime(2022, 3, 5),
        maxTime: DateTime(2030, 12, 31),
        theme: const picker.DatePickerTheme(
            headerColor: Colors.blue,
            backgroundColor: Colors.lightBlue,
            itemStyle: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 18),
            doneStyle:
            TextStyle(color: Colors.white, fontSize: 16)),
        onChanged: (date) {
          // print('change $date in time zone ${date.timeZoneOffset.inHours}');
        }, onConfirm: (date) {
          //print('confirm $date');
          itemController.text = Constants.getFormatedDate(date);
        }, currentTime: DateTime.now(), locale: picker.LocaleType.en);
  }

  onChangeHoursCallback() {
  }

  void updateType(int value) {
    currentFilterIndex = 0;
    selectedTypePosition = value;
    refreshPage();
  }
  void refreshPage() {
    update(['graph_type_item'], true);
    initData();
  }

  Color generateRandomColor() {
    Random random = Random();

    // Generate random values for red, green, blue, and alpha (opacity)
    int red = random.nextInt(256);    // Random value between 0 and 255
    int green = random.nextInt(256);  // Random value between 0 and 255
    int blue = random.nextInt(256);   // Random value between 0 and 255
    int alpha = 255;                  // Full opacity (you can adjust this if you want transparency)

    return Color.fromARGB(alpha, red, green, blue);
  }

  List<List<DateTime>> getWeeksBetweenDates(DateTime startDate, DateTime endDate, {int startOfWeek = 1}) {
    List<List<DateTime>> weeks = [];

    // Adjust start date to the start of the week
    int daysToAdjust = (startDate.weekday - startOfWeek) % 7;
    DateTime adjustedStartDate = startDate.subtract(Duration(days: daysToAdjust));

    DateTime currentWeekStart = adjustedStartDate;
    while (currentWeekStart.isBefore(endDate) || currentWeekStart.isAtSameMomentAs(endDate)) {
      List<DateTime> week = [];
      DateTime currentDay = currentWeekStart;

      // Add all days of the current week (7 days) to the list
      for (int i = 0; i < 7; i++) {
        if (currentDay.isBefore(endDate) || currentDay.isAtSameMomentAs(endDate)) {
          week.add(currentDay);
        }
        currentDay = currentDay.add(Duration(days: 1));
      }

      weeks.add(week);
      currentWeekStart = currentWeekStart.add(Duration(days: 7)); // Move to next week
    }

    return weeks;
  }

  List<String> getMonthsBetweenDates(DateTime startDate, DateTime endDate) {
    List<String> months = [];
    DateTime tempDate = startDate;

    // Iterate through the months
    while (tempDate.isBefore(endDate) || tempDate.month == endDate.month) {
      // Format the date to "yyyy-MM"
      String formattedMonth = DateFormat('yyyy-MM').format(tempDate);
      months.add(formattedMonth);

      // Increment the month
      tempDate = DateTime(tempDate.year, tempDate.month + 1, 1);
    }

    return months;
  }

  List<String> getYearsBetweenDates(DateTime startDate, DateTime endDate) {
    // Create a list to hold the years
    List<String> years = [];

    // Loop through the years from startDate to endDate
    int startYear = startDate.year;
    int endYear = endDate.year;

    for (int year = startYear; year <= endYear; year++) {
      // Add the year to the list as a string in 'yyyy' format
      years.add(year.toString());
    }

    return years;
  }

  initData() async {
    graphTitle="";
      barChartItems = [];
      pieChartItems = [];
      String query = "";
      if(selectedTypePosition==0){
        List<DateTime> dates = [];
        DateTime currentDate = DateTime.now();
        currentDate = currentDate.subtract(Duration(days:-1* currentFilterIndex*7));
        DateTime startOfWeek = currentDate.subtract(Duration(days: currentDate.weekday - 1)); //(assuming the week starts on Monday)
        String subQuery = "";
        var dateFormat = DateFormat('yyyy-MM-dd');
        for(var i=0; i>=-6; i--){
          DateTime oneDate = startOfWeek.subtract(Duration(days: i));
          dates.add(oneDate);
          if(subQuery.isNotEmpty) subQuery+=" OR ";
          subQuery+=" log_date ='${dateFormat.format(oneDate)}'";
          if(i==0 || i==-6){
            if(graphTitle.isNotEmpty){
              graphTitle+="~";
            }
            var dateFormat1 = DateFormat('dd/MM/yyyy');
            graphTitle+=dateFormat1.format(oneDate);
          }
        }
        subQuery=" WHERE $subQuery";
        query = "SELECT category_id, SUM(log_hour) AS total_hour FROM tb_logs$subQuery GROUP BY category_id";
      }else if(selectedTypePosition==1){
        DateTime now = DateTime.now();
        now =  DateTime(
            now.year,
            now.month +currentFilterIndex,
            now.day
        );
        String currentMonthDate = "${now.year}-${now.month}";
        String subQuery = " WHERE log_date LIKE '$currentMonthDate%'";
        query = "SELECT category_id, SUM(log_hour) AS total_hour FROM tb_logs$subQuery GROUP BY category_id";
        graphTitle = "${now.month}/${now.year}";
      }else if(selectedTypePosition==2){
        DateTime now = DateTime.now();
        String currentYear = (now.year+currentFilterIndex).toString();
        String subQuery = " WHERE log_date LIKE '$currentYear%'";
        query = "SELECT category_id, SUM(log_hour) AS total_hour FROM tb_logs$subQuery GROUP BY category_id";
        graphTitle = currentYear;
      }else if(selectedTypePosition==3){
        DateTime startDate = DateTime(int.parse(startDateController.text.split("/")[2]), int.parse(startDateController.text.split("/")[1]), int.parse(startDateController.text.split("/")[0])); // November 1, 2024
        DateTime endDate = DateTime(int.parse(endDateController.text.split("/")[2]), int.parse(endDateController.text.split("/")[1]), int.parse(endDateController.text.split("/")[0])); // November 1, 2024
        List<DateTime> dates = [];
        String subQuery = "";
        var dateFormat = DateFormat('yyyy-MM-dd');
        for (DateTime date = startDate;
        date.isBefore(endDate) || date.isAtSameMomentAs(endDate);
        date = date.add(const Duration(days: 1))) {
          dates.add(date);
          if(subQuery.isNotEmpty) subQuery+=" OR ";
          subQuery+=" log_date ='${dateFormat.format(date)}'";
        }
        subQuery=" WHERE $subQuery";
        query = "SELECT category_id, SUM(log_hour) AS total_hour FROM tb_logs$subQuery GROUP BY category_id";

        graphTitle= "${startDateController.text.replaceAll("-", "/")}~${endDateController.text.replaceAll("-", "/")}";
      }
      print(query);
      double totalHours = 0;
      maxValueOfBarchart = 0;
      List<Map<String, dynamic>> filteredMap = await dbHelper.filterStatistics(query);
      for(var oneItem in filteredMap){
        int categoryId = int.parse(oneItem["category_id"]);
        String categoryName = "";
        String categoryColor = "#000000";
        List<CategoryModel> categories = await dbHelper.getCategories(subQuery: " WHERE category_id=$categoryId");
        if(categories.isNotEmpty){
          categoryName = categories[0].category_name;
          categoryColor = categories[0].category_color;
        }
        ChartSampleData onePointData = ChartSampleData(
            x: categoryName,
            y: oneItem['total_hour'],
            pointColor: hexToColor(categoryColor)
        );
        totalHours+=oneItem['total_hour'];
        if(maxValueOfBarchart<oneItem['total_hour']) maxValueOfBarchart=double.parse(oneItem['total_hour'].toString());
        barChartItems.add(onePointData);
      }
      if(barChartItems.isNotEmpty){
        for (var oneItem in barChartItems) {
          double oneItmPercent = 0;
          if(totalHours > 0){
            oneItmPercent =((oneItem.y!/totalHours)*100 * 100).round() / 100 ;
          }
          ChartSampleData onePointData = ChartSampleData(
              x: oneItem.x,
              y: oneItmPercent,
              text: "$oneItmPercent%",
            pointColor: oneItem.pointColor
          );
          pieChartItems.add(onePointData);
        }
      }
      update(['graph_item'], true);
  }

  void showDataWithCustomRange() {
    if(purchaseStatus.value==1){
      initData();
    }else{
      showPurchaseDialog();
    }
  }

  void showPurchaseDialog() {
    showDialog(
        context: Get.context!,
        builder: (context) {
          return CupertinoAlertDialog(
            title: const Text("This is a pro feature"),
            actions: <Widget>[
              TextButton(
                  onPressed: () {
                    Constants.dismissDialog();
                    Get.toNamed(RouteName.profeaturesView);
                  },
                  child: const Text('Upgrade')),
              TextButton(
                onPressed: () {
                  Constants.dismissDialog();
                },
                child: const Text('Close'),
              )
            ],
          );
        });
  }

  void newGraph(int i) {
    currentFilterIndex+=i;
    initData();
  }
}