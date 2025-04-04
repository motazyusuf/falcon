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
  List<bool> isEndDatePicked = [false];
  final _formKey = GlobalKey<FormState>();

  @override
  ScaffoldConfig get scaffoldConfig => ScaffoldConfig(
    appBar: AppBar(
      title: Text("Add Member"),
      centerTitle: true,
      leading: IconButton(
        onPressed: () => Navigator.pop(context),
        icon: Icon(Icons.arrow_back_ios),
      ),
    ),
  );


  @override
  Widget buildWidget(BuildContext context, RenderDataState state) {
    return StatefulBuilder(
      builder:
          (context, newState) =>
          Form(
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
                      validator: MyFunctions.validateNotEmpty,
                      style: context.textTheme.bodyLarge,
                      controller: firstNameController,
                      decoration: InputDecoration(
                        hintText: MyStrings.firstName,
                      ),
                    ),
                    SizedBox(height: 10.h),
                    TextFormField(
                      validator: MyFunctions.validateNotEmpty,
                      style: context.textTheme.bodyLarge,
                      controller: lastNameController,
                      decoration: InputDecoration(hintText: MyStrings.lastName),
                    ),
                    SizedBox(height: 10.h),
                    TextFormField(
                      validator: MyFunctions.validateNotEmpty,
                      style: context.textTheme.bodyLarge,
                      controller: phoneController,
                      decoration: InputDecoration(
                        hintText: MyStrings.phoneNumber,
                      ),
                      keyboardType: TextInputType.phone,
                    ),
                    SizedBox(height: 10.h),
                    TextFormField(
                      style: context.textTheme.bodyLarge,
                      controller: notesController,
                      decoration: InputDecoration(
                        hintText: MyStrings.extraNotes,
                      ),
                      keyboardType: TextInputType.phone,
                    ),
                    SizedBox(height: 10.h),
                    StatefulBuilder(
                      builder: (context, newState) {
                        return SizedBox(
                          height: 230.h,
                          child: ListView.separated(
                            itemCount: subscriptions.length,
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (context, index) {
                              return SubscriptionItem(
                                pickedStartDate:
                                subscriptions[index].subscriptionDate,
                                onSportChanged: (newSport) {
                                  setState(() {
                                    subscriptions[index].sport = newSport!;
                                  });
                                },
                                onEndDateChanged: (tabIndex) {
                                  newState(() {
                                    isEndDatePicked[index] = true;
                                    if (tabIndex == 0) {
                                      subscriptions[index]
                                          .endDate = subscriptions[index]
                                          .subscriptionDate
                                          .add(Duration(days: 30));
                                    } else if (tabIndex == 1) {
                                      subscriptions[index]
                                          .endDate = subscriptions[index]
                                          .subscriptionDate
                                          .add(Duration(days: 60));
                                    } else {
                                      subscriptions[index]
                                          .endDate = subscriptions[index]
                                          .subscriptionDate
                                          .add(Duration(days: 90));
                                    }
                                  });
                                },
                                onStartDateChanged: () async
                                {
                                  DateTime? pickedDate = await showDatePicker(
                                    context: context,
                                    initialDate:
                                    subscriptions[index].subscriptionDate,
                                    firstDate: DateTime(2000),
                                    lastDate: DateTime(2101),
                                  );
                                  if (pickedDate != null) {
                                    setState(() {
                                      subscriptions[index].subscriptionDate =
                                          pickedDate;
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
                                  newState(() {
                                    subscriptions.removeAt(index);
                                    isEndDatePicked.removeAt(index);
                                  });
                                },
                                index: index,
                                isEndDatePicked: isEndDatePicked,
                              );
                            },
                            separatorBuilder:
                                (context, index) => SizedBox(width: 10.w),
                          ),
                        );
                      },
                    ),
                    SizedBox(height: 40.h),
                    CoreButton(
                      title: MyStrings.addAnotherSubscription,
                      backgroundColor: context.colorScheme.secondaryContainer,
                      onTap: () {
                        newState(() {
                          subscriptions.add(
                            Subscription(
                              sport: Sport.values.first,
                              subscriptionDate: DateTime.now(),
                              endDate: DateTime.now().add(Duration(days: 30)),
                              paidAmount: 0,
                              dueAmount: 0,
                            ),
                          );
                          isEndDatePicked.add(false);
                        });
                      },
                    ),
                    SizedBox(height: 10.h),
                    CoreButton(
                      title: MyStrings.addMember,
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
                                name: "${firstNameController
                                    .text} ${lastNameController.text}",
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
      ToastHelper.showToast(
        "Months required",
        type: ToastType.error,
      );
    }
  }
}
