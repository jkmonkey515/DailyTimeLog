import 'package:flutter/material.dart';

class VSpaceWith extends StatelessWidget {
  final double height;

  const VSpaceWith({
    super.key,
    required this.height,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(height: height);
  }
}

class HSpaceWith extends StatelessWidget {
  final double width;

  const HSpaceWith({
    super.key,
    required this.width,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(width: width);
  }
}

class AppSpacer extends StatelessWidget {
  const AppSpacer({super.key});

  @override
  Widget build(BuildContext context) {
    return const Expanded(
      child: Text(
          ' '
      ),
    );
  }
}