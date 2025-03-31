part of '../import/add_member_import.dart';

class AddMemberInitialEvent extends BaseEvent {}

class AddMemberEvent extends BaseEvent {
  Member member;
  AddMemberEvent(this.member);
}

class AddMemberWithNoEndDateEvent extends BaseEvent {}
