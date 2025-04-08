import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:opticore/opticore.dart';

import '../../../translations/codegen_loader.g.dart';


class MyBottomBar extends StatelessWidget {
  const MyBottomBar({
    super.key,
    required this.onTap,
    required this.currentIndex,
  });

  final Function(int) onTap;
  final int currentIndex;

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      color: context.colorScheme.secondary,
      notchMargin: 8,
      height: 60.h,
      child: ClipRRect(
        borderRadius: BorderRadius.all(Radius.circular(16)),
        child: BottomNavigationBar(
          showSelectedLabels: true,
          iconSize: 24.r,
          selectedLabelStyle: TextStyle(fontSize: 7.sp),
          currentIndex: currentIndex,
          onTap: onTap,
          items: const [
            BottomNavigationBarItem(
                label: LocaleKeys.members, icon: Icon(Icons.people)),
            BottomNavigationBarItem(
              label: LocaleKeys.analytics,
              icon: Icon(Icons.bar_chart),
            ),
          ],
        ),
      ),
    );
  }
}
