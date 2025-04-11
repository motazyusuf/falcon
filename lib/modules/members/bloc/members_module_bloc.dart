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


  MembersModuleBloc()
      : super(MembersModuleStateFactory(), initialState: MembersInitialState()) {
    debugPrint(">>>>>>>>>>>Start MembersBloc<<<<<<<<<<<");
    on<GetMembersEvent>(getMembers);
    on<FilterMembersEvent>(filterMembers);
    on<SearchForMembersEvent>(getSearchedMembers);
    on<ShowMemberDetailsEvent>(showMemberDetails);
    add(GetMembersEvent());
  }

  Future<void> getMembers(GetMembersEvent event, Emitter emit) async {
    emit(LoadingStateNonRender());
    var stream = membersModuleRepo.getDataStream();
    await emit.forEach<QuerySnapshot<Member>>(
      stream,
      onData: (snapshot) {
        allMembers = snapshot.docs.map((doc) => doc.data()).toList();
        var sortedMembers = allMembers.map((member) {
          member.subscriptions.sort((a, b) => b.endDate.compareTo(a.endDate));
          return member;
        }).toList();
        emit(EndLoadingStateNonRender());
        return MembersLoaded(sortedMembers);
      },
    );
  }

  getSearchedMembers(SearchForMembersEvent event, Emitter emit) async {
    searchedMembers = allMembers.where((member) {
      final query = event.searchedForValue.toLowerCase();
      return member.name.toLowerCase().contains(query) ||
          member.phoneNumber.toString().contains(query);
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
                      subscription.sport?.localeKey == event.filterValue,
                ),
              )
              .toList();
      filterKeyword = event.filterValue;
      emit(MembersFiltered(filteredMembers));
    }
    emit(EndLoadingStateNonRender());
  }

  showMemberDetails(ShowMemberDetailsEvent event, Emitter emit) {
    emit(MemberDetails(event.index, event.list));
  }



}
