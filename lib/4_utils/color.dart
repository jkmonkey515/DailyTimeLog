import 'dart:math';
import 'dart:ui';
import 'package:flutter/material.dart';

const appPrimaryColor = Color.fromRGBO(61, 146, 139, 1);
const appGray       = Color.fromRGBO(148, 148, 148, 1);

const colorLightBlue = Color(0xFFBAEEE7);
const colorGreen     = Color(0xFFBFD6BF);
const colorPink      = Color(0xFFF7E6F6);
const colorCream     = Color(0xFFFAF8F2);
const colorDarkBlue  = Color(0xFF4D6596);

const colorBackground  = Color(0xFFCFE3CF);

Color generateRandomColor() {
  Random random = Random();

  // Generate random values for red, green, blue, and alpha (opacity)
  int red = random.nextInt(256);    // Random value between 0 and 255
  int green = random.nextInt(256);  // Random value between 0 and 255
  int blue = random.nextInt(256);   // Random value between 0 and 255
  int alpha = 255;                  // Full opacity (you can adjust this if you want transparency)

  return Color.fromARGB(alpha, red, green, blue);
}

String generateRandomHexColor() {
  final Random random = Random();

  // Generate a random hue (0 to 360 degrees)
  double hue = random.nextDouble() * 360;

  // Pastel colors have high value (brightness) and moderate saturation
  double saturation = 0.5 + random.nextDouble() * 0.3; // Range: 0.5 to 0.8
  double value = 0.8 + random.nextDouble() * 0.2; // Range: 0.8 to 1.0

  // Convert HSV to RGB
  int rgb = HSVColor.fromAHSV(1.0, hue, saturation, value).toColor().value;

  // Convert RGB to hex string and return
  return '#${rgb.toRadixString(16).padLeft(8, '0').substring(2)}';
}

Color hexToColor(String hexString) {
  // Add the # prefix if missing
  if (!hexString.startsWith('#')) {
    hexString = '#$hexString';
  }

  // Parse the color
  return Color(int.parse(hexString.replaceFirst('#', '0xff')));
}