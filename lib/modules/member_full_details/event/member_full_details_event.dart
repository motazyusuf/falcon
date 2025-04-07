part of '../import/member_full_details_import.dart';

class MemberFullDetailsInitialEvent extends BaseEvent {}

class CancelSubscriptionEvent extends BaseEvent {
  String id;
  Subscription subscription;

  CancelSubscriptionEvent({required this.id, required this.subscription});
}

class SettleSubscriptionEvent extends BaseEvent {
  String id;
  Subscription subscription;

  SettleSubscriptionEvent({required this.id, required this.subscription});
}

class DeleteMemberEvent extends BaseEvent {
  String id;

  DeleteMemberEvent({required this.id});
}

class EditMemberEvent extends BaseEvent {
  Member member;

  EditMemberEvent({required this.member});
}
