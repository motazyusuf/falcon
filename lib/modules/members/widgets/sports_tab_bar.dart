import 'package:easy_localization/easy_localization.dart';
import 'package:falcon_project/modules/members/import/members_module_import.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:opticore/opticore.dart';

import '../../../core/config/translations/codegen_loader.g.dart';
import '../../../core/enums/sport_enum.dart';

class SportsTabBar extends StatefulWidget {
  const SportsTabBar({super.key});

  @override
  State<SportsTabBar> createState() => _SportsTabBarState();
}

class _SportsTabBarState extends State<SportsTabBar> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: Sport.values.length + 1,
      child: TabBar(
        tabAlignment: TabAlignment.start,
        onTap: (index) {
          if (index == 0) {
            // context.read<MembersModuleBloc>().add(
            //   FilterMembersEvent('all'),
            context.read<MembersModuleBloc>().add(GetMembersEvent());
          } else {
            context.read<MembersModuleBloc>().add(
              FilterMembersEvent(Sport.values[index - 1].localeKey),
            );
          }
        },
        isScrollable: true,
        indicatorPadding: EdgeInsets.zero,
        labelPadding: const EdgeInsets.symmetric(horizontal: 5),
        padding: const EdgeInsets.only(top: 8, bottom: 8),
        indicatorColor: Colors.transparent,
        dividerColor: Colors.transparent,
        tabs: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 8, vertical: 5),
            decoration: BoxDecoration(
              color: context.colorScheme.secondary,
              borderRadius: BorderRadius.circular(25.r),
            ),
            child: Text(
              LocaleKeys.all_sports.tr(),
              style: TextStyle().copyWith(
                fontFamily: "Anton_SC",
                fontSize: 13.sp,
              ),
            ),
          ),
          ...Sport.values.map(
            (sport) => Container(
              padding: EdgeInsets.symmetric(horizontal: 8, vertical: 5),
              decoration: BoxDecoration(
                color: context.colorScheme.secondary,
                borderRadius: BorderRadius.circular(25.r),
              ),
              child: Text(
                sport.localeKey,
                style: TextStyle().copyWith(
                  fontFamily: "Anton_SC",
                  fontSize: 13.sp,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
