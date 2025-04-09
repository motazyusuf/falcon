part of '../import/analytics_module_import.dart';

class AnalyticsModuleBloc extends BaseBloc {
  @override
  Future<void> close() async {
    super.close();
    debugPrint(">>>>>>>>>>>Analytics Bloc closed<<<<<<<<<<<");
  }

  final MembersModuleRepo membersModuleRepo = MembersModuleRepo();
  List<Member> members;
  List<Member> dueMembers = [];
  int activeMembers = 0;
  int inactiveMembers = 0;
  List<Member> expireInThreeMembers = [];
  List<Member> expireInWeekMembers = [];
  int monthlyRevenue = 0;
  int weeklyRevenue = 0;

  void prepareAnalytics(PrepareAnalyticsEvent event, Emitter emit) {
    print("Got analytics");
    dueMembers.clear();
    activeMembers=0;
    inactiveMembers=0;
    expireInThreeMembers.clear();
    expireInWeekMembers.clear();
    monthlyRevenue = 0;
    weeklyRevenue = 0;

    final now = DateTime.now();
    final startOfWeek = now.subtract(Duration(days: now.weekday - 1));
    final startOfMonth = DateTime(now.year, now.month);

    for (Member member in members) {
      bool hasActive = false;
      bool hasDue = false;

      for (Subscription subscription in member.subscriptions) {
        // Revenue tracking
        if (subscription.subscriptionDate.isAfter(startOfWeek)) {
          weeklyRevenue += subscription.paidAmount.toInt();
        }
        if (subscription.subscriptionDate.isAfter(startOfMonth)) {
          monthlyRevenue += subscription.paidAmount.toInt();
        }

        // Due
        if (subscription.dueAmount! > 0) hasDue = true;

        // Expiry check
        final daysLeft = subscription.endDate.difference(now).inDays;
        if (daysLeft <= 3 && daysLeft >= 0) {
          expireInThreeMembers.add(member);
        }
        if (daysLeft <= 7 && daysLeft >= 0) {
          expireInWeekMembers.add(member);
        }

        // Active
        if (subscription.endDate.isAfter(now)) {
          hasActive = true;
        }
        ;
      }

      if (hasDue) dueMembers.add(member);
      if (hasActive) {
        activeMembers+=1;
      } else {
        inactiveMembers+=1;
      }
    }

    emit(AnalyticsLoaded());
  }

  AnalyticsModuleBloc(this.members)
    : super(
        AnalyticsModuleStateFactory(),
        initialState: AnalyticsModuleInitialState(),
      ) {
    print(">>>>>>>>>>>>>>>Analytics Bloc<<<<<<<<<<<<<<<<<<<<<<");
    on<PrepareAnalyticsEvent>(prepareAnalytics);
    add(PrepareAnalyticsEvent());
  }
}
