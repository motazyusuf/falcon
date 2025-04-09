part of '../import/analytics_module_import.dart';

class AnalyticsModuleInitialEvent extends BaseEvent {}

class PrepareAnalyticsEvent extends BaseEvent {}

class GetAnalyticsMembersEvent extends BaseEvent {}

class AnalyticsSectionTappedEvent extends BaseEvent {
  List<Member> members;

  AnalyticsSectionTappedEvent({required this.members});
}
