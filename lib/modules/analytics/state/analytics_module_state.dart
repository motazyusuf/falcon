part of '../import/analytics_module_import.dart';

class AnalyticsModuleInitialState extends RenderDataState {
  AnalyticsModuleInitialState() : super(null);
}

class AnalyticsLoaded extends RenderDataState {
  AnalyticsLoaded() : super(null);
}

class AnalyticsSectionLoaded extends NonRenderState {
  List<Member> members;
  AnalyticsSectionLoaded({required this.members});
}

class AnalyticsChartLoaded extends NonRenderState {

}

