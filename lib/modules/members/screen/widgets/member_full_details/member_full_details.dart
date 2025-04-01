import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:opticore/opticore.dart';

import '../../../../../core/functions/my_functions.dart';
import '../../../../../network/member_model.dart';

class MemberFullDetails extends StatelessWidget {
  MemberFullDetails({super.key, required this.member});

  Member member;
  bool isActive = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: Text(
                  textAlign: TextAlign.center,
                  member.name,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 30.sp,
                  ),
                ),
              ),
              Icon(Icons.edit),
            ],
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
            "Phone number:  0${member.phoneNumber}",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 23.sp),
          ),
          SizedBox(height: 10.h),
          Visibility(
            visible: member.extraNotes!.isNotEmpty ? true : false,
            child: Text(
              "Extra Notes:  ${member.extraNotes}",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15.sp),
            ),
          ),
          SizedBox(height: member.extraNotes!.isNotEmpty ? 10.h : 0),
          Text("Subscriptions history: "),
          SizedBox(height: 5.h),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children:
                member.subscriptions.map((subscription) {
                  isActive = false;
                  if (subscription.endDate.isAfter(DateTime.now())) {
                    isActive = true;
                  }
                  return Container(
                    margin: EdgeInsets.all(5.h),
                    padding: EdgeInsets.all(10.w),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20.r),
                      border: Border.all(
                        width: 2.r,
                        color: isActive ? Colors.green : Colors.red,
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Class: ${subscription.sport?.displayName}",
                                  style: TextStyle().copyWith(
                                    color:
                                        !isActive
                                            ? context
                                                .colorScheme
                                                .secondaryContainer
                                            : null,
                                  ),
                                ),
                                Text(
                                  "Start date: ${MyFunctions.dateTimeToString(subscription.subscriptionDate)}",
                                  style: TextStyle().copyWith(
                                    color:
                                        !isActive
                                            ? context
                                                .colorScheme
                                                .secondaryContainer
                                            : null,
                                  ),
                                ),
                                Text(
                                  "End date: ${MyFunctions.dateTimeToString(subscription.endDate)}",
                                  style: TextStyle().copyWith(
                                    color:
                                        !isActive
                                            ? context
                                                .colorScheme
                                                .secondaryContainer
                                            : null,
                                  ),
                                ),
                                Text(
                                  "Paid Amount: ${subscription.paidAmount}",
                                  style: TextStyle().copyWith(
                                    color:
                                        !isActive
                                            ? context
                                                .colorScheme
                                                .secondaryContainer
                                            : null,
                                  ),
                                ),
                                Text(
                                  "Due Amount:  ${subscription.dueAmount}",
                                  style: TextStyle().copyWith(
                                    color:
                                        !isActive
                                            ? context
                                                .colorScheme
                                                .secondaryContainer
                                            : null,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(width: 20.w),
                            Column(
                              children: [
                                Text(
                                  "Cancel",
                                  style: TextStyle(
                                    color:
                                        !isActive
                                            ? context
                                                .colorScheme
                                                .secondaryContainer
                                            : Colors.red,
                                    fontFamily: "Anton_SC",
                                  ),
                                ),
                              ],
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
          CoreButton(title: "Delete Member"),
        ],
      ),
    );
  }
}
