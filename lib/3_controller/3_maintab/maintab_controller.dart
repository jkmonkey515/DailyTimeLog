import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class MainTabController extends GetxController with GetSingleTickerProviderStateMixin {
  final cache = GetStorage();
  late TabController tabController;

  int currentPageIndex = 0;
  var currentPageObs = 0.obs;

  @override
  void onInit() {
    super.onInit();

    initView();
  }

  initView() {
    tabController = TabController(vsync: this, length: 3, initialIndex: 0);
    tabController.addListener(() {
      currentPageObs.value = tabController.index;
      currentPageIndex = tabController.index;

      update(['mainTab'].toList(),true);
    });
  }
  doChangeTab(int pos){
    currentPageIndex = pos;
    tabController.index = pos;
    tabController.animateTo(pos);
    currentPageObs.value = pos;

    update(['mainTab'].toList(),true);
  }

}