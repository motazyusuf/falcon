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
      elevation: 8,
      shape: CircularNotchedRectangle(),
      notchMargin: 8,
      color: context.colorScheme.secondary,
      height: 60.h,
      child: ClipRRect(
        borderRadius: BorderRadius.all(Radius.circular(16)),
        child: BottomNavigationBar(
          backgroundColor: Colors.transparent,
          showUnselectedLabels: false,
          showSelectedLabels: true,
          iconSize: 25.r,
          selectedLabelStyle: TextStyle(
            fontSize: 10.sp,
            color: context.colorScheme.primary,
          ),
          selectedItemColor: context.colorScheme.primary,
          elevation: 2,
          currentIndex: currentIndex,
          // currentIndex: currentIndex,
          onTap: onTap,
          items: const [
            BottomNavigationBarItem(label: "Members", icon: Icon(Icons.people)),
            BottomNavigationBarItem(
              label: "Analytics",
              icon: Icon(Icons.bar_chart),
            ),
          ],
        ),
      ),
    );
  }
}
