import 'package:falcon_project/widgets/red_line.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:opticore/opticore.dart';

class MembersBriefGrid extends StatelessWidget {
  MembersBriefGrid({
    super.key,
    required this.builder,
    required this.itemCount,
    this.title,
  });

  final Widget Function(BuildContext, int) builder;
  int itemCount;
  final String? title;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
      child: Column(
        children: [
          title != null ?
          Column(
              children: [
                Text(title!,style: TextStyle().copyWith(fontSize: 25.sp),),
            10.ph,
                RedLine(),
            20.ph
          ],
          )
              : 0.ph,
          FlexibleGridView(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            crossAxisSpacing: 10.w,
            mainAxisSpacing: 10.h,
            builder: builder,
            itemCount: itemCount,
            crossAxisCount: 2,
          ),
        ],
      ),
    );
  }
}
