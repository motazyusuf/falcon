import 'package:easy_localization/easy_localization.dart';
import 'package:falcon_project/modules/analytics/widgets/reports_double_container.dart';
import 'package:flutter/material.dart';
import 'package:opticore/opticore.dart';

import '../../../core/config/translations/codegen_loader.g.dart';
import '../../../core/network/model/member_model.dart';


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
        Text("${LocaleKeys.upcmng_exp.tr()}:", style: context.textTheme.titleMedium),
        ReportsDoubleContainers(
          firstNumber: inThreeMembers.length,
          firstText: LocaleKeys.exp_3.tr(),
          secondNumber: inWeekMembers.length,
          secondText: LocaleKeys.exp_7.tr(),
          onFirstTapped: () {},
          onSecondTapped: () {},
        ),
      ],
    );
  }
}
