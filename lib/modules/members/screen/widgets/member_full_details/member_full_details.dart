import 'package:falcon_project/modules/members/screen/widgets/member_full_details/subscription_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:opticore/opticore.dart';

import '../../../../../network/member_model.dart';

class MemberFullDetails extends StatefulWidget {
  MemberFullDetails({
    super.key,
    required this.member,
    required this.onCancelTapped,
  });

  final Member member;
  Function(Subscription) onCancelTapped;

  @override
  State<MemberFullDetails> createState() => MemberFullDetailsState();
}

class MemberFullDetailsState extends State<MemberFullDetails> {
  bool isActive = false;

  void childRebuild() {
    setState(() {
      print("I am set state>>>>>>>>>>>>>>");
    });
  }

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
                  widget.member.name,
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
            "Phone number:  0${widget.member.phoneNumber}",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 23.sp),
          ),
          SizedBox(height: 10.h),
          Visibility(
            visible: widget.member.extraNotes!.isNotEmpty ? true : false,
            child: Text(
              "Extra Notes:  ${widget.member.extraNotes}",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15.sp),
            ),
          ),
          SizedBox(height: widget.member.extraNotes!.isNotEmpty ? 10.h : 0),
          Text("Subscriptions history: "),
          SizedBox(height: 5.h),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children:
                widget.member.subscriptions.map((subscription) {
                  isActive = false;
                  if (subscription.endDate.isAfter(DateTime.now())) {
                    isActive = true;
                  }
                  return SubscriptionContainer(
                    isActive: isActive,
                    subscription: subscription,
                    onCancelTapped:
                        isActive
                            ? () {
                                widget.onCancelTapped(subscription);
                            }
                            : null,
                    onSettleTapped:
                        isActive && subscription.dueAmount != 0
                            ? () {
                              subscription.paidAmount =
                                  subscription.paidAmount +
                                  subscription.dueAmount!;
                              subscription.dueAmount = 0;
                              setState(() {});
                            }
                            : null,
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
