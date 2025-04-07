import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:opticore/opticore.dart';

import '../../../../../core/constants/my_strings.dart';
import '../../../../../core/enums/sport_enum.dart';
import '../../../../../core/functions/my_functions.dart';
import '../../../../../network/member_model.dart';

class AddSubscriptionDialogue extends StatefulWidget {
  AddSubscriptionDialogue({
    super.key,
    required this.onConfirmTapped,
    required this.member,
  });

  Function(Member) onConfirmTapped;

  Member member;

  @override
  State<AddSubscriptionDialogue> createState() =>
      _AddSubscriptionDialogueState();
}

class _AddSubscriptionDialogueState extends State<AddSubscriptionDialogue> {
  final TextEditingController paidAmountController = TextEditingController();

  final TextEditingController dueAmountController = TextEditingController();

  Sport selectedSport = Sport.muayThaiAdvanced;

  DateTime subscriptionDate = DateTime.now();

  DateTime endDate = DateTime.now().add(Duration(days: 30));

  Subscription subscription = Subscription(
    sport: Sport.values.first,
    // Default sport
    subscriptionDate: DateTime.now(),
    endDate: DateTime.now().add(Duration(days: 30)),
    // Default 1 month
    paidAmount: 0,
    dueAmount: 0,
  );

  bool isEndDatePicked = false;

  final key = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: key,
      child: Dialog(
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
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      DropdownButtonFormField<Sport>(
                        menuMaxHeight: 250.h,
                        dropdownColor: context.colorScheme.secondaryContainer,
                        value: Sport.values[0],
                        items:
                            Sport.values.map((sport) {
                              return DropdownMenuItem(
                                value: sport,
                                child: Text(
                                  sport.displayName,
                                  style: TextStyle().copyWith(fontSize: 15.sp),
                                ),
                              );
                            }).toList(),
                        onChanged: (sport) {
                          subscription.sport = sport;
                        },
                      ),
                      SizedBox(height: 10.h),
                      // Subscription Start Date
                      GestureDetector(
                        onTap:
                            isEndDatePicked
                                ? null
                                : () async {
                                  DateTime? pickedDate = await showDatePicker(
                                    context: context,
                                    initialDate: subscription.subscriptionDate,
                                    firstDate: DateTime(2000),
                                    lastDate: DateTime(2101),
                                  );
                                  if (pickedDate != null) {
                                    setState(() {
                                      subscription.subscriptionDate =
                                          pickedDate;
                                    });
                                  }
                                },
                        child: Text(
                          "${MyStrings.startDate}:"
                          " ${subscription.subscriptionDate.toString().substring(0, 10)}",
                          style: context.textTheme.displaySmall?.copyWith(
                            fontSize: 12.sp,
                            color:
                                isEndDatePicked
                                    ? context.colorScheme.secondaryContainer
                                    : null,
                          ),
                        ),
                      ),

                      SizedBox(height: 15.h),
                      DefaultTabController(
                        length: 4,
                        child: TabBar(
                          onTap: (tabIndex) {
                            setState(() {
                              isEndDatePicked = true;
                              if (tabIndex == 0) {
                                subscription.endDate = subscription
                                    .subscriptionDate
                                    .add(Duration(days: 30));
                              } else if (tabIndex == 1) {
                                subscription.endDate = subscription
                                    .subscriptionDate
                                    .add(Duration(days: 60));
                              } else {
                                subscription.endDate = subscription
                                    .subscriptionDate
                                    .add(Duration(days: 90));
                              }
                            });
                          },
                          tabAlignment: TabAlignment.center,
                          physics: const ClampingScrollPhysics(),
                          padding: EdgeInsets.zero,
                          isScrollable: true,
                          // onTap: onEndDateChanged,
                          indicatorPadding: EdgeInsets.zero,
                          labelPadding: EdgeInsets.zero,
                          indicatorColor: Colors.transparent,
                          dividerColor: Colors.transparent,
                          tabs: [
                            Container(
                              decoration: BoxDecoration(
                                color: context.colorScheme.secondary,
                                borderRadius: BorderRadius.circular(25.r),
                              ),
                              child: Text(
                                "",
                                style: TextStyle().copyWith(
                                  fontFamily: "Anton_SC",
                                  fontSize: 10.sp,
                                ),
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.symmetric(horizontal: 5.w),
                              decoration: BoxDecoration(
                                color: context.colorScheme.secondary,
                                borderRadius: BorderRadius.circular(25.r),
                              ),
                              child: Text(
                                "Month",
                                style: TextStyle().copyWith(
                                  fontFamily: "Anton_SC",
                                  fontSize: 10.sp,
                                ),
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.symmetric(horizontal: 5.w),
                              decoration: BoxDecoration(
                                color: context.colorScheme.secondary,
                                borderRadius: BorderRadius.circular(25.r),
                              ),
                              child: Text(
                                "2 Months",
                                style: TextStyle().copyWith(
                                  fontFamily: "Anton_SC",
                                  fontSize: 10.sp,
                                ),
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.symmetric(horizontal: 5.w),

                              decoration: BoxDecoration(
                                color: context.colorScheme.secondary,
                                borderRadius: BorderRadius.circular(25.r),
                              ),
                              child: Text(
                                "3 months",
                                style: TextStyle().copyWith(
                                  fontFamily: "Anton_SC",
                                  fontSize: 10.sp,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),

                      // Paid Amount
                      TextFormField(
                        validator: MyFunctions.validateNotEmpty,
                        style: context.textTheme.displaySmall?.copyWith(
                          fontSize: 12.sp,
                        ),
                        decoration: InputDecoration(
                          hintText: MyStrings.paidAmount,
                        ),
                        keyboardType: TextInputType.number,
                        onChanged: (value) {
                          subscription.paidAmount = value.toInt();
                        },
                      ),

                      // Due Amount
                      TextFormField(
                        style: context.textTheme.displaySmall?.copyWith(
                          fontSize: 12.sp,
                        ),
                        decoration: InputDecoration(
                          hintText: MyStrings.dueAmount,
                        ),
                        keyboardType: TextInputType.number,
                        onChanged: (value) {
                          subscription.dueAmount = value.toInt();
                        },
                      ),
                    ],
                  ),
                  SizedBox(height: 40.h),
                  CoreButton(
                    title: "Confirm",
                    onTap: () {
                      if (key.currentState!.validate() && isEndDatePicked) {
                        widget.member.subscriptions.add(subscription);
                        widget.onConfirmTapped(widget.member);
                      } else {
                        ToastHelper.showToast(
                          "Check End Date And Paid Amount",
                          type: ToastType.error,
                        );
                      }
                      context.pop();
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
      ),
    );
  }
}
