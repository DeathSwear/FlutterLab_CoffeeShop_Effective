import 'package:flutter/material.dart';
import 'package:flutter_course/src/theme/app_colors.dart';

class AppButtonStyles {
  static ButtonStyle buttonStyle = ElevatedButton.styleFrom(
    elevation: 0,
    alignment: Alignment.center,
    backgroundColor: AppColors.mainColor,
    foregroundColor: Colors.white,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
    padding: EdgeInsets.zero,
  );

  static ButtonStyle unactiveButtonStyle = ElevatedButton.styleFrom(
    elevation: 10,
    alignment: Alignment.center,
    backgroundColor: AppColors.unactiveMainColor,
    foregroundColor: Colors.white,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
    padding: EdgeInsets.zero,
  );

  static ButtonStyle trashButtonStyle = TextButton.styleFrom(
    elevation: 0,
    alignment: Alignment.center,
    backgroundColor: Colors.transparent,
    foregroundColor: Colors.transparent,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
    padding: EdgeInsets.zero,
  );

  static ButtonStyle mapActionButtonStyle = TextButton.styleFrom(
    elevation: 0,
    alignment: Alignment.center,
    backgroundColor: Colors.white,
    foregroundColor: Colors.white,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
    padding: EdgeInsets.zero,
  );
}
