part of '../import/member_full_details_import.dart';

class MemberFullDetailsScreen extends StatefulWidget {
  final MemberFullDetailsBloc bloc;
  Member member;

  MemberFullDetailsScreen({
    super.key,
    required this.bloc,
    required this.member,
  });

  @override
  _MemberFullDetailsScreenState createState() =>
      _MemberFullDetailsScreenState(bloc);
}

class _MemberFullDetailsScreenState
    extends
        BaseScreen<MemberFullDetailsBloc, MemberFullDetailsScreen, dynamic> {
  _MemberFullDetailsScreenState(super.bloc);

  bool isActive = false;

  @override
  bool get ignoreScaffold => false;

  CancelFunc? cancelFunc;

  @override
  void showLoading() {
    super.closeKeyboard();
    cancelFunc?.call();
    cancelFunc =  AppHelper.showCustomLoading();
  }

  @override
  void hideLoading() {
    cancelFunc?.call();
  }

  @override
  ScaffoldConfig get scaffoldConfig => ScaffoldConfig(backgroundColor: context.colorScheme.secondary);

  @override
  Widget buildWidget(BuildContext context, RenderDataState state) {
    print(state.toString());
    if (state is DetailsLoaded) {
      return SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.only(left: 30.w),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    InkWell(child: Icon(Icons.arrow_back_ios),onTap: ()=> context.pop(),),
                    Expanded(
                      child: Text(
                        textAlign: TextAlign.center,
                        widget.member.name,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 30.sp,
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        showDialog(
                          context: context,
                          builder:
                              (context) => EditMemberDialogue(
                                onConfirmTapped: (editedMember) {
                                  if (Member.toJson(widget.member) !=
                                      Member.toJson(editedMember)) {
                                    widget.member = editedMember;
                                    context.pop();
                                    postEvent(
                                      EditMemberEvent(member: editedMember),
                                    );
                                  }
                                },
                                member: widget.member,
                              ),
                        );
                      },
                      child: Icon(Icons.edit),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                child: AdvancedLine(
                  direction: Axis.horizontal,
                  line: SolidLine(),
                  paintDef:
                      Paint()
                        ..color = context.colorScheme.primary
                        ..strokeWidth = 2.h,
                ),
              ),
              10.ph,
              Text(
                "${LocaleKeys.phone_number.tr()}:  0${widget.member.phoneNumber}",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 23.sp),
              ),
              10.ph,
              Visibility(
                visible:
                    widget.member.extraNotes!.isNotEmpty &&
                            widget.member.extraNotes! != " "
                        ? true
                        : false,
                child: Text(
                  "${LocaleKeys.extra_notes.tr()}:  ${widget.member.extraNotes}",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 15.sp,
                  ),
                ),
              ),
              SizedBox(
                height:
                    widget.member.extraNotes!.isNotEmpty &&
                            widget.member.extraNotes! != " "
                        ? 10.h
                        : 0,
              ),
              Row(
                children: [
                  Expanded(child: Text("${LocaleKeys.sub_history.tr()}: ")),
                  GestureDetector(
                    onTap: () {
                      showDialog(
                        context: context,
                        builder:
                            (context) => AddSubscriptionDialogue(
                              onConfirmTapped: (editedMember) {
                                if (Member.toJson(widget.member) !=
                                    Member.toJson(editedMember)) {
                                  widget.member = editedMember;
                                  ToastHelper.showToast(
                                    "Subscription Added",
                                    type: ToastType.success,
                                  );
                                  postEvent(
                                    EditMemberEvent(member: editedMember),
                                  );
                                }
                              },
                              member: widget.member,
                            ),
                      );
                    },
                    child: Icon(Icons.add),
                  ),
                ],
              ),
              5.ph,
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children:
                    widget.member.subscriptions.map((sub) {
                      isActive = false;
                      if (sub.endDate.isAfter(DateTime.now())) {
                        isActive = true;
                      }
                      return SubscriptionContainer(
                        isActive: isActive,
                        subscription: sub,
                        onCancelTapped:
                            isActive
                                ? () {
                                  showDialog(
                                    context: context,
                                    builder:
                                        (context) => CriticalActionDialogue(
                                          message:
                                              widget
                                                          .member
                                                          .subscriptions
                                                          .length ==
                                                      1
                                                  ? "member will be deleted"
                                                  : "Amount will be deducted from revenue",
                                          onConfirmTapped: () {
                                            if (widget
                                                    .member
                                                    .subscriptions
                                                    .length ==
                                                1) {
                                              postEvent(
                                                DeleteMemberEvent(
                                                  id: widget.member.id!,
                                                ),
                                              );
                                              context.pop();
                                            } else {
                                              postEvent(
                                                CancelSubscriptionEvent(
                                                  id: widget.member.id!,
                                                  subscription: sub,
                                                ),
                                              );
                                              widget.member.subscriptions
                                                  .remove(sub);
                                            }
                                            context.pop();
                                          },
                                        ),
                                  );
                                }
                                : null,
                        onSettleTapped:
                            isActive && sub.dueAmount != 0
                                ? () {
                              print("Settle Tapped");
                                    showDialog(
                                      context: context,
                                      builder:
                                          (context) =>
                                              CriticalActionDialogue(
                                            message:
                                                "Amount will be added to revenue",
                                            onConfirmTapped: ()
                                            {
                                              sub.paidAmount =
                                                  sub.paidAmount +
                                                  sub.dueAmount!;
                                              sub.dueAmount = 0;
                                              postEvent(
                                                SettleSubscriptionEvent(
                                                  id: widget.member.id!,
                                                  subscription: sub,
                                                ),
                                              );
                                              context.pop();
                                            },
                                          ),
                                    );
                                }
                                : null,
                      );
                    }).toList(),
              ),
              10.ph,
              CoreButton(
                title: LocaleKeys.delete_member.tr(),
                onTap: () {
                  showDialog(
                    context: context,
                    builder:
                        (context) => CriticalActionDialogue(
                          message: "member will be deleted",
                          onConfirmTapped: () {
                            context.pop();
                            postEvent(DeleteMemberEvent(id: widget.member.id!));
                            context.pop();
                          },
                        ),
                  );
                },
              ),
            ],
          ),
        ),
      );
    } else {
      return 10.ph;
    }
  }

  @override
  void listenToState(BuildContext context, BaseState state) {
    print(state.toString());
  }
}
