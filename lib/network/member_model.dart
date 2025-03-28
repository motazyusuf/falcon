import '../core/enums/sport_enum.dart';
import '../core/functions/my_functions.dart';

class Member {
  String id;
  String firstName;
  String lastName;
  num paidAmount;
  num dueAmount;
  num phoneNumber;
  List<Sport> sports;
  DateTime subscriptionDate;
  DateTime endDate;
  bool isActive;

  Member({
    required this.id,
    required this.firstName,
    required this.lastName,
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
      firstName: json["first_name"],
      lastName: json["last_name"],
      paidAmount: json["paid_amount"],
      dueAmount: json["due_amount"],
      phoneNumber: json["phone_number"],
      sports:
          (json["sports"] as List<String>)
              .map((sport) => Sport.fromString(sport))
              .toList(),
      subscriptionDate: DateTime.fromMillisecondsSinceEpoch(
        json["subscription_date"],
      ),
      endDate: DateTime.fromMillisecondsSinceEpoch(json["end_date"]),
      isActive: json["is_active"],
    );
  }

  static Map<String, dynamic> toJson(Member member) {
    return {
      "id": member.id,
      "first_name": member.firstName,
      "last_name": member.lastName,
      "paid_amount": member.paidAmount,
      "due_amount": member.dueAmount,
      "phone_number": member.phoneNumber,
      "sports": member.sports.map((sport) => sport.toString()).toList(),
      "subscription_date":
          MyFunctions.extractDate(
            member.subscriptionDate,
          ).millisecondsSinceEpoch,
      "end": MyFunctions.extractDate(member.endDate).millisecondsSinceEpoch,
      "is_active": member.isActive,
    };
  }
}
