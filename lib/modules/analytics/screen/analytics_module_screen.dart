part of '../import/analytics_module_import.dart';

class AnalyticsScreen extends StatefulWidget {
  final AnalyticsModuleBloc bloc;

  const AnalyticsScreen({super.key, required this.bloc});

  @override
  AnalyticsScreenState createState() => AnalyticsScreenState(bloc);
}



class AnalyticsScreenState
    extends BaseScreen<AnalyticsModuleBloc, AnalyticsScreen, dynamic> {
  AnalyticsScreenState(super.bloc);

  CancelFunc? cancelFunc;

  @override
  bool get ignoreScaffold => true;

  @override
  void showLoading() {
    super.closeKeyboard();
    cancelFunc?.call();
    cancelFunc =  AppHelper.showCustomLoading();
  }

  @override
  void hideLoading() {
    cancelFunc?.call();
  }

  @override
  Widget buildWidget(BuildContext context, RenderDataState state) {
    return state is AnalyticsLoaded
        ? SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.only(
              left: 10.w,
              right: 10.w,
              bottom: 30.h,
              top: 10.h,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                10.ph,
                UpcomingExpiry(
                  inThreeMembers: bloc.expireInThreeMembers,
                  inWeekMembers: bloc.expireInWeekMembers,
                ),
                10.ph,
                MembersOverview(
                  activeMembers: bloc.activeMembers,
                  allMembers: bloc.members,
                  dueMembers: bloc.dueMembers,
                  inactiveMembers: bloc.inactiveMembers,
                ),
                10.ph,
                RevenueReport(
                  monthlyRevenue: bloc.monthlyRevenue,
                  weeklyRevenue: bloc.weeklyRevenue,
                ),
              ],
            ),
          ),
        )
        : SizedBox();
  }

  @override
  void listenToState(BuildContext context, BaseState state) {

  }
}
