import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:opticore/opticore.dart';

import '../../../../../core/constants/my_strings.dart';
import '../../../../../core/functions/my_functions.dart';

class RenewSubscriptionDialogue extends StatelessWidget {
  const RenewSubscriptionDialogue({super.key});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      child: Center(
        child: Container(
          height: 200.h,
          decoration: BoxDecoration(
            color: context.colorScheme.secondary,
            borderRadius: BorderRadius.circular(20.r),
          ),
          padding: EdgeInsets.all(20.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Renew Subscription"),
              SizedBox(height: 10.h),
              DefaultTabController(
                length: 4,
                child: TabBar(
                  tabAlignment: TabAlignment.center,
                  physics: const ClampingScrollPhysics(),
                  padding: EdgeInsets.zero,
                  isScrollable: true,
                  onTap: (value) {},
                  indicatorPadding: EdgeInsets.zero,
                  labelPadding: EdgeInsets.zero,
                  indicatorColor: context.colorScheme.secondary,
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
                        "Month",
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
                        "2 Months",
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
                        "3 months",
                        style: TextStyle().copyWith(
                          fontFamily: "Anton_SC",
                          fontSize: 10.sp,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              TextFormField(
                validator: MyFunctions.validateNotEmpty,
                style: context.textTheme.displaySmall?.copyWith(
                  fontSize: 12.sp,
                ),
                decoration: InputDecoration(hintText: MyStrings.paidAmount),
                keyboardType: TextInputType.number,
                onChanged: (value) {},
              ),

              // Due Amount
              TextFormField(
                style: context.textTheme.displaySmall?.copyWith(
                  fontSize: 12.sp,
                ),
                decoration: InputDecoration(hintText: MyStrings.dueAmount),
                keyboardType: TextInputType.number,
                onChanged: (onDueAmountChanged) {},
              ),
            ],
          ),
        ),
      ),
    );
  }
}
