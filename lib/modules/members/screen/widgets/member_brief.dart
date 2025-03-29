import 'package:falcon_project/core/functions/my_functions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:opticore/opticore.dart';

import '../../../../network/member_model.dart';

class MemberBrief extends StatelessWidget {
  MemberBrief({super.key, required this.member});

  Member member;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: context.colorScheme.secondaryContainer,
        border: Border.all(color: context.colorScheme.secondary),
        borderRadius: BorderRadius.circular(20.r), // Rounded edges
        // boxShadow: [
        //   BoxShadow(color: Colors.black, blurRadius: 5, spreadRadius: 2),
        // ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: FittedBox(
              child: Text(
                "${member.firstName} ${member.lastName}",
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
            crossAxisAlignment: CrossAxisAlignment.start,
            children:
                member.subscriptions.map((subscription) {
                  return Column(
                    children: [
                      FittedBox(
                        child: Row(
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("${subscription.sport?.displayName}"),
                                Text(
                                  MyFunctions.dateTimeToString(
                                    subscription.endDate,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(width: 20.w),
                            subscription.endDate.isAfter(DateTime.now())
                                ? Icon(Icons.circle, color: Colors.green)
                                : Icon(
                                  Icons.circle_outlined,
                                  color: Colors.red,
                                ),
                          ],
                        ),
                      ),
                      SizedBox(height: 5.h),
                    ],
                  );
                }).toList(),
          ),
        ],
      ),
    );
    ();
  }
}
