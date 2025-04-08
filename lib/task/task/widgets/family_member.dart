import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:opticore/opticore.dart';

import '../model.dart';

class FamilyMember extends StatelessWidget {
   FamilyMember({super.key,required this.member});

  final AhlyMember member;

  List<String> durations = List.generate(
    12,
    (index) => "${index + 1} Month${index == 0 ? '' : 's'}",
  );

  @override
  Widget build(BuildContext context) {
    var height = context.screenSize.height;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: EdgeInsets.all(15.w),
          decoration: BoxDecoration(
            color: context.colorScheme.secondary,
            borderRadius: BorderRadius.circular(20),
          ),
          height: height * 0.15,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset("assets/images/task/group_1000003315.webp"),
              5.pw,
              Padding(
                padding: EdgeInsets.all(10.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [Text(member.name), Text(member.birthDate)],
                ),
              ),
            ],
          ),
        ),
        15.ph,
        Text("Activities: ", style: TextStyle(color: Color(0xffB68B26))),
        10.ph,
        Column(
          children:
              member.activities
                  .map(
                    (activity) => Container(
                      padding: EdgeInsets.all(15.w),
                      decoration: BoxDecoration(
                        color: context.colorScheme.secondary,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      height: height * 0.15,
                      child: Column(
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Image.asset(
                                activity.icon,
                                height: 35.r,
                                color: Color(0xffC8C7C7),
                              ),
                              20.pw,
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    RichText(
                                      text: TextSpan(
                                        children: [
                                          TextSpan(
                                            text: "Activity Name: ",
                                            style: TextStyle(
                                              color: Colors.grey,
                                              fontSize: 15.sp,
                                            ), // Default text color
                                          ),
                                          TextSpan(
                                            text: activity.activityName,
                                            // Variable text
                                            style: TextStyle(
                                              fontSize: 15.sp,
                                              color: Colors.white,
                                            ), // Variable text color
                                          ),
                                        ],
                                      ),
                                    ),
                                    5.ph,
                                    RichText(
                                      text: TextSpan(
                                        children: [
                                          TextSpan(
                                            text: "Subscription Status: ",
                                            style: TextStyle(
                                              color: Colors.grey,
                                              fontSize: 15.sp,
                                            ), // Default text color
                                          ),
                                          TextSpan(
                                            text:
                                                activity.status
                                                    ? "Active"
                                                    : "Expired",
                                            // Variable text
                                            style: TextStyle(
                                              color: Color(0xffdc0101),
                                              fontSize: 15.sp,
                                            ), // Variable text color
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Image.asset(
                                height: 25.r,
                                activity.isSelected
                                    ? "assets/images/task/checkbox.webp"
                                    : "assets/images/task/checkbox (1).webp",
                              ),
                            ],
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: 55.w),
                            child: Row(
                              children: [
                                SizedBox(
                                  width: 70.w, // Set the width to 60
                                  child: DropdownButtonFormField<String>(menuMaxHeight: 200.h,
                                    value: durations[0],
                                    decoration: InputDecoration(
                                      border: InputBorder.none, // Remove the underline
                                    ),
                                    icon: Icon(Icons.keyboard_arrow_down_rounded), // Custom icon
                                    isExpanded: true, // Make the dropdown items fill the container width
                                    items: durations.map((duration)=>DropdownMenuItem(
                                      value: duration,
                                      child: Text(
                                        style: TextStyle(fontSize: 12.sp),
                                        duration,
                                      ),
                                    )).toList(),
                                    onChanged: (value) {
                                      // Handle the selected value
                                    },
                                  ),
                                ),
                                Spacer(),
                                Text("${activity.fees.toInt()} EGP", style: TextStyle(color: Color(0xffB68B26)),)
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                  .toList(),
        ),
      ],
    );
  }
}
