class AhlyMember {
  final String name;
  final String birthDate;
  final List<AhlyActivity> activities;

  const AhlyMember(this.name, this.birthDate, this.activities);

  AhlyMember copyWith({
    String? name,
    String? birthDate,
    List<AhlyActivity>? activities,
  }) {
    return AhlyMember(
      name ?? this.name,
      birthDate ?? this.birthDate,
      activities ?? this.activities,
    );
  }
}

class AhlyActivity {
  final String? activityName;
  final bool? status;
  final int? duration;
  final double? fees;
  final String? icon;
  final bool? isSelected;

  // copy with

  const AhlyActivity({
    this.activityName,
    this.status,
    this.duration,
    this.fees,
    this.icon,
    this.isSelected,
  });

  AhlyActivity copyWith({
    String? activityName,
    bool? status,
    int? duration,
    double? fees,
    String? icon,
    bool? isSelected,
  }) {
    return AhlyActivity(
      activityName: activityName ?? this.activityName,
      status: status ?? this.status,
      duration: duration ?? this.duration,
      fees: fees ?? this.fees,
      icon: icon ?? this.icon,
      isSelected: isSelected ?? this.isSelected,
    );
  }
}
