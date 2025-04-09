import 'package:easy_localization/easy_localization.dart';
import 'package:falcon_project/modules/analytics/widgets/reports_double_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:opticore/opticore.dart';

import '../../../core/config/translations/codegen_loader.g.dart';

class RevenueReport extends StatelessWidget {
  RevenueReport(
      {super.key, required this.monthlyRevenue, required this.weeklyRevenue});

  int weeklyRevenue, monthlyRevenue;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("${LocaleKeys.rvn_report.tr()}:", style: context.textTheme.titleMedium),
        ReportsDoubleContainers(
          firstNumber: monthlyRevenue,
          firstText: LocaleKeys.mnthly_rvn.tr(),
          secondNumber: weeklyRevenue,
          secondText: LocaleKeys.wkly_rvn.tr(),
          onFirstTapped: () {},
          onSecondTapped: () {},
        ),
        10.ph,
        Container(
          padding: EdgeInsets.all(10.w),

          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/images/chartRed.png"),
              opacity: 0.7,
            ),
            color: context.colorScheme.secondary,
            borderRadius: BorderRadius.circular(20.r),
          ),
          height: 100.h,
          width: double.infinity,
          child: Align(
            alignment: Alignment.center,
            child: Text(LocaleKeys.yrly_chart.tr(), style: context.textTheme.bodyLarge),
          ),
        ),
      ],
    );
  }
}
