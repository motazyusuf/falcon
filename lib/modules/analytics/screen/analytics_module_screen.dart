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
                SizedBox(height: 10.h),
                UpcomingExpiry(
                  inThreeMembers: bloc.expireInThreeMembers,
                  inWeekMembers: bloc.expireInWeekMembers,
                ),
                SizedBox(height: 10.h),
                MembersOverview(
                  activeMembers: bloc.activeMembers,
                  allMembers: bloc.members,
                  dueMembers: bloc.dueMembers,
                  inactiveMembers: bloc.inactiveMembers,
                ),
                SizedBox(height: 10.h),
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
    CancelFunc? cancelFunc;
    if (state is LoadingStateNonRender) {
      cancelFunc = MyFunctions.showLoading();
    }
    if (state is EndLoadingStateNonRender) {
      cancelFunc?.call();
      context.pop();
    }
  }
}
