import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:opticore/opticore.dart';

import '../../../core/config/translations/codegen_loader.g.dart';
import '../../../core/enums/sport_enum.dart';
import '../../../utils/helper/helper.dart';

class SubscriptionItem extends StatelessWidget {
  final ValueChanged<Sport?> onSportChanged;
  final ValueChanged<String> onPaidAmountChanged;
  final Function() onSubscriptionRemoved;
  final ValueChanged<String> onDueAmountChanged;
  final Function() onStartDateChanged;
  final Function(int) onEndDateChanged;
  int index;
  List<bool> isEndDatePicked;
  DateTime pickedStartDate;

  SubscriptionItem({
    super.key,
    required this.onSportChanged,
    required this.onSubscriptionRemoved,
    required this.onStartDateChanged,
    required this.onEndDateChanged,
    required this.onPaidAmountChanged,
    required this.onDueAmountChanged,
    required this.pickedStartDate,
    required this.index,
    required this.isEndDatePicked
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 180.w,
      height: 250.h,
      padding: EdgeInsets.symmetric(horizontal: 5.w),
      decoration: BoxDecoration(
        color: context.colorScheme.secondaryFixed,
        border: Border.all(color: context.colorScheme.secondaryContainer),
      ),
      margin: EdgeInsets.symmetric(vertical: 5.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          DropdownButtonFormField<Sport>(
            dropdownColor: context.colorScheme.secondaryContainer,
            value: Sport.values[0],
            items:
            Sport.values.map((sport) {
              return DropdownMenuItem(
                value: sport,
                child: Text(
                  sport.localeKey.tr(),
                  style: TextStyle().copyWith(fontSize: 15.sp),
                ),
              );
            }).toList(),
            onChanged: onSportChanged,
          ),
          10.ph,
          // Subscription Start Date
          GestureDetector(
            onTap: isEndDatePicked[index] ? null : onStartDateChanged,
            child: Text(
              "${LocaleKeys.sub_date.tr()}: ${pickedStartDate.toString().substring(
                  0, 10)}",
              style: context.textTheme.displaySmall?.copyWith(fontSize: 12.sp,
                  color: isEndDatePicked[index] ? context.colorScheme
                      .secondaryContainer : null),
            ),
          ),
          15.ph,
          DefaultTabController(
            length: 4,
            child: TabBar(
              tabAlignment: TabAlignment.center,
              physics: const ClampingScrollPhysics(),
              padding: EdgeInsets.zero,
              isScrollable: true,
              onTap: onEndDateChanged,
              indicatorPadding: EdgeInsets.zero,
              labelPadding: EdgeInsets.zero,
              indicatorColor: Colors.transparent,
              dividerColor: Colors.transparent,
              tabs: [
                Container(
                  decoration: BoxDecoration(
                    color: context.colorScheme.secondary,
                    borderRadius: BorderRadius.circular(25.r),
                  ),
                  child: Text(
                    "",
                    style: TextStyle().copyWith(
                      fontFamily: "Anton_SC",
                      fontSize: 10.sp,
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 5.w),
                  decoration: BoxDecoration(
                    color: context.colorScheme.secondary,
                    borderRadius: BorderRadius.circular(25.r),
                  ),
                  child: Text(
                    LocaleKeys.month.tr(),
                    style: TextStyle().copyWith(
                      fontFamily: "Anton_SC",
                      fontSize: 10.sp,
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 5.w),
                  decoration: BoxDecoration(
                    color: context.colorScheme.secondary,
                    borderRadius: BorderRadius.circular(25.r),
                  ),
                  child: Text(
                    "2 ${LocaleKeys.months.tr()}",
                    style: TextStyle().copyWith(
                      fontFamily: "Anton_SC",
                      fontSize: 10.sp,
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 5.w),

                  decoration: BoxDecoration(
                    color: context.colorScheme.secondary,
                    borderRadius: BorderRadius.circular(25.r),
                  ),
                  child: Text(
                    "3 ${LocaleKeys.months.tr()}",
                    style: TextStyle().copyWith(
                      fontFamily: "Anton_SC",
                      fontSize: 10.sp,
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Paid Amount
          TextFormField(
            validator: AppHelper.validateNotEmpty,
            style: context.textTheme.displaySmall?.copyWith(fontSize: 12.sp),
            decoration: InputDecoration(hintText: LocaleKeys.paid.tr()),
            keyboardType: TextInputType.number,
            onChanged: onPaidAmountChanged,
          ),

          // Due Amount
          TextFormField(
            style: context.textTheme.displaySmall?.copyWith(fontSize: 12.sp),
            decoration: InputDecoration(hintText: LocaleKeys.due.tr()),
            keyboardType: TextInputType.number,
            onChanged: onDueAmountChanged,
          ),

          // Remove Button
          Align(
            alignment: Alignment.bottomRight,
            child: TextButton(
              onPressed: onSubscriptionRemoved,
              child: Text(
                LocaleKeys.remove.tr(),
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
