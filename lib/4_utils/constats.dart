import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

class Constants{
  static String getCurrentDateTime(){
    String date = DateTime.now().year.toString()+"-"+DateTime.now().month.toString()+"-"+DateTime.now().day.toString();
    return date;
  }

  static void showInfoDialog(String title, String content, {bool isShowYes=true,  String yesText ="Yes"} ){
    showDialog(
        context: Get.context!,
        builder: (context) {
          return CupertinoAlertDialog(
            title: Text(title),
            content: Text(content,),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  dismissDialog();
                },
                child: Text(yesText,),
              )
            ],
          );
        });
  }

  static void dismissDialog(){
    Navigator.pop(Get.context!);
  }

  static String getFormatedDate(DateTime datetime) {
    String datestring = "";
    int dateValue = datetime.day;
    int monthvalue = datetime.month;
    if (dateValue < 10) {
      datestring = "0${datetime.day}/";
    } else {
      datestring = "${datetime.day}/";
    }

    if (monthvalue < 10) {
      datestring += "0${datetime.month}/";
    } else {
      datestring += "${datetime.month}/";
    }

    datestring += datetime.year.toString();

    return datestring;
  }

  static showToastMessage(String message){
    Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.black87,
        textColor: Colors.white,
        fontSize: 16.0
    );
  }
}