import 'package:flutter/material.dart';

import '../4_utils/color.dart';

class CustomTextfield extends StatelessWidget {
  final String placeholder;
  final TextInputType inputType;
  final Color borderColor;
  final Color errorBorderColor;
  final TextEditingController controller;
  final maxLength;
  final Function onChangeCallback;
  final bool isEnabled;
  static const double fontSize = 17.0;

  const CustomTextfield({
    super.key,
    required this.placeholder,
    required this.controller,
    required this.onChangeCallback,
    this.inputType = TextInputType.text,
    this.borderColor = appPrimaryColor,
    this.errorBorderColor = Colors.red,
    this.maxLength=100,
    this.isEnabled=true
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      child: TextField(
        controller: controller,
        enabled: isEnabled,
        keyboardType: inputType,
        style: const TextStyle(
          fontSize: fontSize,
          color: Colors.black, // You can customize the text color as well
        ),
        decoration: InputDecoration(
          hintText: placeholder,
          disabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0), // Set the border radius
            borderSide: BorderSide(
              color: borderColor, // Custom border color
              width: 2.0, // Border width
            ),
          ),
          hintStyle: TextStyle(color: Colors.grey[500]), // Custom hint text color
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0), // Set the border radius
            borderSide: BorderSide(
              color: borderColor, // Custom border color
              width: 2.0, // Border width
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
            borderSide: BorderSide(
              color: borderColor, // Focused border color
              width: 2.0,
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
            borderSide: BorderSide(
              color: borderColor, // Enabled border color
              width: 2.0,
            ),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
            borderSide: BorderSide(
              color: errorBorderColor, // Error border color
              width: 2.0,
            ),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
            borderSide: BorderSide(
              color: errorBorderColor, // Focused error border color
              width: 2.0,
            ),
          ),
          contentPadding: const EdgeInsets.symmetric(horizontal: 12,),
        ),
        onChanged: (val) {
            onChangeCallback(val);
          },
      ),
    );
  }
}