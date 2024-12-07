import 'package:dailytimelog/3_controller/4_loghours/loghours_controller.dart';
import 'package:dailytimelog/4_utils/color.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import '../../4_utils/constats.dart';
import '../../4_utils/database_helper.dart';
import '../../4_utils/route.dart';
import '../../4_utils/theme.dart';
import '../../6_models/category_model.dart';


class ProfileController extends GetxController {
  final cache = GetStorage();
  var dbHelper = DatabaseHelper.instance;
  List checkedValues = [];
  List<Widget> activityTypeWidgets = [];
  List<CategoryModel> categoryModel = [];
  var purchaseStatus = 0.obs;

  @override
  void onInit() {
    super.onInit();
    initData();
    checkedValues.add(false.obs);
  }
  void initData() async{
    purchaseStatus.value = cache.read('ispurchase')??0;
    categoryModel = await dbHelper.getCategories();
    checkedValues = [];
    activityTypeWidgets=[];
    for(var i=0; i<categoryModel.length; i++){
      checkedValues.add(categoryModel[i].is_active.obs);
      activityTypeWidgets.add(
          Row(
            children: [
              Obx(() =>
                  Checkbox(
                    value: checkedValues[i].value==1? true: false,
                    onChanged: (bool? newValue) {
                      updateCheckbox(i);
                    },
                  )
              ),
              Text(
                categoryModel[i].category_name,
                style: TextStyle(color: hexToColor(categoryModel[i].category_color)),
              ),
              const Spacer(),
              editIconButton(i, categoryModel[i]),
              //editButton(i)
            ],
          )
      );
    }
    update(['category_list'], true);
  }
  Widget editIconButton(int position, CategoryModel categoryModel) {
    return IconButton(
      icon: const Icon(Icons.edit_note),
      onPressed: () {
        if(purchaseStatus.value==1){
          categoryInfoDialog(categoryModel);
        }else{
          showPurchaseDialog();
        }
      },
    );
  }
  Widget editButton(int position) {
    return GestureDetector(
      onTap: () {
      },
      child: const Text(
        'Edit',
        style: TextStyle(
          color: Color(0xFF828282),
          fontSize: 15,
          fontFamily: 'Odin Rounded',
          fontWeight: FontWeight.w700,
          decoration: TextDecoration.underline,
          height: 0,
        ),
      ),
    );
  }
  gotoNextView() {
    // Get.offNamed(RouteName.onboardingView);
  }
  void updateCheckbox(int position) async{
    if(purchaseStatus.value==1){
      int newStatus = 0;
      if(checkedValues[position].value==1){
        newStatus = 0;
      }else{
        newStatus = 1;
      }
      checkedValues[position].value = newStatus;
      categoryModel[position].is_active = newStatus;
      await dbHelper.saveCategory(categoryModel[position]);

      bool isLogHoursController = Get.isRegistered<LoghoursController>();
      if(isLogHoursController){
        LoghoursController loghoursController = Get.find();
        await loghoursController.getCategories();
      }
    }else{
      showPurchaseDialog();
    }
  }
  gotoProfeatureView() {
    Get.toNamed(RouteName.profeaturesView);
  }

  TextEditingController categoryNameController = TextEditingController();
  void categoryInfoDialog(CategoryModel? categoryModel) {
    if(categoryModel==null && activityTypeWidgets.length>=8){
      Constants.showToastMessage("You can not add more than 8 activity types");
      return;
    }
    String title = "Add new Category";
    if(categoryModel!= null) title = "Edit Category";
    showDialog(
        context: Get.context!,
        builder: (context) {
          return CupertinoAlertDialog(
            title: Text(title),
            content: Column(
              children: [
                Card(
                  color: Colors.white10,
                  elevation: 0,
                  child: TextField(
                    textAlign: TextAlign.center,
                    keyboardType: TextInputType.number,
                    controller: categoryNameController,
                    cursorColor: Colors.blue,
                    decoration: const InputDecoration(
                      border: UnderlineInputBorder(),
                    ),
                  ),
                ),
                categoryModel!= null?
                TextButton(
                    onPressed: () {
                      int categoryId = -1;
                      if(categoryModel!=null) categoryId = categoryModel!.category_id;
                      deleteCategory(categoryId);
                      Constants.dismissDialog();
                    },
                    child: const Text('Delete category and all it\'s data',maxLines: 2,)): const SizedBox()
              ],
            ),
            actions: [
              TextButton(
                  onPressed: () {
                    Constants.dismissDialog();
                  },
                  child: const Text('Cancel')),
              TextButton(
                onPressed: () {
                  if(categoryNameController.text.isEmpty){
                    Constants.showInfoDialog("Causion!", "Category name can't be blank");
                  }else{
                    if(categoryModel == null){
                      categoryModel = CategoryModel(
                          category_id: -1,
                          category_name: categoryNameController.text,
                          category_color: generateRandomHexColor(),
                          is_default: 0,
                          is_active: 1,
                          created_at: Constants.getCurrentDateTime(),
                          updated_at: Constants.getCurrentDateTime()
                      );
                    }else{
                      categoryModel!.category_name = categoryNameController.text;
                      categoryModel!.updated_at = Constants.getCurrentDateTime();
                    }
                    saveCategory(categoryModel!);
                    Constants.dismissDialog();
                  }
                },
                child: const Text('Save'),
              )
            ],

          );
        });
    if(categoryModel==null){
      categoryNameController.text = "";
    }else{
      categoryNameController.text = categoryModel!.category_name;
    }
  }

  void saveCategory(CategoryModel categoryModel) async{
    await dbHelper.saveCategory(categoryModel);

    bool isLogHoursController = Get.isRegistered<LoghoursController>();
    if(isLogHoursController){
      LoghoursController loghoursController = Get.find();
      await loghoursController.getCategories();
    }
    initData();
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

  void deleteCategory(int categoryId) async{
    await dbHelper.deleteCategoryData(categoryId);
    await dbHelper.deleteCategoryRelatedLogs(categoryId);
    initData();
  }

}