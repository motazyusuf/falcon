import 'package:easy_localization/easy_localization.dart';
import 'package:falcon_project/core/extensions/date_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:opticore/opticore.dart';

import '../../../core/config/translations/codegen_loader.g.dart';
import '../../../core/network/model/member_model.dart';

class SubscriptionContainer extends StatelessWidget {
  SubscriptionContainer({
    super.key,
    required this.isActive,
    required this.subscription,
    required this.onCancelTapped,
    required this.onSettleTapped,
  });

  final Subscription subscription;
  final bool isActive;
  Function()? onCancelTapped;
  Function()? onSettleTapped;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(3.h),
      padding: EdgeInsets.all(10.w),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20.r),
        border: Border.all(
          width: 2.r,
          color:
              isActive ? Colors.green : context.colorScheme.secondaryContainer,
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
                    "${LocaleKeys.gym_class.tr()}: ${subscription.sport?.localeKey.tr()}",
                    style: TextStyle().copyWith(
                      color:
                          !isActive
                              ? context.colorScheme.secondaryContainer
                              : null,
                    ),
                  ),
                  Text(
                    "${LocaleKeys.sub_date.tr()}: ${subscription.subscriptionDate.toDateOnlyString}",
                    style: TextStyle().copyWith(
                      color:
                          !isActive
                              ? context.colorScheme.secondaryContainer
                              : null,
                    ),
                  ),
                  Text(
                    "${LocaleKeys.end_date.tr()}: ${subscription.endDate.toDateOnlyString}",
                    style: TextStyle().copyWith(
                      color:
                          !isActive
                              ? context.colorScheme.secondaryContainer
                              : null,
                    ),
                  ),
                  Text(
                    "${LocaleKeys.paid.tr()}: ${subscription.paidAmount}",
                    style: TextStyle().copyWith(
                      color:
                          !isActive
                              ? context.colorScheme.secondaryContainer
                              : null,
                    ),
                  ),
                  Text(
                    "${LocaleKeys.due.tr()}:  ${subscription.dueAmount}",
                    style: TextStyle().copyWith(
                      color:
                          !isActive
                              ? context.colorScheme.secondaryContainer
                              : null,
                    ),
                  ),
                ],
              ),
              20.pw,
              Column(
                children: [
                  ElevatedButton(
                    onPressed: onSettleTapped,
                    style: ElevatedButton.styleFrom(
                      backgroundColor:
                          isActive && subscription.dueAmount != 0
                              ? context.colorScheme.secondary
                              : context.colorScheme.secondaryContainer,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(
                          30,
                        ), // Adjust roundness
                      ),
                      padding: EdgeInsets.symmetric(
                        horizontal: 5.w,
                        vertical: 5.h,
                      ), // Button size
                    ),
                    child: Text(
                      LocaleKeys.settle.tr(),
                      style: TextStyle(
                        color:
                            isActive && subscription.dueAmount != 0
                                ? Colors.white
                                : Color(0xFF616161),
                      ),
                    ),
                  ),
                  10.ph,
                  ElevatedButton(
                    onPressed: onCancelTapped,
                    style: ElevatedButton.styleFrom(
                      backgroundColor:
                          isActive
                              ? context.colorScheme.secondary
                              : context.colorScheme.secondaryContainer,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(
                          30,
                        ), // Adjust roundness
                      ),
                      padding: EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 12,
                      ), // Button size
                    ),
                    child: Text(
                      LocaleKeys.cancel.tr(),
                      style: TextStyle(
                        color: isActive ? Colors.red : Color(0xFF616161),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
          5.ph,
        ],
      ),
    );
  }
}
