import 'dart:io';

import 'package:csv/csv.dart';
import 'package:dailytimelog/6_models/category_model.dart';
import 'package:dailytimelog/6_models/log_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:syncfusion_flutter_pdf/pdf.dart';
import '../../4_utils/constats.dart';
import '../../4_utils/database_helper.dart';
import '../../4_utils/route.dart';
import '../../5_components/custom_button.dart';
import '../../5_components/custom_spacers.dart';


class SettingsController extends GetxController {
  final cache = GetStorage();
  var dbHelper = DatabaseHelper.instance;
  TextEditingController txtPassword = TextEditingController();
  var isPasswordVisible = false.obs;

  TextEditingController txtNewPassword = TextEditingController();
  var isNewPasswordVisible = false.obs;

  @override
  void onInit() {
    super.onInit();

  }

  void updatePasswordVisible() {
    isPasswordVisible.value = !isPasswordVisible.value;
  }

  void updateConfirmVisible() {
    isNewPasswordVisible.value = !isNewPasswordVisible.value;
  }

  doChangePassword() {

  }

  gotoNextView(String menuTitle) {
    if(menuTitle.contains('Export')) {
      showExportOption();
    }
    if(menuTitle.contains('Password')) {
      Get.toNamed(RouteName.changePasswordView);
    }

    if(menuTitle.contains('Profile')) {
      Get.toNamed(RouteName.profileView);
    }
  }

  showExportOption(){
    showModalBottomSheet(
      context: Get.context!,
      isScrollControlled: false,
      builder: (BuildContext context) {
        return Padding(
          padding: EdgeInsets.all(20),
          child: SizedBox(
            height:  250,
            child: Column(
              children: [
                const SizedBox(height: 20,),
                const Text("Select Export Option",style: TextStyle(fontWeight: FontWeight.bold), ),
                const SizedBox(height: 30,),
                CustomButton(
                    title: 'Export CSV',
                    onPressed: () {
                      Constants.dismissDialog();
                      exportCSV();
                    }),
                const VSpaceWith(height: 30),
                CustomButton(
                    title: 'Export PDF',
                    onPressed: () {
                      Constants.dismissDialog();
                      exportPdf();
                    }),
              ],
            ),
          ),
        );
      });

  }
  exportCSV() async{
    List<LogModel> logs = await dbHelper.getAllLogs();
    List<CategoryModel> categories = await dbHelper.getCategories();
    List<List<String>> data = [];
    List<String> oneRow = ["Date", "Category", "Hours"];
    data.add(oneRow);
    for(var i=0; i<logs.length; i++){
      String categoryName = "";
      for(var j=0; j<categories.length; j++){
        if(logs[i].category_id==categories[j].category_id.toString()){
          categoryName = categories[j].category_name;
        }
      }
      List<String> oneRow = [logs[i].log_date, categoryName, logs[i].log_hour];
      data.add(oneRow);
    }
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, "logdata.csv");
    String csv = const ListToCsvConverter().convert(data);
    File file = File(path);
    await file.writeAsString(csv,mode:FileMode.write);
    onShare(file.path, "Log csv");
  }
  exportPdf() async {
    final PdfDocument document = PdfDocument();
    // Add a new page to the document.
    final PdfPage page = document.pages.add();
    // Create a PDF grid class to add tables.
    final PdfGrid grid = PdfGrid();
    // Specify the grid column count.
    grid.columns.add(count: 3);
    // Add a grid header row.
    final PdfGridRow headerRow = grid.headers.add(1)[0];
    headerRow.cells[0].value = 'Date';
    headerRow.cells[1].value = 'Category';
    headerRow.cells[2].value = 'Hours';
    // Set header font.
    headerRow.style.font =
        PdfStandardFont(PdfFontFamily.helvetica, 10, style: PdfFontStyle.bold);
    List<LogModel> logs = await dbHelper.getAllLogs();
    List<CategoryModel> categories = await dbHelper.getCategories();
    List<List<String>> data = [];
    List<String> oneRow = ["Date", "Category", "Hours"];
    data.add(oneRow);
    for(var i=0; i<logs.length; i++){
      String categoryName = "";
      for(var j=0; j<categories.length; j++){
        if(logs[i].category_id==categories[j].category_id.toString()){
          categoryName = categories[j].category_name;
        }
      }
      PdfGridRow row = grid.rows.add();
      row.cells[0].value = logs[i].log_date;
      row.cells[1].value = categoryName;
      row.cells[2].value = logs[i].log_hour;
    }
    // Set grid format.
    grid.style.cellPadding = PdfPaddings(left: 5, top: 5);
    // Draw table in the PDF page.
    grid.draw(
        page: page,
        bounds: Rect.fromLTWH(
            0, 0, page.getClientSize().width, page.getClientSize().height));
    // Save the document.
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, "logdata.pdf");
    File(path).writeAsBytes(await document.save());
    // Dispose the document.
    document.dispose();
    onShare(path, "Log pdf");
  }

  Future<void> onShare(String filepath, String title) async {
    //ShareExtend.share(filepath, "job zip file");
    final result = await Share.shareXFiles([XFile(filepath)], text: title);

    if (result.status == ShareResultStatus.success) {
      print('Thank you for sharing the picture!');
    }
  }
}