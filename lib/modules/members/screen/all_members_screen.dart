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

  @override
  Widget buildWidget(BuildContext context, RenderDataState state) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8.h, horizontal: 8.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SizedBox(
            height: 50.h, // Adjust height as needed
            child: TextFormField(
              controller: searchController,
              onChanged: (value) => bloc.add(SearchForMembersEvent(value)),
              decoration: InputDecoration(
                fillColor: Colors.white,
                filled: true,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                  borderSide: BorderSide.none,
                ),
                hintText: MyStrings.searchForMember,
                hintStyle: context.textTheme.bodyLarge,
                contentPadding: EdgeInsets.symmetric(
                  vertical: 14,
                  horizontal: 16,
                ),
                prefixIcon: Icon(
                  Icons.search_rounded,
                  color: Colors.grey,
                  size: 25.r,
                ),
              ),
            ),
          ),
          DefaultTabController(
            length: Sport.values.length + 1,
            child: TabBar(
              tabAlignment: TabAlignment.start,
              onTap: (index) {
                if (index == 0) {
                  // context.read<MembersModuleBloc>().add(
                  //   FilterMembersEvent('all'),
                  context.read<MembersModuleBloc>().add(GetMembersEvent());
                } else {
                  context.read<MembersModuleBloc>().add(
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
              ? Expanded(
                child: FlexibleGridView(
                  crossAxisSpacing: 10.w,
                  mainAxisSpacing: 10.h,
                  builder:
                      (context, index) =>
                      MemberBrief(
                        onTap: () {
                          CoreSheet.showCupertino(expand: true,
                              enableDrag: true,
                              backgroundColor: context.colorScheme.secondary,
                              child: MemberFullDetails(
                                  member: bloc.allMembers[index]));
                        },
                        member: bloc.allMembers[index],
                      ),
                  itemCount: bloc.allMembers.length,
                  crossAxisCount: 2,
                ),
              )
              : state is MembersLoaded &&
              bloc.searchedMembers.isNotEmpty &&
              searchController.text.isNotEmpty
              ? Expanded(
                child: FlexibleGridView(
                  crossAxisSpacing: 10.w,
                  mainAxisSpacing: 10.h,
                  builder:
                      (context, index) =>
                      MemberBrief(
                        onTap: () {
                          CoreSheet.showCupertino(child: Text("Test"));
                        },
                        member: bloc.searchedMembers[index],
                      ),
                  itemCount: bloc.searchedMembers.length,
                  crossAxisCount: 2,
                ),
          ) : state is MembersFiltered ? Expanded(
            child: FlexibleGridView(
              crossAxisSpacing: 10.w,
              mainAxisSpacing: 10.h,
              builder:
                  (context, index) =>
                  MemberBrief(
                    onTap: () {
                      CoreSheet.showCupertino(expand: true,
                          enableDrag: true,
                          backgroundColor: context.colorScheme.secondary,
                          child: MemberFullDetails(
                              member: bloc.filteredMembers[index]));
                    },
                    member: bloc.filteredMembers[index],
                  ),
              itemCount: bloc.filteredMembers.length,
              crossAxisCount: 2,
            ),
          )
              : SizedBox(),
        ],
      ),
    );
  }

  @override
  void listenToState(BuildContext context, BaseState state) {}
}
