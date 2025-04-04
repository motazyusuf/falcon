import 'package:falcon_project/modules/members/screen/widgets/member_full_details/subscription_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:opticore/opticore.dart';

import '../../../../../network/member_model.dart';

class MemberFullDetails extends StatefulWidget {
  const MemberFullDetails({
    super.key,
    required this.member,
    required this.onCancelTapped,
    required this.onSettleTapped,
    required this.onDeleteTapped,
    required this.onEditTapped,
    required this.onAddSubscriptionTapped,
  });

  final Member member;
  final Function(Subscription) onCancelTapped;
  final Function(Subscription) onSettleTapped;
  final Function() onDeleteTapped;
  final Function() onEditTapped;
  final Function() onAddSubscriptionTapped;

  @override
  State<MemberFullDetails> createState() => MemberFullDetailsState();
}

class MemberFullDetailsState extends State<MemberFullDetails> {
  bool isActive = false;

  void memberFullDetailsRebuild() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(left: 30.w),
            child: Row(
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
                GestureDetector(
                  onTap: widget.onAddSubscriptionTapped,
                  child: Icon(Icons.add),
                ),
              ],
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
            "Phone number:  0${widget.member.phoneNumber}",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 23.sp),
          ),
          SizedBox(height: 10.h),
          Visibility(
            visible:
            widget.member.extraNotes!.isNotEmpty &&
                widget.member.extraNotes! != " "
                ? true
                : false,
            child: Text(
              "Extra Notes:  ${widget.member.extraNotes}",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15.sp),
            ),
          ),
          SizedBox(height: widget.member.extraNotes!.isNotEmpty &&
              widget.member.extraNotes! != " " ? 10.h : 0),
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
                              widget.onSettleTapped(subscription);
                            }
                            : null,
                  );
                }).toList(),
          ),
          SizedBox(height: 5.h),
          CoreButton(
            title: "Edit Member Information",
            onTap: widget.onEditTapped,
            backgroundColor: context.colorScheme.secondaryContainer,
          ),
          SizedBox(height: 5.h),
          CoreButton(title: "Delete Member", onTap: widget.onDeleteTapped),
        ],
      ),
    );
  }
}
