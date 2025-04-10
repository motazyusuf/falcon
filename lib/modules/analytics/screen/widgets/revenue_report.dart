import 'package:falcon_project/modules/analytics/screen/widgets/reports_double_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:opticore/opticore.dart';

class RevenueReport extends StatelessWidget {
  RevenueReport(
      {super.key, required this.monthlyRevenue, required this.weeklyRevenue});

  int weeklyRevenue, monthlyRevenue;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Revenue Report:", style: context.textTheme.titleMedium),
        ReportsDoubleContainers(
          firstNumber: monthlyRevenue,
          firstText: "Monthly Revenue",
          secondNumber: weeklyRevenue,
          secondText: "Weekly Revenue",
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
            child: Text("Yearly Chart", style: context.textTheme.bodyLarge),
          ),
        ),
      ],
    );
  }
}
