part of '../import/add_member_import.dart';

class AddMemberScreen extends StatefulWidget {
  final AddMemberBloc bloc;

  const AddMemberScreen({super.key, required this.bloc});

  @override
  AddMemberScreenState createState() => AddMemberScreenState(bloc);
}

class AddMemberScreenState
    extends BaseScreen<AddMemberBloc, AddMemberScreen, dynamic> {
  AddMemberScreenState(super.bloc);

  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController notesController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController paidAmountController = TextEditingController();
  final TextEditingController dueAmountController = TextEditingController();
  Sport selectedSport = Sport.muayThaiAdvanced;
  DateTime subscriptionDate = DateTime.now();
  DateTime endDate = DateTime.now().add(Duration(days: 30));
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
  List<Subscription> updateMemberSubscriptions = [];
  List<bool> isEndDatePicked = [false];
  List<bool> isEndDatePickedForMemberUpdated = [];
  final _formKey = GlobalKey<FormState>();
  bool memberBeingEdited = false;

  @override
  ScaffoldConfig get scaffoldConfig => ScaffoldConfig(
    appBar: AppBar(
      title: Text("Member inputs"),
      centerTitle: true,
      leading: IconButton(
        onPressed: () => Navigator.pop(context),
        icon: Icon(Icons.arrow_back_ios),
      ),
    ),
  );

  @override
  Widget buildWidget(BuildContext context, RenderDataState state) {
    final argument = ModalRoute.of(context)?.settings.arguments as Member?;
    if (argument != null) {
      memberBeingEdited = true;
    }

    return StatefulBuilder(
      builder:
          (context, newState) => Form(
            key: _formKey,
            child: SingleChildScrollView(
              keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 15.h, horizontal: 15.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextFormField(
                      validator:
                          memberBeingEdited
                              ? null
                              : MyFunctions.validateNotEmpty,
                      style: context.textTheme.bodyLarge,
                      controller: firstNameController,
                      decoration: InputDecoration(
                        hintText:
                            memberBeingEdited
                                ? MyFunctions.getFirstName(argument!.name)
                                : MyStrings.firstName,
                      ),
                    ),
                    SizedBox(height: 10.h),
                    TextFormField(
                      validator:
                          memberBeingEdited
                              ? null
                              : MyFunctions.validateNotEmpty,
                      style: context.textTheme.bodyLarge,
                      controller: lastNameController,
                      decoration: InputDecoration(
                        hintText:
                            memberBeingEdited
                                ? MyFunctions.getLastName(argument!.name)
                                : MyStrings.lastName,
                      ),
                    ),
                    SizedBox(height: 10.h),
                    TextFormField(
                      validator:
                          memberBeingEdited
                              ? null
                              : MyFunctions.validateNotEmpty,
                      style: context.textTheme.bodyLarge,
                      controller: phoneController,
                      decoration: InputDecoration(
                        hintText:
                            memberBeingEdited
                                ? argument!.phoneNumber.toString()
                                : MyStrings.phoneNumber,
                      ),
                      keyboardType: TextInputType.phone,
                    ),
                    SizedBox(height: 10.h),
                    TextFormField(
                      style: context.textTheme.bodyLarge,
                      controller: notesController,
                      decoration: InputDecoration(
                        hintText:
                            memberBeingEdited
                                ? argument!.extraNotes!.isEmpty
                                    ? "Extra Notes"
                                    : argument.extraNotes
                                : MyStrings.extraNotes,
                      ),
                    ),
                    SizedBox(height: 10.h),
                    Visibility(
                      visible: memberBeingEdited,
                      child: Text("Add new subscriptions:"),
                    ),
                    StatefulBuilder(
                      builder: (context, newState) {
                        return SizedBox(
                          height: 230.h,
                          child: ListView.separated(
                            itemCount:
                                memberBeingEdited
                                    ? updateMemberSubscriptions.length
                                    : subscriptions.length,
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (context, index) {
                              return SubscriptionItem(
                                pickedStartDate:
                                    subscriptions[index].subscriptionDate,
                                onSportChanged: (newSport) {
                                  setState(() {
                                    memberBeingEdited
                                        ? updateMemberSubscriptions[index]
                                            .sport = newSport!
                                        : subscriptions[index].sport =
                                            newSport!;
                                  });
                                },
                                onEndDateChanged: (tabIndex) {
                                  newState(() {
                                    memberBeingEdited
                                        ? isEndDatePickedForMemberUpdated[index] =
                                            true
                                        : isEndDatePicked[index] = true;

                                    if (tabIndex == 0) {
                                      memberBeingEdited
                                          ? updateMemberSubscriptions[index]
                                              .endDate = subscriptions[index]
                                              .subscriptionDate
                                              .add(Duration(days: 30))
                                          : subscriptions[index]
                                              .endDate = subscriptions[index]
                                              .subscriptionDate
                                              .add(Duration(days: 30));
                                    } else if (tabIndex == 1) {
                                      memberBeingEdited
                                          ? updateMemberSubscriptions[index]
                                              .endDate = subscriptions[index]
                                              .subscriptionDate
                                              .add(Duration(days: 60))
                                          : subscriptions[index]
                                              .endDate = subscriptions[index]
                                              .subscriptionDate
                                              .add(Duration(days: 60));
                                    } else {
                                      memberBeingEdited
                                          ? updateMemberSubscriptions[index]
                                              .endDate = subscriptions[index]
                                              .subscriptionDate
                                              .add(Duration(days: 90))
                                          : subscriptions[index]
                                              .endDate = subscriptions[index]
                                              .subscriptionDate
                                              .add(Duration(days: 90));
                                    }
                                  });
                                },
                                onStartDateChanged: () async {
                                  DateTime? pickedDate = await showDatePicker(
                                    context: context,
                                    initialDate:
                                        subscriptions[index].subscriptionDate,
                                    firstDate: DateTime(2000),
                                    lastDate: DateTime(2101),
                                  );
                                  if (pickedDate != null) {
                                    setState(() {
                                      memberBeingEdited
                                          ? updateMemberSubscriptions[index]
                                              .subscriptionDate = pickedDate
                                          : subscriptions[index]
                                              .subscriptionDate = pickedDate;
                                    });
                                  }
                                },
                                onPaidAmountChanged: (value) {
                                  memberBeingEdited
                                      ? updateMemberSubscriptions[index]
                                          .paidAmount = num.tryParse(value) ?? 0
                                      : subscriptions[index].paidAmount =
                                          num.tryParse(value) ?? 0;
                                },
                                onDueAmountChanged: (value) {
                                  memberBeingEdited
                                      ? updateMemberSubscriptions[index]
                                          .dueAmount = num.tryParse(value) ?? 0
                                      : subscriptions[index].dueAmount =
                                          num.tryParse(value) ?? 0;
                                },
                                onSubscriptionRemoved: () {
                                  newState(() {
                                    if (memberBeingEdited) {
                                      updateMemberSubscriptions.removeAt(index);
                                      isEndDatePickedForMemberUpdated.removeAt(
                                        index,
                                      );
                                    } else {
                                      subscriptions.removeAt(index);
                                      isEndDatePicked.removeAt(index);
                                    }
                                  });
                                },
                                index: index,
                                isEndDatePicked:
                                    memberBeingEdited
                                        ? isEndDatePickedForMemberUpdated
                                        : isEndDatePicked,
                              );
                            },
                            separatorBuilder:
                                (context, index) => SizedBox(width: 10.w),
                          ),
                        );
                      },
                    ),
                    SizedBox(height: 25.h),
                    CoreButton(
                      title: MyStrings.addAnotherSubscription,
                      backgroundColor: context.colorScheme.secondaryContainer,
                      onTap: () {
                        newState(() {
                          memberBeingEdited
                              ? updateMemberSubscriptions.add(
                                Subscription(
                                  sport: Sport.values.first,
                                  subscriptionDate: DateTime.now(),
                                  endDate: DateTime.now().add(
                                    Duration(days: 30),
                                  ),
                                  paidAmount: 0,
                                  dueAmount: 0,
                                ),
                              )
                              : subscriptions.add(
                                Subscription(
                                  sport: Sport.values.first,
                                  subscriptionDate: DateTime.now(),
                                  endDate: DateTime.now().add(
                                    Duration(days: 30),
                                  ),
                                  paidAmount: 0,
                                  dueAmount: 0,
                                ),
                              );
                          memberBeingEdited
                              ? isEndDatePickedForMemberUpdated.add(false)
                              : isEndDatePicked.add(false);
                        });
                      },
                    ),
                    SizedBox(height: 10.h),
                    CoreButton(
                      title:
                          memberBeingEdited
                              ? "Update Member"
                              : MyStrings.addMember,
                      onTap: () {
                        if (_formKey.currentState!.validate()) {
                          if (isEndDatePicked.contains(false)) {
                            bloc.add(AddMemberWithNoEndDateEvent());
                            return;
                          }
                          bloc.add(
                            AddMemberEvent(
                              Member(
                                id: "",
                                extraNotes: notesController.text,
                                name:
                                    "${firstNameController.text} ${lastNameController.text}",
                                phoneNumber: phoneController.text.toIntOrNull!,
                                subscriptions: subscriptions,
                              ),
                            ),
                          );
                        }
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
    );
  }

  @override
  void listenToState(BuildContext context, BaseState state) {
    CancelFunc? cancelFunc;
    if (state is LoadingStateNonRender) {
      cancelFunc = MyFunctions.showLoading();
    }
    if (state is EndLoadingStateNonRender) {
      cancelFunc?.call();
      ToastHelper.showToast("Member Added", type: ToastType.success);
      context.pop();
    }
    if (state is NoEndDate) {
      ToastHelper.showToast("Months required", type: ToastType.error);
    }
  }
}
