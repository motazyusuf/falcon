part of '../import/members_module_import.dart';

class MembersModuleBloc extends BaseBloc {
  final MembersModuleRepo membersModuleRepo = MembersModuleRepo();

  Future<void> addMember(AddMemberEvent event, Emitter emit) async {
    emit(LoadingStateNonRender());
    await membersModuleRepo.addMember(event.member);
    emit(EndLoadingStateNonRender());
  }

  Future<void> getMembers(GetMembersEvent event, Emitter emit) async {
    emit(LoadingStateNonRender());
    var stream = membersModuleRepo.getDataStream();
    await emit.forEach<QuerySnapshot<Member>>(
      stream,
      onData: (snapshot) {
        List<Member> members = snapshot.docs.map((doc) => doc.data()).toList();
        emit(EndLoadingStateNonRender());
        return MembersLoaded(members);
      },
      onError: (error, stackTrace) {
        return MemberError();
      },
    );
  }

  MembersModuleBloc()
    : super(MembersModuleStateFactory(), initialState: MembersInitialState()) {
    on<AddMemberEvent>(addMember);
    on<GetMembersEvent>(getMembers);
  }
}
