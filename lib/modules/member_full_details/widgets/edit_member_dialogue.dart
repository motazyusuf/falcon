import 'package:easy_localization/easy_localization.dart';
import 'package:falcon_project/core/extensions/string_extentions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:opticore/opticore.dart';

import '../../../core/config/translations/codegen_loader.g.dart';
import '../../../core/network/model/member_model.dart';

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
                    hintText: member.name.firstNameOnly,
                  ),
                ),
                10.ph,
                TextFormField(
                  style: context.textTheme.bodyLarge,
                  controller: lastNameController,
                  decoration: InputDecoration(
                    hintText: member.name.lastNameOnly,
                  ),
                ),
                10.ph,
                TextFormField(
                  style: context.textTheme.bodyLarge,
                  controller: phoneController,
                  decoration: InputDecoration(
                    hintText: "0${member.phoneNumber}",
                  ),
                  keyboardType: TextInputType.phone,
                ),
                10.ph,
                TextFormField(
                  style: context.textTheme.bodyLarge,
                  controller: notesController,
                  decoration: InputDecoration(
                    hintText:
                        member.extraNotes!.isNotEmpty &&
                                member.extraNotes! != " "
                            ? member.extraNotes
                            : LocaleKeys.extra_notes.tr(),
                  ),
                ),
                40.ph,
                CoreButton(
                  title: LocaleKeys.confirm.tr(),
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
                10.ph,
                CoreButton(
                  title: LocaleKeys.cancel.tr(),
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
    String originalFirst = member.name.firstNameOnly;
    String originalLast = member.name.lastNameOnly;

    String updatedFirst = firstNameController.text.trim();
    String updatedLast = lastNameController.text.trim();

    if (updatedFirst != originalFirst || updatedLast != originalLast) {
      member.name =
          "${updatedFirst.isEmpty ? originalFirst : updatedFirst} ${updatedLast.isEmpty ? originalLast : updatedLast}"
              .trim();
    }
  }
}
