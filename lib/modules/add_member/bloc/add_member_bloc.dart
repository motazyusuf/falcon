part of '../import/add_member_import.dart';

class AddMemberBloc extends BaseBloc {
  final MembersModuleRepo membersModuleRepo = MembersModuleRepo();

  Future<void> addMember(AddMemberEvent event, Emitter emit) async {
    emit(LoadingStateNonRender());
    await membersModuleRepo.addMember(event.member);
    emit(EndLoadingStateNonRender());
    debugPrint(">>>>>>>>>>End Loading<<<<<<<<<<<<<");
    emit(MemberAdded());
    debugPrint(">>>>>>>>>>Member Added<<<<<<<<<<<<<");

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
