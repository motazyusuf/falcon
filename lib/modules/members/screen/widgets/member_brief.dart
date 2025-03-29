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
      height: 120.h,
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
          Text(
            "${member.firstName} ${member.lastName}",
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children:
                member.subscriptions
                    .map(
                      (subscription) =>
                          Text("${subscription.sport?.displayName}"),
                    )
                    .toList(),
          ),
          Text(
            member.isActive ? "Active" : "Non Active",
            style: TextStyle(color: Colors.green),
          ),
        ],
      ),
    );
    ();
  }
}
