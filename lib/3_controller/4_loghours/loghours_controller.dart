import 'package:dailytimelog/3_controller/5_statistics/statistics_controller.dart';
import 'package:dailytimelog/6_models/category_model.dart';
import 'package:dailytimelog/6_models/log_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../../4_utils/constats.dart';
import '../../4_utils/database_helper.dart';


class LoghoursController extends GetxController {
  final cache = GetStorage();
  var dbHelper = DatabaseHelper.instance;
  TextEditingController txtHours = TextEditingController();
  TextEditingController edtDate = TextEditingController();
  List<String> categories=[];
  List<CategoryModel> categoryModels=[];
  String selectedCategory = "";
  String enteredHours="";
  @override
  void onInit() {
    super.onInit();
    print("init");
    getCategories();
  }

  getCategories() async{
    categoryModels = await dbHelper.getCategories();
    categories=[];
    selectedCategory = "";
    categories.add("");
    for(var i=0; i<categoryModels.length; i++){
      if(categoryModels[i].is_active==1){
        categories.add(categoryModels[i].category_name);
      }
    }
    update(['category_item'], true);
  }

  onChangeHoursCallback(String value){
    print(value);
    enteredHours = value;
  }


  doSaveAction() async{
    if(edtDate.text.isEmpty){
      Constants.showInfoDialog("Please select a date","", yesText: "Close");
    }else{
      if(selectedCategory.isEmpty){
        Constants.showInfoDialog("Please select a category", "", yesText: "Close");
      }else{
        if(enteredHours.isEmpty){
          Constants.showInfoDialog("Please enter hour", "", yesText: "Close");
        }else{
          String date = getDbStyleDate(edtDate.text);
          int selectedType = -1;
          for(var i=0; i<categoryModels.length; i++){
            if(categoryModels[i].category_name==selectedCategory){
              selectedType = categoryModels[i].category_id;
            }
          }
          await dbHelper.saveLog(
              LogModel(
                  log_id: -1,
                  category_id: selectedType.toString(),
                  log_date: date,
                  log_hour: enteredHours.trim(),
                  created_at: Constants.getCurrentDateTime()
              )
          );
          edtDate.text="";
          selectedCategory="";
          txtHours.text="";
          update(['category_item'], true);

          bool isStatisticsController = Get.isRegistered<StatisticsController>();
          if(isStatisticsController){
            StatisticsController statisticsController = Get.find();
            statisticsController.initData();
          }

          Constants.showInfoDialog("Hours logged!", "", isShowYes: true, yesText: "Close");
        }
      }
    }
  }


  String getDbStyleDate(String datetime) {
    String datestring = "";
    List<String> dateValue = datetime.split("/");
    if(dateValue.length!=3){
      datestring = datetime;
    }else{
      datestring = dateValue[2]+"-"+dateValue[1]+"-"+dateValue[0];
    }
    return datestring;
  }

  void refreshItem() {
    update(['category_item'], true);
  }
}