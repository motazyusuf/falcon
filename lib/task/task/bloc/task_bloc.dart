part of '../import/task_import.dart';

class TaskBloc extends BaseBloc {
  int selectedActivitiesCounter = 0;
  bool isActivitySelected = false;
  bool allSelected = false;
  double total = 0;

  List<AhlyMember> ahlyMembers = [
    AhlyMember("Nadeen Osama", "10/10/1996", [
      AhlyActivity(
        activityName: "Swimming",
        status: false,
        duration: 2,
        fees: 1500,
        icon: "assets/images/task/swimmer.png",
        isSelected: false,
      ),
    ]),
    AhlyMember("Salma Osama", "5/7/2000", [
      AhlyActivity(
        activityName: "Swimming",
        status: false,
        duration: 2,
        fees: 1500,
        icon: "assets/images/task/swimmer.png",
        isSelected: false,
      ),
    ]),
    AhlyMember("Rawan Osama", "22/3/1999", [
      AhlyActivity(
        activityName: "Swimming",
        status: false,
        duration: 2,
        fees: 1500,
        icon: "assets/images/task/swimmer.png",
        isSelected: false,
      ),
    ]),
  ];

  TaskBloc() : super(TaskFactory(), initialState: TaskInitialState()) {
    on<InitialEvent>(init);
    on<ActivitySelectionEvent>(selectActivity);
    on<ActivityDeSelectionEvent>(deSelectActivity);
    on<SelectAllEvent>(selectAllActivities);
    on<DeselectAllEvent>(deSelectAllActivities);
    add(InitialEvent());
  }

  Future<void> selectActivity(
    ActivitySelectionEvent event,
    Emitter emit,
  ) async
  {
    final activityIndex = ahlyMembers[event.memberIndex].activities.indexWhere(
      (activity) => activity.activityName == event.activity,
    );

    final updatedActivity = ahlyMembers[event.memberIndex]
        .activities[activityIndex]
        .copyWith(isSelected: true);

    ahlyMembers[event.memberIndex].activities[activityIndex] = updatedActivity;
    isActivitySelected = true;
    total += updatedActivity.fees!;
    selectedActivitiesCounter += 1;
    emit(MembersLoaded());
  }

  deSelectActivity(ActivityDeSelectionEvent event, Emitter emit)
  {
    final activityIndex = ahlyMembers[event.memberIndex].activities.indexWhere(
      (activity) => activity.activityName == event.activity,
    );

    final updatedActivity = ahlyMembers[event.memberIndex]
        .activities[activityIndex]
        .copyWith(isSelected: false);

    ahlyMembers[event.memberIndex].activities[activityIndex] = updatedActivity;
    total -= updatedActivity.fees!;
    selectedActivitiesCounter -= 1;
    if (selectedActivitiesCounter == 0) {
      isActivitySelected = false;
    }
    emit(MembersLoaded());
  }

  selectAllActivities(SelectAllEvent event, Emitter emit)
  {
    ahlyMembers =
        ahlyMembers.map((ahlyMember) {
          final updatedActivities =
              ahlyMember.activities.map((activity) {
                total += activity.fees!;
                isActivitySelected = true;
                selectedActivitiesCounter += 1;
                return activity.copyWith(isSelected: true);
              }).toList();

          return ahlyMember.copyWith(activities: updatedActivities);
        }).toList();
    allSelected = true;

    emit(MembersLoaded());
  }

  deSelectAllActivities(DeselectAllEvent event, Emitter emit)
  {
    ahlyMembers =
        ahlyMembers.map((ahlyMember) {
          final updatedActivities =
              ahlyMember.activities.map((activity) {
                return activity.copyWith(isSelected: false);
              }).toList();

          return ahlyMember.copyWith(activities: updatedActivities);
        }).toList();
    selectedActivitiesCounter = 0;
    isActivitySelected = false;
    allSelected = false;
    total = 0;
    emit(MembersLoaded());
  }

  init(InitialEvent event, Emitter emit) {
    emit(MembersLoaded());
  }
}
