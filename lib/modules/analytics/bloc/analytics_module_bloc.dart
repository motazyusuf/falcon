part of '../import/analytics_module_import.dart';

class AnalyticsModuleBloc extends BaseBloc {
  List<Member> members;

  AnalyticsModuleBloc(this.members)
    : super(
        AnalyticsModuleStateFactory(),
        initialState: AnalyticsModuleInitialState(),
      ) {}

  @override
  void onDispose() {}
}
