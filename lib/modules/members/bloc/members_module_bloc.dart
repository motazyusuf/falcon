part of '../import/members_module_import.dart';

class MembersModuleBloc extends BaseBloc {
  @override
  Future<void> close() async {
    debugPrint(">>>>>>>>>>>MemberBloc will not be closed<<<<<<<<<<<");
  }

  final MembersModuleRepo membersModuleRepo = MembersModuleRepo();
  List<Member> filteredMembers = [];
  List<Member> allMembers = [];


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
    debugPrint(">>>>>>>>>>>Start MembersBloc<<<<<<<<<<<");
    on<GetMembersEvent>(getMembers);
    on<FilterMembersEvent>(filterMembers);
  }
}
