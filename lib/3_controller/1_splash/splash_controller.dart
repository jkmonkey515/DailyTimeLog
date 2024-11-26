import 'package:dailytimelog/6_models/category_model.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import '../../4_utils/constats.dart';
import '../../4_utils/database_helper.dart';
import '../../4_utils/route.dart';


class SplashController extends GetxController {
  final cache = GetStorage();
  var dbHelper = DatabaseHelper.instance;
  @override
  void onInit() {
    super.onInit();
    initData();
  }

  gotoNextView() {
    Get.offNamed(RouteName.onboardingView);
  }

  void initData() async{
    List<CategoryModel> categoryModel = await dbHelper.getCategories();
    if(categoryModel.isEmpty){
      CategoryModel categoryModel = CategoryModel(
          category_id: -1,
          category_name: "Collage days",
          is_default: 1,
          is_active: 1,
          created_at: Constants.getCurrentDateTime(),
          updated_at: Constants.getCurrentDateTime());
      dbHelper.saveCategory(categoryModel);
      CategoryModel categoryModel1 = CategoryModel(
          category_id: -1,
          category_name: "Skills practice",
          is_default: 1,
          is_active: 1,
          created_at: Constants.getCurrentDateTime(),
          updated_at: Constants.getCurrentDateTime());
      dbHelper.saveCategory(categoryModel1);
      CategoryModel categoryModel2 = CategoryModel(
          category_id: -1,
          category_name: "Therapy",
          is_default: 1,
          is_active: 1,
          created_at: Constants.getCurrentDateTime(),
          updated_at: Constants.getCurrentDateTime());
      dbHelper.saveCategory(categoryModel2);
      CategoryModel categoryModel3 = CategoryModel(
          category_id: -1,
          category_name: "Placement",
          is_default: 1,
          is_active: 1,
          created_at: Constants.getCurrentDateTime(),
          updated_at: Constants.getCurrentDateTime());
      dbHelper.saveCategory(categoryModel3);
    }
    Future.delayed(const Duration(seconds: 1), () {
      gotoNextView();
    });
  }
}