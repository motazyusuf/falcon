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
  // TODO: implement ignoreScaffold
  bool get ignoreScaffold => true;

  @override
  Widget buildWidget(BuildContext context, RenderDataState state) {
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
                                  bloc.add(
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
            SizedBox(height: 10.h),
            Text(
              "Phone number:  0${widget.member.phoneNumber}",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 23.sp),
            ),
            SizedBox(height: 10.h),
            Visibility(
              visible:
                  widget.member.extraNotes!.isNotEmpty &&
                          widget.member.extraNotes! != " "
                      ? true
                      : false,
              child: Text(
                "Extra Notes:  ${widget.member.extraNotes}",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15.sp),
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
                Expanded(child: Text("Subscriptions history: ")),
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
                                context.pop();
                                ToastHelper.showToast(
                                  "Subscription Added",
                                  type: ToastType.success,
                                );
                                bloc.add(EditMemberEvent(member: editedMember));
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
            SizedBox(height: 5.h),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children:
                  widget.member.subscriptions.map((subscription) {
                    isActive = false;
                    if (subscription.endDate.isAfter(DateTime.now())) {
                      isActive = true;
                    }
                    return SubscriptionContainer(
                      isActive: isActive,
                      subscription: subscription,
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
                                            bloc.add(
                                              DeleteMemberEvent(
                                                id: widget.member.id!,
                                              ),
                                            );
                                            context.pop();
                                          } else {
                                            bloc.add(
                                              CancelSubscriptionEvent(
                                                id: widget.member.id!,
                                                subscription: subscription,
                                              ),
                                            );
                                            widget.member.subscriptions.remove(
                                              subscription,
                                            );
                                          }
                                          context.pop();
                                        },
                                      ),
                                );
                              }
                              : null,
                      onSettleTapped:
                          isActive && subscription.dueAmount != 0
                              ? () {
                                (subscription) {
                                  showDialog(
                                    context: context,
                                    builder:
                                        (context) => CriticalActionDialogue(
                                          message:
                                              "Amount will be added to revenue",
                                          onConfirmTapped: () {
                                            subscription.paidAmount =
                                                subscription.paidAmount +
                                                subscription.dueAmount!;
                                            subscription.dueAmount = 0;
                                            bloc.add(
                                              SettleSubscriptionEvent(
                                                id: widget.member.id!,
                                                subscription: subscription,
                                              ),
                                            );
                                            context.pop();
                                          },
                                        ),
                                  );
                                };
                              }
                              : null,
                    );
                  }).toList(),
            ),
            SizedBox(height: 10.h),
            CoreButton(
              title: "Delete Member",
              onTap: () {
                showDialog(
                  context: context,
                  builder:
                      (context) => CriticalActionDialogue(
                        message: "member will be deleted",
                        onConfirmTapped: () {
                          context.pop();
                          bloc.add(DeleteMemberEvent(id: widget.member.id!));
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
  }

  @override
  void listenToState(BuildContext context, BaseState state) {}
}
