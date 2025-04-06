import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:opticore/opticore.dart';

import '../../../../../core/constants/my_strings.dart';
import '../../../../../core/functions/my_functions.dart';
import '../../../../../network/member_model.dart';

class EditMemberDialogue extends StatelessWidget {
  EditMemberDialogue({
    super.key,
    required this.onConfirmTapped,
    required this.member,
  });

  Function(Member) onConfirmTapped;
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController notesController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  Member member;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      child: Container(
        color: context.secondaryColor,
        child: SingleChildScrollView(
          keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 15.h, horizontal: 15.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextFormField(
                  style: context.textTheme.bodyLarge,
                  controller: firstNameController,
                  decoration: InputDecoration(
                    hintText: MyFunctions.getFirstName(member.name),
                  ),
                ),
                SizedBox(height: 10.h),
                TextFormField(
                  style: context.textTheme.bodyLarge,
                  controller: lastNameController,
                  decoration: InputDecoration(
                    hintText: MyFunctions.getLastName(member.name),
                  ),
                ),
                SizedBox(height: 10.h),
                TextFormField(
                  style: context.textTheme.bodyLarge,
                  controller: phoneController,
                  decoration: InputDecoration(
                    hintText: "0${member.phoneNumber}",
                  ),
                  keyboardType: TextInputType.phone,
                ),
                SizedBox(height: 10.h),
                TextFormField(
                  style: context.textTheme.bodyLarge,
                  controller: notesController,
                  decoration: InputDecoration(
                    hintText:
                        member.extraNotes!.isNotEmpty &&
                                member.extraNotes! != " "
                            ? member.extraNotes
                            : MyStrings.extraNotes,
                  ),
                ),
                SizedBox(height: 40.h),
                CoreButton(
                  title: "Confirm",
                  onTap: () {
                    updateMemberName(member);
                    if (phoneController.text.isNotEmpty) {
                      member.phoneNumber = num.parse(phoneController.text);
                    }
                    if (notesController.text.isNotEmpty) {
                      member.extraNotes = notesController.text;
                    }
                    onConfirmTapped(member);
                  },
                ),
                SizedBox(height: 10.h),
                CoreButton(
                  title: "Cancel",
                  backgroundColor: context.colorScheme.secondaryContainer,
                  onTap: () {
                    context.pop();
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void updateMemberName(Member member) {
    String originalFirst = MyFunctions.getFirstName(member.name);
    String originalLast = MyFunctions.getLastName(member.name);

    String updatedFirst = firstNameController.text.trim();
    String updatedLast = lastNameController.text.trim();

    if (updatedFirst != originalFirst || updatedLast != originalLast) {
      member.name =
          "${updatedFirst.isEmpty ? originalFirst : updatedFirst} ${updatedLast.isEmpty ? originalLast : updatedLast}"
              .trim();
    }
  }
}
