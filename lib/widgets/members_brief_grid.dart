import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:opticore/opticore.dart';

class MembersBriefGrid extends StatelessWidget {
  MembersBriefGrid({
    super.key,
    required this.builder,
    required this.itemCount,
  });

  final Widget Function(BuildContext, int) builder;
  int itemCount;

  @override
  Widget build(BuildContext context) {
    return FlexibleGridView(
      crossAxisSpacing: 10.w,
      mainAxisSpacing: 10.h,
      builder: builder,
      itemCount: itemCount,
      crossAxisCount: 2,
    );
  }
}
