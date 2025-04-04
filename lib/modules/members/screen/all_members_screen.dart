part of '../import/members_module_import.dart';

class AllMembersScreen extends StatefulWidget {
  final MembersModuleBloc bloc;

  const AllMembersScreen({super.key, required this.bloc});

  @override
  AllMembersScreenState createState() => AllMembersScreenState(bloc);
}

class AllMembersScreenState
    extends BaseScreen<MembersModuleBloc, AllMembersScreen, dynamic> {
  AllMembersScreenState(super.bloc);

  final TextEditingController searchController = TextEditingController();

  @override
  bool? get ignoreSafeArea => true;

  @override
  bool get ignoreScaffold => true;

  CancelFunc? cancelFunc;

  @override
  void showLoading() {
    super.closeKeyboard();
    cancelFunc?.call();
    cancelFunc = BotToast.showCustomLoading(
      toastBuilder: (cancelFunc) {
        this.cancelFunc = cancelFunc; // Store the cancel function here
        return Center(
          child: Stack(
            alignment: Alignment.center,
            children: [
              Container(
                // Full-screen overlay
                width: double.infinity,
                height: double.infinity,
                color: Colors.black54,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    "assets/images/falcon_logo.png",
                    fit: BoxFit.cover,
                    height: 200.h,
                  ),
                  SizedBox(
                    width: 80.w,
                    child: LinearProgressIndicator(color: Colors.red),
                  ),
                  // Custom color
                ],
              ),
            ],
          ),
        );
      },
      backgroundColor: Colors.transparent, // Remove default overlay
      allowClick: false, // Prevent taps
    );
  }

  @override
  void hideLoading() {
    cancelFunc?.call();
  }

  bool canSearch = true;

  final GlobalKey<MemberFullDetailsState> _key = GlobalKey();

  void triggerRebuild() {
    _key.currentState
        ?.memberFullDetailsRebuild(); // Triggering setState in the child widget
  }

  @override
  Widget buildWidget(BuildContext context, RenderDataState state) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8.h, horizontal: 8.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          MySearchBar(
            canSearch: canSearch,
            onChanged: (value) => bloc.add(SearchForMembersEvent(value)),
            searchController: searchController,
          ),
          DefaultTabController(
            length: Sport.values.length + 1,
            child: TabBar(
              tabAlignment: TabAlignment.start,
              onTap: (index) {
                if (index == 0) {
                  canSearch = true;
                  // bloc.add(GetMembersEvent());
                  bloc.add(FilterMembersEvent(null));
                } else {
                  canSearch = false;
                  bloc.add(
                    FilterMembersEvent(Sport.values[index - 1].displayName),
                  );
                }
              },
              isScrollable: true,
              indicatorPadding: EdgeInsets.zero,
              labelPadding: const EdgeInsets.symmetric(horizontal: 5),
              padding: const EdgeInsets.only(top: 8, bottom: 8),
              indicatorColor: Colors.transparent,
              dividerColor: Colors.transparent,
              tabs: [
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 8, vertical: 5),
                  decoration: BoxDecoration(
                    color: context.colorScheme.secondary,
                    borderRadius: BorderRadius.circular(25.r),
                  ),
                  child: Text(
                    "All Sports",
                    style: TextStyle().copyWith(
                      fontFamily: "Anton_SC",
                      fontSize: 13.sp,
                    ),
                  ),
                ),
                ...Sport.values.map(
                  (sport) => Container(
                    padding: EdgeInsets.symmetric(horizontal: 8, vertical: 5),
                    decoration: BoxDecoration(
                      color: context.colorScheme.secondary,
                      borderRadius: BorderRadius.circular(25.r),
                    ),
                    child: Text(
                      sport.displayName,
                      style: TextStyle().copyWith(
                        fontFamily: "Anton_SC",
                        fontSize: 13.sp,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 5.h),
          state is MembersLoaded
              ? AllMembersScreenBody(
                builder:
                    (context, index) => MemberBrief(
                      onTap: () {
                        bloc.add(
                          ShowMemberDetailsEvent(
                            index: index,
                            list: state.members,
                          ),
                        );
                      },
                      member: state.members[index],
                    ),
                itemCount: state.members.length,
              )
              : state is MembersFiltered
              ? AllMembersScreenBody(
                builder:
                    (context, index) => MemberBrief(
                      onTap: () {
                        bloc.add(
                          ShowMemberDetailsEvent(
                            index: index,
                            list: state.filteredMembers,
                          ),
                        );
                      },
                      member: state.filteredMembers[index],
                    ),
                itemCount: state.filteredMembers.length,
              )
              : SizedBox(),
        ],
      ),
    );
  }

  @override
  void listenToState(BuildContext context, BaseState state) {
    if (state is MemberDeleted) {
      ToastHelper.showToast("Member Deleted", type: ToastType.success);
    }

    if (state is MemberDetails) {
      var expandedMember = state.list[state.index];

      CoreSheet.showCupertino(
        expand: true,
        enableDrag: true,
        backgroundColor: context.colorScheme.secondary,
        child: MemberFullDetails(
          key: _key,
          member: expandedMember,
          onCancelTapped: (subscription) {
            showDialog(
              context: context,
              builder:
                  (context) => CriticalActionDialogue(
                    message:
                        expandedMember.subscriptions.length == 1
                            ? "member will be deleted"
                            : "Amount will be deducted from revenue",
                    onConfirmTapped: () {
                      if (expandedMember.subscriptions.length == 1) {
                        bloc.add(DeleteMemberEvent(id: expandedMember.id!));
                        context.pop();
                      } else {
                        bloc.add(
                          CancelSubscriptionEvent(
                            id: expandedMember.id!,
                            subscription: subscription,
                          ),
                        );
                        expandedMember.subscriptions.remove(subscription);
                        triggerRebuild();
                      }
                      context.pop();
                    },
                  ),
            );
          },
          onSettleTapped: (subscription) {
            showDialog(
              context: context,
              builder:
                  (context) => CriticalActionDialogue(
                    message: "Amount will be added to revenue",
                    onConfirmTapped: () {
                      subscription.paidAmount =
                          subscription.paidAmount + subscription.dueAmount!;
                      subscription.dueAmount = 0;
                      bloc.add(
                        SettleSubscriptionEvent(
                          id: expandedMember.id!,
                          subscription: subscription,
                        ),
                      );
                      triggerRebuild();
                      context.pop();
                    },
                  ),
            );
          },
          onDeleteTapped: () {
            showDialog(
              context: context,
              builder:
                  (context) => CriticalActionDialogue(
                    message: "member will be deleted",
                    onConfirmTapped: () {
                      context.pop();
                      bloc.add(DeleteMemberEvent(id: expandedMember.id!));
                      context.pop();
                    },
                  ),
            );
          },
          onEditTapped: () {
            showDialog(
              context: context,
              builder:
                  (context) => EditMemberDialogue(
                    onConfirmTapped: (editedMember) {
                      if (Member.toJson(expandedMember) !=
                          Member.toJson(editedMember)) {
                        expandedMember = editedMember;
                        triggerRebuild();
                        context.pop();
                        bloc.add(EditMemberEvent(member: editedMember));
                      }
                    },
                    member: expandedMember,
                  ),
            );
          },
          onAddSubscriptionTapped: () {},
        ),
      );
    }
  }
}
