part of '../import/task_import.dart';

class InitialEvent extends BaseEvent {}

class SelectAllEvent extends BaseEvent {}

class DeselectAllEvent extends BaseEvent {}

class ActivitySelectionEvent extends BaseEvent {
  String activity;
  int memberIndex;

  ActivitySelectionEvent(this.activity, this.memberIndex);
}

class ActivityDeSelectionEvent extends BaseEvent {
  String activity;
  int memberIndex;

  ActivityDeSelectionEvent(this.activity, this.memberIndex);
}
