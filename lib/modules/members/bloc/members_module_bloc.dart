part of '../import/members_module_import.dart';

class MembersModuleBloc extends BaseBloc {
  @override
  Future<void> close() async {
    debugPrint(">>>>>>>>>>>MemberBloc will not be closed<<<<<<<<<<<");
  }

  final MembersModuleRepo membersModuleRepo = MembersModuleRepo();
  List<Member> filteredMembers = [];
  List<Member> allMembers = [];
  List<Member> searchedMembers = [];

  Future<void> getMembers(GetMembersEvent event, Emitter emit) async {
    print("Get Members");
    emit(LoadingStateNonRender());
    var stream = membersModuleRepo.getDataStream();
    await emit.forEach<QuerySnapshot<Member>>(
      stream,
      onData: (snapshot) {
        allMembers = snapshot.docs.map((doc) => doc.data()).toList();
        emit(EndLoadingStateNonRender());
        return MembersLoaded();
      },
    );
  }

  Future<void> getSearchedMembers(
    SearchForMembersEvent event,
    Emitter emit,
  ) async {
    searchedMembers = await membersModuleRepo.searchMembers(
      event.searchedForValue,
    );
    emit(MembersLoaded());
  }

  filterMembers(FilterMembersEvent event, Emitter emit) async {
    emit(LoadingStateNonRender());
    if (event.filterValue == "all") {
      filteredMembers = allMembers;
      emit(MembersFiltered());
    } else {
      filteredMembers =
          allMembers
              .where(
                (member) => member.subscriptions.any(
                  (subscription) =>
                      subscription.sport?.displayName == event.filterValue,
                ),
              )
              .toList();
      emit(MembersFiltered());
    }
    emit(EndLoadingStateNonRender());
  }

  Future<void> removeSubscription(
    MembersCancelSubscriptionEvent event,
    Emitter emit,
  ) async {
    emit(LoadingStateNonRender());
    await membersModuleRepo.removeSubscription(event.id, event.subscription);
    emit(EndLoadingStateNonRender());
    // emit(MembersLoaded());
  }

  Future<void> deleteMember(DeleteMemberEvent event, Emitter emit) async {
    emit(LoadingStateNonRender());
    await membersModuleRepo.deleteMember(event.id);
    emit(EndLoadingStateNonRender());
    emit(MemberDeleted());
  }

  showMemberDetails(ShowMemberDetailsEvent event, Emitter emit) {
    emit(MemberDetails(event.index, event.list));
  }

  MembersModuleBloc()
    : super(MembersModuleStateFactory(), initialState: MembersInitialState()) {
    debugPrint(">>>>>>>>>>>Start MembersBloc<<<<<<<<<<<");
    on<GetMembersEvent>(getMembers);
    on<FilterMembersEvent>(filterMembers);
    on<SearchForMembersEvent>(getSearchedMembers);
    on<MembersCancelSubscriptionEvent>(removeSubscription);
    on<DeleteMemberEvent>(deleteMember);
    on<ShowMemberDetailsEvent>(showMemberDetails);
  }
}
