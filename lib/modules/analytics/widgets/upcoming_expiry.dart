import 'package:easy_localization/easy_localization.dart';
import 'package:falcon_project/modules/analytics/widgets/reports_double_container.dart';
import 'package:flutter/material.dart';
import 'package:opticore/opticore.dart';

import '../../../core/config/translations/codegen_loader.g.dart';

class UpcomingExpiry extends StatelessWidget {
  const UpcomingExpiry({
    super.key,
    required this.inThreeMembersLength,
    required this.inWeekMembersLength,
     this.onThreeTapped,
     this.onWeekTapped,
  });

  final int inThreeMembersLength;
  final int inWeekMembersLength;
  final Function()? onThreeTapped;
  final Function()? onWeekTapped;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "${LocaleKeys.upcmng_exp.tr()}:",
          style: context.textTheme.titleMedium,
        ),
        TwoReportsContainers(
          firstNumber: inThreeMembersLength,
          firstText: LocaleKeys.exp_3.tr(),
          secondNumber: inWeekMembersLength,
          secondText: LocaleKeys.exp_7.tr(),
          onFirstTapped: onThreeTapped,
          onSecondTapped: onWeekTapped,
        ),
      ],
    );
  }
}
