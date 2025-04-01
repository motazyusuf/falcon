import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:opticore/opticore.dart';

class CriticalActionDialogue extends StatelessWidget {
  CriticalActionDialogue(
      {super.key, required this.message, required this.onConfirmTapped});

  String message;
  Function() onConfirmTapped;
  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      child: Center(
        child: Container(
          height: 200.h,
          decoration: BoxDecoration(
            color: context.colorScheme.secondary,
            borderRadius: BorderRadius.circular(20.r),
          ),
          padding: EdgeInsets.all(20.w),
          child: Column(
            children: [
              Text("this action can not be undone $message",
                textAlign: TextAlign.center,),
              SizedBox(height: 20.h),
              CoreButton(
                  height: 30.h,
                  backgroundColor: context.colorScheme.secondaryContainer,
                  title: "Cancel", onTap: () => context.pop()),
              SizedBox(height: 10.h),
              CoreButton(
                height: 30.h,
                title: "Confirm",
                onTap: onConfirmTapped,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
