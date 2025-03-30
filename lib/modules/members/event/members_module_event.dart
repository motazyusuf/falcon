part of '../import/members_module_import.dart';

class MembersModuleInitialEvent extends BaseEvent {}


class GetMembersEvent extends BaseEvent {}

class FilterMembersEvent extends BaseEvent {
  String filterValue;

  FilterMembersEvent(this.filterValue);
}
