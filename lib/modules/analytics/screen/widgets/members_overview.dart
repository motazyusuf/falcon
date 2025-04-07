import 'package:falcon_project/modules/analytics/screen/widgets/reports_double_container.dart';
import 'package:flutter/material.dart';
import 'package:opticore/opticore.dart';

import '../../../../core/network/model/member_model.dart';

class MembersOverview extends StatelessWidget {
  const MembersOverview({
    super.key,
    required this.allMembers,
    required this.dueMembers,
    required this.activeMembers,
    required this.inactiveMembers,
  });

  final List<Member> allMembers, dueMembers, inactiveMembers, activeMembers;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Members Overview:", style: context.textTheme.titleMedium),
        ReportsDoubleContainers(
          firstNumber: allMembers.length,
          firstText: "Total Members",
          secondNumber: dueMembers.length,
          secondText: "Members with dues",
          onFirstTapped: () {},
          onSecondTapped: () {},
        ),
        ReportsDoubleContainers(
          firstNumber: activeMembers.length,
          firstText: "Active Members",
          secondNumber: inactiveMembers.length,
          secondText: "Inactive Members",
          onFirstTapped: () {},
          onSecondTapped: () {},
        ),
      ],
    );
  }
}
