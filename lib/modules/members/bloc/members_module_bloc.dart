part of '../import/members_module_import.dart';

class MembersModuleBloc extends BaseBloc {
  @override
  Future<void> close() async {
    // To keep stream open
  }

  final MembersModuleRepo membersModuleRepo = MembersModuleRepo();
  List<Member> filteredMembers = [];
  List<Member> allMembers = [];

  Future<void> addMember(AddMemberEvent event, Emitter emit) async {
    emit(LoadingStateNonRender());
    await membersModuleRepo.addMember(event.member);
    emit(EndLoadingStateNonRender());
  }

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
      onError: (error, stackTrace) {
        return MemberError();
      },
    );
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

  MembersModuleBloc()
    : super(MembersModuleStateFactory(), initialState: MembersInitialState()) {
    on<AddMemberEvent>(addMember);
    on<GetMembersEvent>(getMembers);
    on<FilterMembersEvent>(filterMembers);
  }
}
