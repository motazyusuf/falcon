import 'package:falcon_project/core/constants/my_strings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:opticore/opticore.dart';

import '../../core/enums/sport_enum.dart';
import '../../network/member_model.dart';

class SubscriptionItem extends StatelessWidget {
  int index;
  final ValueChanged<Sport?> onSportChanged;
  final ValueChanged<String> onPaidAmountChanged;
  final Function() onSubscriptionRemoved;
  final ValueChanged<String> onDueAmountChanged;
  final Function() onStartDateChanged;
  final Function() onEndDateChanged;
  List<Subscription> subscriptions;

  SubscriptionItem({
    super.key,
    required this.index,
    required this.onSportChanged,
    required this.onSubscriptionRemoved,
    required this.onStartDateChanged,
    required this.onEndDateChanged,
    required this.onPaidAmountChanged,
    required this.onDueAmountChanged,
    required this.subscriptions,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 150.w,
      padding: EdgeInsets.symmetric(horizontal: 5.w),
      decoration: BoxDecoration(
        color: context.colorScheme.secondaryFixed,
        border: Border.all(color: context.colorScheme.secondaryContainer),
      ),
      margin: EdgeInsets.symmetric(vertical: 5.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Sport Dropdown
          Flexible(
            child: DropdownButtonFormField<Sport>(
              dropdownColor: context.colorScheme.secondaryContainer,
              value: subscriptions[index].sport,
              decoration: InputDecoration(),
              items:
                  Sport.values.map((sport) {
                    return DropdownMenuItem(
                      value: sport,
                      child: Text(
                        sport.displayName,
                        style: TextStyle().copyWith(fontSize: 15.sp),
                      ),
                    );
                  }).toList(),
              onChanged: onSportChanged,
            ),
          ),
          SizedBox(height: 10),
          // Subscription Start Date
          GestureDetector(
            onTap: onStartDateChanged,
            child: Text(
              "${MyStrings.startDate}: ${subscriptions[index].subscriptionDate.toString().substring(0, 10)}",
              style: context.textTheme.displaySmall?.copyWith(fontSize: 12.sp),
            ),
          ),

          // End Date
          GestureDetector(
            onTap: onEndDateChanged,
            child: Text(
              "${MyStrings.endDate}: ${subscriptions[index].endDate.toString().substring(0, 10)}",
              style: context.textTheme.displaySmall?.copyWith(fontSize: 12.sp),
            ),
          ),

          // Paid Amount
          TextFormField(
            style: context.textTheme.displaySmall?.copyWith(fontSize: 12.sp),
            decoration: InputDecoration(hintText: MyStrings.paidAmount),
            keyboardType: TextInputType.number,
            onChanged: onPaidAmountChanged,
          ),

          // Due Amount
          TextFormField(
            style: context.textTheme.displaySmall?.copyWith(fontSize: 12.sp),
            decoration: InputDecoration(hintText: MyStrings.dueAmount),
            keyboardType: TextInputType.number,
            onChanged: onDueAmountChanged,
          ),

          // Remove Button
          Align(
            alignment: Alignment.bottomRight,
            child: TextButton(
              onPressed: onSubscriptionRemoved,
              child: Text(
                MyStrings.remove,
                style: context.textTheme.displaySmall?.copyWith(
                  fontSize: 12.sp,
                  color: context.colorScheme.primary,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
