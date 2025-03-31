import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:opticore/opticore.dart';

import '../../../../core/functions/my_functions.dart';
import '../../../../network/member_model.dart';

class MemberFullDetails extends StatelessWidget {
  MemberFullDetails({super.key, required this.member});

  Member member;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Text(
              "${member.firstName} ${member.lastName}",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25.sp),
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
          SizedBox(height: 10.h),
          Text(
            "Phone number: 0${member.phoneNumber}",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.sp),
          ),
          SizedBox(height: 10.h),
          Text("Subscriptions:"),
          SizedBox(height: 5.h),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children:
                member.subscriptions.map((subscription) {
                  return Container(
                    margin: EdgeInsets.all(5.h),
                    padding: EdgeInsets.all(10.w),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20.r),
                      border: Border.all(
                        width: 2.r,
                        color: context.colorScheme.secondaryContainer,
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Class: ${subscription.sport?.displayName}",
                                ),
                                Text(
                                  "Start date: ${MyFunctions.dateTimeToString(subscription.subscriptionDate)}",
                                ),
                                Text(
                                  "End date: ${MyFunctions.dateTimeToString(subscription.endDate)}",
                                ),
                                Text("Paid Amount: ${subscription.paidAmount}"),
                                Text("Due Amount:  ${subscription.dueAmount}"),
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
                        SizedBox(height: 5.h),
                      ],
                    ),
                  );
                }).toList(),
          ),
          SizedBox(height: 5.h),
          CoreButton(title: "Deactivate Member"),
        ],
      ),
    );
  }
}
