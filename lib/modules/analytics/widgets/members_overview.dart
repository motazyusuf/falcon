import 'package:easy_localization/easy_localization.dart';
import 'package:falcon_project/modules/analytics/widgets/reports_double_container.dart';
import 'package:flutter/material.dart';
import 'package:opticore/opticore.dart';

import '../../../core/config/translations/codegen_loader.g.dart';
import '../../../core/network/model/member_model.dart';

class MembersOverview extends StatelessWidget {
  const MembersOverview({
    super.key,
    required this.allMembersLength,
    required this.dueMembers,
    required this.activeMembers,
    required this.inactiveMembers,
    required this.onActiveMembersTaped,
    required this.onDueMembersTaped,
    required this.onInactiveMembersTaped
  });

  final List<Member> dueMembers,inactiveMembers, activeMembers;
    final int allMembersLength;
    final Function() onDueMembersTaped;
    final Function() onActiveMembersTaped;
    final Function() onInactiveMembersTaped;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("${LocaleKeys.members_overview.tr()}:", style: context.textTheme.titleMedium),
        TwoReportsContainers(
          firstNumber: allMembersLength,
          firstText: LocaleKeys.total_members.tr(),
          secondNumber: dueMembers.length,
          secondText: LocaleKeys.members_dues.tr(),
          onFirstTapped: () {},
          onSecondTapped: onDueMembersTaped,
        ),
        TwoReportsContainers(
          firstNumber: activeMembers.length,
          firstText: LocaleKeys.active_members.tr(),
          secondNumber: inactiveMembers.length,
          secondText: LocaleKeys.inactive_members.tr(),
          onFirstTapped: onActiveMembersTaped,
          onSecondTapped: onInactiveMembersTaped,
        ),
      ],
    );
  }
}
