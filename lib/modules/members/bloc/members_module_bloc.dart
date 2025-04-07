part of '../import/members_module_import.dart';

class MembersModuleBloc extends BaseBloc {


  @override
  Future<void> close() async {
    debugPrint(">>>>>>>>>>>Member Bloc Will not be Closed<<<<<<<<<<<");
  }

  final MembersModuleRepo membersModuleRepo = MembersModuleRepo();
  List<Member> filteredMembers = [];
  static List<Member> allMembers = [];
  List<Member> searchedMembers = [];
  String? filterKeyword;

  Future<void> getMembers(GetMembersEvent event, Emitter emit) async {
    print("Get Members");
    emit(LoadingStateNonRender());
    var stream = membersModuleRepo.getDataStream();
    await emit.forEach<QuerySnapshot<Member>>(
      stream,
      onData: (snapshot) {
        allMembers = snapshot.docs.map((doc) => doc.data()).toList();
        emit(EndLoadingStateNonRender());
        return MembersLoaded(allMembers);
      },
    );
  }

  getSearchedMembers(SearchForMembersEvent event,
      Emitter emit,) async
  {
    searchedMembers =
        allMembers.where((member) {
          return member.name.toLowerCase().contains(
            event.searchedForValue.toLowerCase(),
          );
        }).toList();
    emit(MembersLoaded(searchedMembers));
  }

  filterMembers(FilterMembersEvent event, Emitter emit) async {
    emit(LoadingStateNonRender());
    if (event.filterValue == null) {
      filteredMembers = allMembers;
      emit(MembersFiltered(filteredMembers));
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
      filterKeyword = event.filterValue;
      emit(MembersFiltered(filteredMembers));
    }
    emit(EndLoadingStateNonRender());
  }

  // Future<void> cancelSubscription(
  //   CancelSubscriptionEvent event,
  //   Emitter emit,) async
  // {
  //   emit(LoadingStateNonRender());
  //   await membersModuleRepo.cancelSubscription(event.id, event.subscription);
  //   emit(EndLoadingStateNonRender());
  //   // emit(MembersLoaded());
  // }

  // Future<void> deleteMember(DeleteMemberEvent event, Emitter emit) async {
  //   print("Delete Member");
  //   emit(LoadingStateNonRender());
  //   await membersModuleRepo.deleteMember(event.id);
  //   emit(EndLoadingStateNonRender());
  //   add(FilterMembersEvent(filterKeyword));
  //   emit(MemberDeleted());
  // }
  //
  // Future<void> editMember(EditMemberEvent event, Emitter emit) async {
  //   emit(LoadingStateNonRender());
  //   await membersModuleRepo.editMember(event.member);
  //   emit(EndLoadingStateNonRender());
  // }

  showMemberDetails(ShowMemberDetailsEvent event, Emitter emit) {
    emit(MemberDetails(event.index, event.list));
  }

  // Future<void> settleSubscription(
  //   SettleSubscriptionEvent event,
  //   Emitter emit,) async
  // {
  //   emit(LoadingStateNonRender());
  //   await membersModuleRepo.settleSubscription(event.id, event.subscription);
  //   emit(EndLoadingStateNonRender());
  //   // emit(MembersLoaded());
  // }

  MembersModuleBloc()
    : super(MembersModuleStateFactory(), initialState: MembersInitialState()) {
    debugPrint(">>>>>>>>>>>Start MembersBloc<<<<<<<<<<<");
    on<GetMembersEvent>(getMembers);
    on<FilterMembersEvent>(filterMembers);
    on<SearchForMembersEvent>(getSearchedMembers);
    // on<CancelSubscriptionEvent>(cancelSubscription);
    // on<SettleSubscriptionEvent>(settleSubscription);
    // on<DeleteMemberEvent>(deleteMember);
    // on<EditMemberEvent>(editMember);
    on<ShowMemberDetailsEvent>(showMemberDetails);
    add(GetMembersEvent());
  }
}
