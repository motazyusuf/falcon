import 'package:falcon_project/core/constants/my_strings.dart';
import 'package:falcon_project/core/functions/my_functions.dart';
import 'package:falcon_project/main_layout/widgets/subscription_item.dart';
import 'package:falcon_project/modules/members/import/members_module_import.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:opticore/opticore.dart';

import '../core/enums/sport_enum.dart';
import '../network/member_model.dart';

class AddMember extends StatefulWidget {
  const AddMember({super.key});

  @override
  State<AddMember> createState() => _AddUserState();
}

class _AddUserState extends State<AddMember> {
  final TextEditingController firstNameController = TextEditingController();

  final TextEditingController lastNameController = TextEditingController();

  final TextEditingController phoneController = TextEditingController();

  Sport selectedSport = Sport.muayThaiAdvanced;

  DateTime subscriptionDate = DateTime.now();

  DateTime endDate = DateTime.now().add(Duration(days: 30));

  TextEditingController paidAmountController = TextEditingController();

  TextEditingController dueAmountController = TextEditingController();
  List<Subscription> subscriptions = [
    Subscription(
      sport: Sport.values.first,
      // Default sport
      subscriptionDate: DateTime.now(),
      endDate: DateTime.now().add(Duration(days: 30)),
      // Default 1 month
      paidAmount: 0,
      dueAmount: 0,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return BlocListener<MembersModuleBloc, BaseState>(
      listener: (context, state) {
        CancelFunc? cancelFunc;
        if (state is LoadingStateNonRender) {
          cancelFunc = MyFunctions.showLoading();
        }
        if (state is EndLoadingStateNonRender) {
          cancelFunc?.call();
          context.pop();
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(MyStrings.addMember),
          centerTitle: true,
          leading: IconButton(
            onPressed: () => Navigator.pop(context),
            icon: Icon(Icons.arrow_back_ios),
          ),
        ),
        body: Padding(
          padding: EdgeInsets.symmetric(vertical: 15.h, horizontal: 15.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextFormField(
                style: context.textTheme.bodyLarge,
                controller: firstNameController,
                decoration: InputDecoration(hintText: MyStrings.firstName),
              ),
              SizedBox(height: 20.h),
              TextFormField(
                style: context.textTheme.bodyLarge,
                controller: lastNameController,
                decoration: InputDecoration(hintText: MyStrings.lastName),
              ),
              SizedBox(height: 20.h),
              TextFormField(
                style: context.textTheme.bodyLarge,
                controller: phoneController,
                decoration: InputDecoration(hintText: MyStrings.phoneNumber),
                keyboardType: TextInputType.phone,
              ),
              SizedBox(height: 20.h),
              Expanded(
                child: FlexibleGridView(
                  crossAxisSpacing: 5.w,
                  mainAxisSpacing: 1.h,
                  builder: (context, index) {
                    return SubscriptionItem(
                      index: index,
                      subscriptions: subscriptions,
                      onSportChanged: (newSport) {
                        setState(() {
                          subscriptions[index].sport = newSport!;
                        });
                      },
                      onEndDateChanged: () async {
                        DateTime? pickedDate = await showDatePicker(
                          context: context,
                          initialDate: subscriptions[index].subscriptionDate
                              .add(Duration(days: 30)),
                          firstDate: DateTime(2000),
                          lastDate: DateTime(2101),
                        );
                        if (pickedDate != null) {
                          setState(() {
                            subscriptions[index].endDate = pickedDate;
                          });
                        }
                      },
                      onStartDateChanged: () async {
                        DateTime? pickedDate = await showDatePicker(
                          context: context,
                          initialDate: subscriptions[index].subscriptionDate,
                          firstDate: DateTime(2000),
                          lastDate: DateTime(2101),
                        );
                        if (pickedDate != null) {
                          setState(() {
                            subscriptions[index].subscriptionDate = pickedDate;
                          });
                        }
                      },
                      onPaidAmountChanged: (value) {
                        subscriptions[index].paidAmount =
                            num.tryParse(value) ?? 0;
                      },
                      onDueAmountChanged: (value) {
                        subscriptions[index].dueAmount =
                            num.tryParse(value) ?? 0;
                      },
                      onSubscriptionRemoved: () {
                        setState(() {
                          subscriptions.removeAt(index);
                        });
                      },
                    );
                  },
                  itemCount: subscriptions.length,
                  crossAxisCount: 2,
                ),
              ),
              CoreButton(
                title: MyStrings.addAnotherSubscription,
                backgroundColor: context.colorScheme.secondaryContainer,
                onTap: () {
                  setState(() {
                    subscriptions.add(
                      Subscription(
                        sport: Sport.values.first,
                        // Default sport
                        subscriptionDate: DateTime.now(),
                        endDate: DateTime.now().add(Duration(days: 30)),
                        // Default 1 month
                        paidAmount: 0,
                        dueAmount: 0,
                      ),
                    );
                  });
                },
              ),
              SizedBox(height: 20.h),
              CoreButton(
                title: MyStrings.addMember,
                onTap: () {
                  BlocProvider.of<MembersModuleBloc>(context).add(
                    AddMemberEvent(
                      Member(
                        id: "",
                        firstName: firstNameController.text,
                        lastName: lastNameController.text,
                        isActive: true,
                        phoneNumber: phoneController.text.toIntOrNull!,
                        subscriptions: subscriptions,
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
