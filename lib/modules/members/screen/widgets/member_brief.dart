import 'package:falcon_project/core/functions/my_functions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:opticore/opticore.dart';

import '../../../../network/member_model.dart';

class MemberBrief extends StatelessWidget {
  MemberBrief({super.key, required this.member, required this.onTap});

  Member member;
  Function() onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(16.w),
        decoration: BoxDecoration(
          color: context.colorScheme.secondaryContainer,
          border: Border.all(color: context.colorScheme.secondary),
          borderRadius: BorderRadius.circular(20.r), // Rounded edges
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: FittedBox(
                child: Text(
                  member.name,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            ),
            SizedBox(height: 1.h),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: AdvancedLine(
                direction: Axis.horizontal,
                line: SolidLine(),
                paintDef:
                    Paint()
                      ..color = context.colorScheme.primary
                      ..strokeWidth = 2.h,
              ),
            ),
            SizedBox(height: 5.h),
            Column(
              children: [
                Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "${member.subscriptions[0].sport?.displayName}",
                              style: TextStyle().copyWith(fontSize: 15.sp),
                            ),
                            Text(
                              MyFunctions.dateTimeToString(
                                member.subscriptions[0].endDate,
                              ),
                            ),
                          ],
                        ),
                        member.subscriptions[0].endDate.isAfter(DateTime.now())
                            ? Icon(Icons.circle, color: Colors.green)
                            : Icon(Icons.circle_outlined, color: Colors.red),
                      ],
                    ),
                    SizedBox(height: 5.h),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
