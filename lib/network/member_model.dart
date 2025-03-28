import '../core/enums/sport_enum.dart';
import '../core/functions/my_functions.dart';

class Member {
  String? id;
  String firstName;
  String lastName;
  num phoneNumber;
  List<Subscription> subscriptions;
  bool isActive;

  Member({
    this.id,
    required this.firstName,
    required this.lastName,
    required this.phoneNumber,
    required this.subscriptions,
    required this.isActive,
  });

  factory Member.fromJson(Map<String, dynamic> json) {
    return Member(
      id: json["id"],
      firstName: json["first_name"],
      lastName: json["last_name"],
      phoneNumber: json["phone_number"],
      subscriptions:
          (json["subscriptions"] as List<dynamic>)
              .map((subscription) => Subscription.fromJson(json))
              .toList(),
      isActive: json["is_active"],
    );
  }

  static Map<String, dynamic> toJson(Member member) {
    return {
      "id": member.id ?? "",
      "first_name": member.firstName,
      "last_name": member.lastName,
      "phone_number": member.phoneNumber,
      "subscriptions": member.subscriptions.map(
        (subscription) => Subscription.toJson(subscription),
      ),
      "is_active": member.isActive,
    };
  }
}

class Subscription {
  Sport? sport;
  DateTime subscriptionDate;
  DateTime endDate;
  num paidAmount;
  num? dueAmount;

  Subscription({
    this.sport,
    required this.subscriptionDate,
    required this.endDate,
    required this.paidAmount,
    this.dueAmount,
  });

  factory Subscription.fromJson(Map<String, dynamic> json) {
    return Subscription(
      paidAmount: json["paid_amount"] ?? 0,
      dueAmount: json["due_amount"] ?? 0,
      sport: json["sport"],
      subscriptionDate: DateTime.fromMillisecondsSinceEpoch(
        json["subscription_date"] ?? 0,
      ),
      endDate: DateTime.fromMillisecondsSinceEpoch(json["end_date"] ?? 0),
    );
  }

  static Map<String, dynamic> toJson(Subscription subscription) {
    return {
      "paid_amount": subscription.paidAmount,
      "due_amount": subscription.dueAmount ?? 0,
      "sport": subscription.sport?.displayName,
      "subscription_date":
          MyFunctions.extractDate(
            subscription.subscriptionDate,
          ).millisecondsSinceEpoch,
      "end":
          MyFunctions.extractDate(subscription.endDate).millisecondsSinceEpoch,
    };
  }
}
