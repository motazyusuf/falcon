part of '../import/analytics_module_import.dart';

class AnalyticsModuleInitialState extends RenderDataState {
  AnalyticsModuleInitialState() : super(null);
}

class AnalyticsLoaded extends RenderDataState {
  AnalyticsLoaded() : super(null);
}

class AnalyticsSectionLoaded extends NonRenderState {
  String title;
  List<Member> members;
  AnalyticsSectionLoaded({required this.members, required this.title});
}

class AnalyticsChartLoaded extends NonRenderState {
  List<int> revenueList;
  AnalyticsChartLoaded(this.revenueList);
}

