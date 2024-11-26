import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
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
}