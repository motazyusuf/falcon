import '../core/enums/sport_enum.dart';

class Member {
  String id;
  String name;
  num paidAmount;
  num dueAmount;
  num phoneNumber;
  List<Sport> sports;
  DateTime subscriptionDate;
  DateTime endDate;
  bool isActive;

  Member({
    required this.id,
    required this.name,
    required this.paidAmount,
    required this.dueAmount,
    required this.phoneNumber,
    required this.sports,
    required this.subscriptionDate,
    required this.endDate,
    required this.isActive,
  });

  factory Member.fromJson(Map<String, dynamic> json) {
    return Member(
      id: json["id"],
      name: json["name"],
      paidAmount: json["paid_amount"],
      dueAmount: json["due_amount"],
      phoneNumber: json["phone_number"],
      sports:
          (json["sports"] as List<String>)
              .map((sport) => Sport.fromString(sport))
              .toList(),
      subscriptionDate: json["subscription_date"],
      endDate: json["end_date"],
      isActive: json["is_active"],
    );
  }

  static Map<String, dynamic> toJson(Member member) {
    return {
      "id": member.id,
      "name": member.name,
      "paid_amount": member.paidAmount,
      "due_amount": member.dueAmount,
      "phone_number": member.phoneNumber,
      "sports": member.sports.map((sport) => sport.toString()).toList(),
      "subscription_date": member.subscriptionDate,
      "end": member.endDate,
      "is_active": member.isActive,
    };
  }
}
