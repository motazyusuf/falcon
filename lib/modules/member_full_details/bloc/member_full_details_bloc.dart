part of '../import/member_full_details_import.dart';

class MemberFullDetailsBloc extends BaseBloc {
  final MembersModuleRepo membersModuleRepo = MembersModuleRepo();

  Future<void> deleteMember(DeleteMemberEvent event, Emitter emit) async {
    print("Delete Member");
    emit(LoadingStateNonRender());
    await membersModuleRepo.deleteMember(event.id);
    emit(EndLoadingStateNonRender());
  }

  Future<void> editMember(EditMemberEvent event, Emitter emit) async {
    emit(LoadingStateNonRender());
    await membersModuleRepo.editMember(event.member);
    emit(EndLoadingStateNonRender());
  }

  Future<void> settleSubscription(
    SettleSubscriptionEvent event,
    Emitter emit,
  ) async {
    emit(LoadingStateNonRender());
    await membersModuleRepo.settleSubscription(event.id, event.subscription);
    emit(EndLoadingStateNonRender());
    // emit(MembersLoaded());
  }

  Future<void> cancelSubscription(
    CancelSubscriptionEvent event,
    Emitter emit,
  ) async {
    emit(LoadingStateNonRender());
    await membersModuleRepo.cancelSubscription(event.id, event.subscription);
    emit(EndLoadingStateNonRender());
    // emit(MembersLoaded());
  }

  MemberFullDetailsBloc()
    : super(
        MemberFullDetailsFactory(),
        initialState: MemberFullDetailsInitialState(),
      ) {
    on<CancelSubscriptionEvent>(cancelSubscription);
    on<SettleSubscriptionEvent>(settleSubscription);
    on<DeleteMemberEvent>(deleteMember);
    on<EditMemberEvent>(editMember);
  }
}
