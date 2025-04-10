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
  bool get ignoreScaffold => false;

  @override
  void showLoading() {
    super.closeKeyboard();
    cancelFunc?.call();
    cancelFunc = AppHelper.showCustomLoading();
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
                  inThreeMembersLength: bloc.expireInThreeMembers.length,
                  inWeekMembersLength: bloc.expireInWeekMembers.length,
                  onThreeTapped:
                      () => postEvent(
                        AnalyticsSectionTappedEvent(
                          members: bloc.expireInThreeMembers,
                        ),
                      ),
                  onWeekTapped:
                      () => postEvent(
                        AnalyticsSectionTappedEvent(
                          members: bloc.expireInWeekMembers,
                        ),
                      ),
                ),
                10.ph,
                MembersOverview(
                  activeMembers: bloc.activeMembers,
                  allMembersLength: bloc.members.length,
                  dueMembers: bloc.dueMembers,
                  inactiveMembers: bloc.inactiveMembers,
                  onActiveMembersTaped:
                      () => postEvent(
                        AnalyticsSectionTappedEvent(
                          members: bloc.activeMembers,
                        ),
                      ),
                  onDueMembersTaped:
                      () => postEvent(
                        AnalyticsSectionTappedEvent(members: bloc.dueMembers),
                      ),
                  onInactiveMembersTaped:
                      () => postEvent(
                        AnalyticsSectionTappedEvent(
                          members: bloc.inactiveMembers,
                        ),
                      ),
                ),
                10.ph,
                RevenueReport(
                  monthlyRevenue: bloc.monthlyRevenue,
                  onChartTapped: () => postEvent(AnalyticsChartTappedEvent()),
                ),
              ],
            ),
          ),
        )
        : SizedBox();
  }

  @override
  void listenToState(BuildContext context, BaseState state) {
    if (state is AnalyticsSectionLoaded && state.members.isNotEmpty) {
      CoreSheet.showCupertino(
        enableDrag: false,
        backgroundColor: context.colorScheme.secondary,
        child: SizedBox(
          height: screenHeight * 0.8,
          width: screenWidth * 0.9,
          child: MembersBriefGrid(
            builder:
                (context, index) =>
                    MemberBrief(member: state.members[index], onTap: () {}),
            itemCount: state.members.length,
          ),
        ),
      );
    } else if (state is AnalyticsChartLoaded) {
      CoreSheet.showCupertino(
        enableDrag: false,
        backgroundColor: context.colorScheme.secondary,
        child: SizedBox(
          height: screenHeight * 0.8,
          width: screenWidth,
          child: YearlyChart(revenueList: state.revenueList,),
        ),
      );
    }
  }
}
