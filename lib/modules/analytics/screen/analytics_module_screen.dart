part of '../import/analytics_module_import.dart';

class AnalyticsModuleScreen extends StatefulWidget {
  final AnalyticsModuleBloc bloc;

  const AnalyticsModuleScreen({super.key, required this.bloc});

  @override
  AnalyticsModuleScreenState createState() => AnalyticsModuleScreenState(bloc);
}

class AnalyticsModuleScreenState
    extends BaseScreen<AnalyticsModuleBloc, AnalyticsModuleScreen, dynamic> {
  AnalyticsModuleScreenState(super.bloc);

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
  void listenToState(BuildContext context, BaseState state) {}
}
