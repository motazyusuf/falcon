import 'package:easy_localization/easy_localization.dart';
import 'package:falcon_project/core/extensions/date_extensions.dart';
import 'package:falcon_project/widgets/red_line.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:opticore/opticore.dart';

import '../core/network/model/member_model.dart';

class MemberBrief extends StatelessWidget {
  MemberBrief({super.key, required this.member, required this.onTap});

  Member member;
  Function() onTap;
  Subscription? expiringSubscription;

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
            1.ph,
            RedLine(),
            5.ph,
            Column(
              children:
                  member.subscriptions.isNotEmpty
                      ? [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  expiringSubscription != null
                                      ? "${expiringSubscription?.sport?.localeKey.tr()}"
                                      : "${member.subscriptions[0].sport?.localeKey.tr()}",
                                  style: TextStyle().copyWith(fontSize: 15.sp),
                                ),
                                Text(
                                  expiringSubscription != null
                                      ? expiringSubscription!
                                          .endDate
                                          .toDateOnlyString
                                      : member
                                          .subscriptions[0]
                                          .endDate
                                          .toDateOnlyString,
                                ),
                              ],
                            ),
                            member.subscriptions[0].endDate.isAfter(
                                  DateTime.now(),
                                )
                                ? Icon(Icons.circle, color: Colors.green)
                                : Icon(
                                  Icons.circle_outlined,
                                  color: Colors.red,
                                ),
                          ],
                        ),
                        5.ph,
                      ]
                      : [SizedBox()],
            ),
          ],
        ),
      ),
    );
  }
}
