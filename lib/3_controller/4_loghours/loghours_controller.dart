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
      Constants.showInfoDialog("Causion", "Please select a date");
    }else{
      if(selectedCategory.isEmpty){
        Constants.showInfoDialog("Causion", "Please select a category");
      }else{
        if(enteredHours.isEmpty){
          Constants.showInfoDialog("Causion", "Please enter hour");
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
          Constants.showInfoDialog("Success", "Log data saved successfully");
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