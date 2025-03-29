import 'package:falcon_project/core/constants/my_strings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:opticore/opticore.dart';

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
          // currentIndex: currentIndex,
          onTap: onTap,
          items: const [
            BottomNavigationBarItem(
                label: MyStrings.members, icon: Icon(Icons.people)),
            BottomNavigationBarItem(
              label: MyStrings.analytics,
              icon: Icon(Icons.bar_chart),
            ),
          ],
        ),
      ),
    );
  }
}
