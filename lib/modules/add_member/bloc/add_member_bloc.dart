part of '../import/add_member_import.dart';

class AddMemberBloc extends BaseBloc {
  final MembersModuleRepo membersModuleRepo = MembersModuleRepo();

  Future<void> addMember(AddMemberEvent event, Emitter emit) async {
    print(">>>>>>>>>>Loading<<<<<<<<<<<<<");
    emit(LoadingStateNonRender());
    await membersModuleRepo.addMember(event.member);
    emit(EndLoadingStateNonRender());
    print(">>>>>>>>>>End Loading<<<<<<<<<<<<<");
    emit(MemberAdded());
    print(">>>>>>>>>>Member Added<<<<<<<<<<<<<");

  }

  addMemberWithNoEndDateEvent(AddMemberWithNoEndDateEvent event, Emitter emit) {
    emit(NoEndDate());
  }

  @override
  Future<void> close() {
    debugPrint(">>>>>>>>>>>Close AddMemberBloc<<<<<<<<<<<");
    return super.close();
  }

  AddMemberBloc()
    : super(AddMemberStateFactory(), initialState: AddMemberInitialState()) {
    debugPrint(">>>>>>>>>>>Start AddMemberBloc<<<<<<<<<<<");
    on<AddMemberEvent>(addMember);
    on<AddMemberWithNoEndDateEvent>(addMemberWithNoEndDateEvent);
  }

  @override
  void onDispose() {}
}
