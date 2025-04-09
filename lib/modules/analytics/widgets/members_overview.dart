import 'package:easy_localization/easy_localization.dart';
import 'package:falcon_project/modules/analytics/widgets/reports_double_container.dart';
import 'package:flutter/material.dart';
import 'package:opticore/opticore.dart';

import '../../../core/config/translations/codegen_loader.g.dart';
import '../../../core/network/model/member_model.dart';

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
        Text("${LocaleKeys.members_overview.tr()}:", style: context.textTheme.titleMedium),
        ReportsDoubleContainers(
          firstNumber: allMembers.length,
          firstText: LocaleKeys.total_members.tr(),
          secondNumber: dueMembers.length,
          secondText: LocaleKeys.members_dues.tr(),
          onFirstTapped: () {},
          onSecondTapped: () {},
        ),
        ReportsDoubleContainers(
          firstNumber: activeMembers.length,
          firstText: LocaleKeys.active_members.tr(),
          secondNumber: inactiveMembers.length,
          secondText: LocaleKeys.inactive_members.tr(),
          onFirstTapped: () {},
          onSecondTapped: () {},
        ),
      ],
    );
  }
}
