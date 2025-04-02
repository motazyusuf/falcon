part of '../import/members_module_import.dart';

class MembersModuleInitialEvent extends BaseEvent {}


class GetMembersEvent extends BaseEvent {}

class SearchForMembersEvent extends BaseEvent {
  String searchedForValue;

  SearchForMembersEvent(this.searchedForValue);
}

class FilterMembersEvent extends BaseEvent {
  String filterValue;

  FilterMembersEvent(this.filterValue);
}

class FilterMembersCancelSubscriptionEvent extends BaseEvent {
  String id;
  Subscription subscription;

  FilterMembersCancelSubscriptionEvent(
      {required this.id, required this.subscription});
}

class MembersCancelSubscriptionEvent extends BaseEvent {
  String id;
  Subscription subscription;

  MembersCancelSubscriptionEvent(
      {required this.id, required this.subscription});
}

class DeleteMemberEvent extends BaseEvent {
  String id;

  DeleteMemberEvent({required this.id});
}
