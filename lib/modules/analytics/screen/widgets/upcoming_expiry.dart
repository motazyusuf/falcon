import 'package:falcon_project/modules/analytics/screen/widgets/reports_double_container.dart';
import 'package:flutter/material.dart';
import 'package:opticore/opticore.dart';

class UpcomingExpiry extends StatelessWidget {
  const UpcomingExpiry({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Upcoming Expiry Report:", style: context.textTheme.titleMedium),
        ReportsDoubleContainers(
          firstNumber: 4,
          firstText: "Expiry in 1-3 days",
          secondNumber: 6,
          secondText: "Expiry in 4-7 days",
          onFirstTapped: () {},
          onSecondTapped: () {},
        ),
      ],
    );
  }
}
