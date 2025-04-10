part of '../import/member_full_details_import.dart';

class MemberFullDetailsBloc extends BaseBloc {
  final MembersModuleRepo membersModuleRepo = MembersModuleRepo();

  Future<void> deleteMember(DeleteMemberEvent event, Emitter emit) async {
    emit(LoadingStateNonRender());
    await membersModuleRepo.deleteMember(event.id);
    emit(EndLoadingStateNonRender());
    emit(DetailsLoaded());
  }

  Future<void> editMember(EditMemberEvent event, Emitter emit) async {
    emit(LoadingStateNonRender());
    await membersModuleRepo.editMember(event.member);
    emit(EndLoadingStateNonRender());
    emit(DetailsLoaded());
  }

  Future<void> settleSubscription(
    SettleSubscriptionEvent event,
    Emitter emit,) async
  {
    emit(LoadingStateNonRender());
    await membersModuleRepo.settleSubscription(event.id, event.subscription);
    emit(EndLoadingStateNonRender());
    emit(DetailsLoaded());
  }

  Future<void> cancelSubscription(
    CancelSubscriptionEvent event,
    Emitter emit,) async
  {
    emit(LoadingStateNonRender());
    await membersModuleRepo.cancelSubscription(event.id, event.subscription);
    debugPrint("Sub deleted");
    emit(EndLoadingStateNonRender());
    emit(DetailsLoaded());
  }

  initialize(event, emit) {
    emit(DetailsLoaded());
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
    on<MemberFullDetailsInitialEvent>(initialize);
    add(MemberFullDetailsInitialEvent());
  }
}
