import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:opticore/opticore.dart';

import '../../../core/config/translations/codegen_loader.g.dart';

class RevenueReport extends StatelessWidget {
  RevenueReport({
    super.key,
    required this.monthlyRevenue,
    required this.onChartTapped
  });

  int monthlyRevenue;
  Function() onChartTapped;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "${LocaleKeys.rvn_report.tr()}:",
          style: context.textTheme.titleMedium,
        ),
        // TwoReportsContainers(
        //   firstNumber: monthlyRevenue,
        //   firstText: LocaleKeys.mnthly_rvn.tr(),
        //   secondNumber: weeklyRevenue,
        //   secondText: LocaleKeys.wkly_rvn.tr(),
        //   onFirstTapped: () {},
        //   onSecondTapped: () {},
        // ),
        10.ph,
        Container(
          padding: EdgeInsets.all(10.w),
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/images/earning.png"),
              opacity: 0.5,
            ),
            color: context.colorScheme.secondary,
            borderRadius: BorderRadius.circular(20.r),
          ),
          height: context.screenSize.height * 0.15,
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Text(
                  "$monthlyRevenue",
                  style: context.textTheme.titleLarge?.copyWith(
                    color: context.colorScheme.primary,
                    fontSize: 40.sp,
                  ),
                ),
              ),
              Text(
                LocaleKeys.mnthly_rvn.tr(),
                style: context.textTheme.bodySmall,
              ),
            ],
          ),
        ),
        10.ph,
        InkWell(
          onTap: onChartTapped,
          child: Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/images/chartRed.png"),
                opacity: 0.7,
              ),
              color: context.colorScheme.secondary,
              borderRadius: BorderRadius.circular(20.r),
            ),
            height: context.screenSize.height * 0.15,
            width: double.infinity,
            child: Align(
              alignment: Alignment.center,
              child: Text(
                LocaleKeys.yrly_chart.tr(),
                style: TextStyle().copyWith(
                  fontSize: 45.sp,
                  color: Colors.white.withAlpha(200),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
