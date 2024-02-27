import 'package:flutter/material.dart';
import 'package:flutter_app/utils/app_colors.dart';
import 'package:flutter_app/utils/sizes.dart';

class TextWidgets {
  Text headingText(String title) {
    return Text(
      title,
      style: TextStyle(
        color: AppColors().white,
        fontSize: Sizes().t40,
        fontWeight: FontWeight.w800,
      ),
    );
  }
}
