import 'package:falcon_project/modules/analytics/screen/widgets/reports_double_container.dart';
import 'package:flutter/material.dart';
import 'package:opticore/opticore.dart';

class MembersOverview extends StatelessWidget {
  const MembersOverview({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Members Overview:", style: context.textTheme.titleMedium),
        ReportsDoubleContainers(
          firstNumber: 150,
          firstText: "Total Members",
          secondNumber: 10,
          secondText: "Members with dues",
          onFirstTapped: () {},
          onSecondTapped: () {},
        ),
        ReportsDoubleContainers(
          firstNumber: 60,
          firstText: "Active Members",
          secondNumber: 90,
          secondText: "Inactive Members",
          onFirstTapped: () {},
          onSecondTapped: () {},
        ),
      ],
    );
  }
}
