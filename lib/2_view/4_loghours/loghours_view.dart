import 'package:dailytimelog/3_controller/4_loghours/loghours_controller.dart';
import 'package:dailytimelog/5_components/custom_button.dart';
import 'package:dailytimelog/5_components/custom_spacers.dart';
import 'package:dailytimelog/5_components/custom_textfield.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker_plus/flutter_datetime_picker_plus.dart'
as picker;
import '../../4_utils/color.dart';
import '../../4_utils/constats.dart';
import '../../4_utils/theme.dart';

class LoghoursView extends GetView<LoghoursController> {
  const LoghoursView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colorBackground,
      appBar: AppBar(
        title: Text(
          'Log Hours',
          textAlign: TextAlign.center,
          style: textStyleNavigationTitle(),
        ),
        scrolledUnderElevation: 0,
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body:  Container(
        padding: const EdgeInsets.only(left: 20, right: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const VSpaceWith(height: 20),
            Text(
              'Select Date:',
              style: textStyleDefault(),
            ),
            const VSpaceWith(height: 8),

            Container(
              margin: const EdgeInsets.only(bottom: 25),
              child: GestureDetector(
                onTap: () {
                  picker.DatePicker.showDatePicker(context,
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
                        controller.edtDate.text = Constants.getFormatedDate(date);
                      }, currentTime: DateTime.now(), locale: picker.LocaleType.en);
                },
                child: Theme(
                    data: ThemeData(disabledColor: Colors.blue, ),
                    child: CustomTextfield(
                        placeholder: 'Select Date',
                        controller: controller.edtDate,
                        onChangeCallback: controller.onChangeHoursCallback, isEnabled: false,)),
              ),
            ),


            Text(
              'Activity Type:',
              textAlign: TextAlign.center,
              style: textStyleDefault(),
            ),
            const VSpaceWith(height: 8),
            GetBuilder(
                init: controller,
                id: 'category_item',
                builder: (_)
                {
                  return
                    Container(
                      width: MediaQuery.of(context).size.width-40,
                      padding: const EdgeInsets.only(left: 10, ),
                      decoration: BoxDecoration(
                        border: const Border(
                          bottom: BorderSide(width: 1.5, color: appPrimaryColor),
                          top: BorderSide(width: 1.5, color: appPrimaryColor),
                          right: BorderSide(width: 1.5, color: appPrimaryColor),
                          left: BorderSide(width: 1.5, color: appPrimaryColor),
                        ),
                        borderRadius: BorderRadius.circular(10),
                        color: const Color.fromARGB(10, 0, 0, 0)
                      ),

                      child: Theme(
                        data: Theme.of(context).copyWith(
                            brightness: Brightness.light,
                          canvasColor: Colors.white,
                         // splashColor: Colors.transparent,    // <- Here
                          // highlightColor: Colors.transparent, // <- Here
                          // hoverColor: Colors.transparent,     // <- Here
                        ),

                        child : DropdownButton(
                          underline: const SizedBox(),
                          value: controller.selectedCategory,
                          icon: null,
                          items: controller.categories.map((String item) {
                            return DropdownMenuItem(
                              value: item,
                              child: item == controller.selectedCategory?
                              Container(
                                width: MediaQuery.of(context).size.width-80,
                                color: Colors.transparent,
                                child: Text(
                                  item,
                                  style: const TextStyle(color: Colors.black),
                                ),
                              ) : Text(item),
                            );
                          }).toList(),
                          onChanged: (String? newValue) {
                            controller.selectedCategory=newValue??"";
                            controller.refreshItem();
                          },
                        ),
                      ),
                    );
                }),


            const VSpaceWith(height: 20),
            Text(
              'Hours:',
              textAlign: TextAlign.center,
              style: textStyleDefault(),
            ),
            const VSpaceWith(height: 8),
            CustomTextfield(
                placeholder: 'Enter hours',
                controller: controller.txtHours,
                inputType: TextInputType.number,
                onChangeCallback: controller.onChangeHoursCallback),

            const Spacer(),
            CustomButton(
              title: "SAVE",
              onPressed: () {
                controller.doSaveAction();
              }
            ),

            const VSpaceWith(height: 30),
          ],
        ),
      ),
    );
  }

  Widget selectDateView() {
    return Text(
      'Select Date:',
      textAlign: TextAlign.center,
      style: textStyleDefault(),
    );
  }

  Widget activityTypeView() {
    return Text(
      'Activity Type',
      textAlign: TextAlign.center,
      style: textStyleDefault(),
    );
  }



}