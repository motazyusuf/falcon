import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:opticore/opticore.dart';

class MyFunctions {
  MyFunctions._();

  static DateTime extractDate(DateTime date) {
    return DateTime(date.year, date.month, date.day);
  }

  static CancelFunc showLoading() {
    return BotToast.showCustomLoading(
      toastBuilder: (cancelFunc) {
        return Center(
          child: Stack(
            alignment: Alignment.center,
            children: [
              Container(
                // Full-screen overlay
                width: double.infinity,
                height: double.infinity,
                color: Colors.black54,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    "assets/images/falcon_logo.png",
                    fit: BoxFit.cover,
                    height: 200.h,
                  ),
                  SizedBox(
                    width: 80.w,
                    child: LinearProgressIndicator(color: Colors.red),
                  ),
                  // Custom color
                ],
              ),
            ],
          ),
        );
      },
      backgroundColor: Colors.transparent, // Remove default overlay
      allowClick: false, // Prevent taps
    );
  }

  static String dateTimeToString(DateTime date) {
    return date.toString().substring(0, 10);
  }
}
