part of '../import/analytics_module_import.dart';

class AnalyticsModuleBloc extends BaseBloc {
  final MembersModuleRepo membersModuleRepo = MembersModuleRepo();
  List<Member> members;
  List<Member> dueMembers = [];
  List<Member> activeMembers = [];
  List<Member> inactiveMembers = [];
  List<Member> expireInThreeMembers = [];
  List<Member> expireInWeekMembers = [];
  List<Subscription> expireInThreeSubscriptions = [];
  List<Subscription> expireInWeekSubscriptions = [];
  bool memberHasThreeExpiry = false;
  bool memberHasWeekExpiry = false;
  int monthlyRevenue = 0;

  AnalyticsModuleBloc(this.members)
    : super(
        AnalyticsModuleStateFactory(),
        initialState: AnalyticsModuleInitialState(),
      ) {
    debugPrint(">>>>>>>>>>>>>>>Analytics Bloc<<<<<<<<<<<<<<<<<<<<<<");
    on<PrepareAnalyticsEvent>(prepareAnalytics);
    on<AnalyticsSectionTappedEvent>(showAnalyticsSection);
    on<AnalyticsChartTappedEvent>(showChart);
    on<SetRevenueEvent>(setRevenue);
    add(PrepareAnalyticsEvent());
  }

  @override
  Future<void> close() async {
    super.close();
    debugPrint(">>>>>>>>>>>Analytics Bloc closed<<<<<<<<<<<");
  }

  void prepareAnalytics(PrepareAnalyticsEvent event, Emitter emit) {
    dueMembers.clear();
    activeMembers.clear();
    inactiveMembers.clear();
    expireInThreeMembers.clear();
    expireInWeekMembers.clear();
    monthlyRevenue = 0;

    final now = DateTime.now();
    final startOfMonth = DateTime(now.year, now.month);

    for (Member member in members) {
      bool hasActive = false;
      bool hasDue = false;
      memberHasThreeExpiry = false;
      memberHasWeekExpiry = false;

      for (Subscription subscription in member.subscriptions) {
        if (subscription.subscriptionDate.isAfter(startOfMonth)) {
          monthlyRevenue += subscription.paidAmount.toInt();
        }

        // Due
        if (subscription.dueAmount! > 0) hasDue = true;

        // Expiry check
        final daysLeft = subscription.endDate.difference(now).inDays;
        if (daysLeft <= 3 && daysLeft > 0) {
          expireInThreeMembers.add(member);
          if (!memberHasThreeExpiry) {
            expireInThreeSubscriptions.add(subscription);
            memberHasThreeExpiry = true;
          }
        }
        if (daysLeft <= 7 && daysLeft >= 4) {
          expireInWeekMembers.add(member);
          if (!memberHasWeekExpiry) {
            expireInWeekSubscriptions.add(subscription);
            memberHasWeekExpiry = true;
          }
        }

        // Active
        if (subscription.endDate.isAfter(now)) {
          hasActive = true;
        }
        ;
      }

      if (hasDue) dueMembers.add(member);
      if (hasActive) {
        activeMembers.add(member);
      } else {
        inactiveMembers.add(member);
      }
    }

    add(SetRevenueEvent());
    emit(AnalyticsLoaded());
  }

  Future<void> showAnalyticsSection(
    AnalyticsSectionTappedEvent event,
    Emitter emit,
  ) async {
    emit(AnalyticsSectionLoaded(members: event.members));
  }

  Future<void> setRevenue(SetRevenueEvent event, Emitter emit)async {
    emit(LoadingStateNonRender());
    await membersModuleRepo.setMonthlyRevenue(monthlyRevenue);
    emit(EndLoadingStateNonRender());
  }

  Future<void> showChart(AnalyticsChartTappedEvent event, Emitter emit) async{
    emit(LoadingStateNonRender());
    final monthsRevenue = await membersModuleRepo.getMonthlyRevenue();
    emit(EndLoadingStateNonRender());
    emit(AnalyticsChartLoaded(monthsRevenue));
  }

}
