import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

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
      notchMargin: 8,
      height: 60.h,
      child: ClipRRect(
        borderRadius: BorderRadius.all(Radius.circular(16)),
        child: BottomNavigationBar(
          iconSize: 24.r,
          selectedLabelStyle: TextStyle(
            fontSize: 10.sp,
          ),
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
