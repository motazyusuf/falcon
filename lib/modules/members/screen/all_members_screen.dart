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
                  bloc.add(GetMembersEvent());
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
          state is MembersLoaded &&
                  bloc.allMembers.isNotEmpty &&
                  searchController.text.isEmpty
              ? AllMembersScreenBody(
                builder:
                    (context, index) => MemberBrief(
                      onTap: () {
                        CoreSheet.showCupertino(
                          expand: true,
                          enableDrag: true,
                          backgroundColor: context.colorScheme.secondary,
                          child: MemberFullDetails(
                            member: bloc.allMembers[index],
                            onCancelTapped: (subscription) {
                              bloc.add(
                                MembersCancelSubscriptionEvent(
                                  id: bloc.allMembers[index].id!,
                                  subscription: subscription,
                                ),
                              );
                              bloc.allMembers[index].subscriptions.remove(
                                subscription,
                              );
                            },
                          ),
                        );
                      },
                      member: bloc.allMembers[index],
                    ),
                itemCount: bloc.allMembers.length,
              )
              : state is MembersLoaded &&
                  bloc.searchedMembers.isNotEmpty &&
                  searchController.text.isNotEmpty
              ? AllMembersScreenBody(
                builder:
                    (context, index) => MemberBrief(
                      onTap: () {
                        CoreSheet.showCupertino(
                          expand: true,
                          enableDrag: true,
                          backgroundColor: context.colorScheme.secondary,
                          child: MemberFullDetails(
                            onCancelTapped: (subscription) {
                              bloc.add(
                                MembersCancelSubscriptionEvent(
                                  id: bloc.searchedMembers[index].id!,
                                  subscription: subscription,
                                ),
                              );
                              bloc.searchedMembers[index].subscriptions.remove(
                                subscription,
                              );
                            },
                            member: bloc.searchedMembers[index],
                          ),
                        );
                      },
                      member: bloc.searchedMembers[index],
                    ),
                itemCount: bloc.searchedMembers.length,
              )
              : state is MembersFiltered
              ? AllMembersScreenBody(
                builder:
                    (context, index) => MemberBrief(
                      onTap: () {
                        CoreSheet.showCupertino(
                          expand: true,
                          enableDrag: true,
                          backgroundColor: context.colorScheme.secondary,
                          child: MemberFullDetails(
                            onCancelTapped: (subscription) {
                              bloc.add(
                                FilterMembersCancelSubscriptionEvent(
                                  id: bloc.filteredMembers[index].id!,
                                  subscription: subscription,
                                ),
                              );
                              bloc.filteredMembers[index].subscriptions.remove(
                                subscription,
                              );
                            },
                            member: bloc.filteredMembers[index],
                          ),
                        );
                      },
                      member: bloc.filteredMembers[index],
                    ),
                itemCount: bloc.filteredMembers.length,
              )
              : SizedBox(),
        ],
      ),
    );
  }

  @override
  void listenToState(BuildContext context, BaseState state) {}
}
