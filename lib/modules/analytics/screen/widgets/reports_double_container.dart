import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:opticore/opticore.dart';

class ReportsDoubleContainers extends StatelessWidget {
  const ReportsDoubleContainers({
    super.key,
    required this.firstNumber,
    required this.firstText,
    required this.secondNumber,
    required this.secondText,
    required this.onFirstTapped,
    required this.onSecondTapped,
  });

  final int firstNumber;
  final int secondNumber;
  final String firstText;
  final String secondText;
  final Function() onFirstTapped;
  final Function() onSecondTapped;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 100.h,
      child: Row(
        children: [
          Expanded(
            child: GestureDetector(
              onTap: () {},
              child: Container(
                padding: EdgeInsets.all(10.w),
                margin: EdgeInsets.only(top: 10.h, right: 5.w),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20.r),
                  color: context.colorScheme.secondary,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Text(
                        firstNumber.toString(),
                        style: context.textTheme.titleLarge?.copyWith(
                          color: context.colorScheme.primary,
                        ),
                      ),
                    ),
                    Text(firstText, style: context.textTheme.bodySmall),
                  ],
                ),
              ),
            ),
          ),
          Expanded(
            child: GestureDetector(
              onTap: () {},
              child: Container(
                padding: EdgeInsets.all(10.w),
                margin: EdgeInsets.only(top: 10.h, left: 5.w),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20.r),
                  color: context.colorScheme.secondary,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Text(
                        secondNumber.toString(),
                        style: context.textTheme.titleLarge?.copyWith(
                          color: context.colorScheme.primary,
                        ),
                      ),
                    ),
                    Text(secondText, style: context.textTheme.bodySmall),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
