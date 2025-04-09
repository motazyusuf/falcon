import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:opticore/opticore.dart';

class RedLine extends StatelessWidget {
  const RedLine({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: AdvancedLine(
        direction: Axis.horizontal,
        line: SolidLine(),
        paintDef:
        Paint()
          ..color = context.colorScheme.primary
          ..strokeWidth = 2.h,
      ),
    );
  }
}
