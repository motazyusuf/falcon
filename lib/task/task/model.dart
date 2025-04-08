class AhlyMember{
  final String name;
  final String birthDate;
  final List<AhlyActivity> activities;

  const AhlyMember(this.name, this.birthDate, this.activities);
}

class AhlyActivity{
  final String activityName;
  final bool status;
  final int duration;
  final double fees;
  final String icon;
  final bool isSelected;

  // copy with

  const AhlyActivity(this.activityName, this.status, this.duration, this.fees, this.icon, this.isSelected);
}