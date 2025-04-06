import 'package:falcon_project/modules/analytics/screen/widgets/reports_double_container.dart';
import 'package:flutter/material.dart';
import 'package:opticore/opticore.dart';

import '../../../../network/member_model.dart';

class UpcomingExpiry extends StatelessWidget {
  const UpcomingExpiry(
      {super.key, required this.inThreeMembers, required this.inWeekMembers});

  final List<Member> inThreeMembers;
  final List<Member> inWeekMembers;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Upcoming Expiry Report:", style: context.textTheme.titleMedium),
        ReportsDoubleContainers(
          firstNumber: inThreeMembers.length,
          firstText: "Expiry in 1-3 days",
          secondNumber: inWeekMembers.length,
          secondText: "Expiry in 4-7 days",
          onFirstTapped: () {},
          onSecondTapped: () {},
        ),
      ],
    );
  }
}
