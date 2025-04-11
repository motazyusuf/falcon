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

  CancelFunc? cancelFunc;

  @override
  void showLoading() {
    super.closeKeyboard();
    cancelFunc?.call();
    cancelFunc = AppHelper.showCustomLoading();
  }

  @override
  void hideLoading() {
    cancelFunc?.call();
  }

  bool canSearch = true;
  bool isFiltered = false;

  @override
  Widget buildWidget(BuildContext context, RenderDataState state) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8.h, horizontal: 8.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          MySearchBar(
            onChanged: (value) => postEvent(SearchForMembersEvent(value, isFiltered)),
            searchController: searchController,
          ),
          DefaultTabController(
            length: Sport.values.length + 1,
            child: TabBar(
              tabAlignment: TabAlignment.start,
              onTap: (index) {
                if (index == 0) {
                  canSearch = true;
                  // postEvent(GetMembersEvent());
                  postEvent(FilterMembersEvent(null));
                } else {
                  searchController.clear();
                  canSearch = false;
                  postEvent(
                    FilterMembersEvent(Sport.values[index - 1].localeKey),
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
                    LocaleKeys.all_sports.tr(),
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
                      sport.localeKey.tr(),
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
          5.ph,
          state is MembersLoaded
              ? Expanded(
                child: MembersBriefGrid(
                  builder: (context, index) {
                    isFiltered = false;
                    return MemberBrief(
                      onTap: () {
                        postEvent(
                          ShowMemberDetailsEvent(
                            index: index,
                            list: state.members,
                          ),
                        );
                      },
                      member: state.members[index],
                    );
                  },
                  itemCount: state.members.length,
                ),
              )
              : state is MembersFiltered
              ? Expanded(
                child: MembersBriefGrid(
                  builder: (context, index) {
                    isFiltered = true;
                    return MemberBrief(
                      onTap: () {
                        postEvent(
                          ShowMemberDetailsEvent(
                            index: index,
                            list: state.filteredMembers,
                          ),
                        );
                      },
                      member: state.filteredMembers[index],
                    );
                  },
                  itemCount: state.filteredMembers.length,
                ),
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
        expand: false,
        enableDrag: false,
        backgroundColor: context.colorScheme.secondary,
        child: SizedBox(
          height: context.screenSize.height * 0.75,
          child: MemberFullDetailsScreen(
            bloc: MemberFullDetailsBloc(),
            member: expandedMember,
          ),
        ),
      );
    }
  }
}
