part of '../import/members_module_import.dart';

class MembersModuleInitialEvent extends BaseEvent {}

class AddMemberEvent extends BaseEvent {
  Member member;

  AddMemberEvent(this.member);
}

class GetMembersEvent extends BaseEvent {}
