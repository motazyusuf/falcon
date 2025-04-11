import 'package:falcon_project/core/extensions/date_extensions.dart';

import '../../enums/sport_enum.dart';

class Member {
  String? id;
  String name;
  String? extraNotes;
  num phoneNumber;
  List<Subscription> subscriptions;

  Member({
    this.id,
    required this.name,
    required this.phoneNumber,
    this.extraNotes,
    required this.subscriptions,
  });

  factory Member.fromJson(Map<String, dynamic> json) {
    return Member(
      id: json["id"],
      name: json["name"],
      extraNotes: json["extra_notes"],
      phoneNumber: json["phone_number"],
      subscriptions: (json["subscriptions"] as List<dynamic>)
          .map((subscription) => Subscription.fromJson(subscription))
          .toList(),
    );
  }

  static Map<String, dynamic> toJson(Member member) {
    return {
      "id": member.id ?? "",
      "name": member.name.toLowerCase(),
      "extra_notes": member.extraNotes ?? "",
      "phone_number": member.phoneNumber,
      "subscriptions": member.subscriptions
          .map((subscription) => Subscription.toJson(subscription))
          .toList(),
    };
  }


}

class Subscription {
  Sport? sport;
  DateTime subscriptionDate;
  DateTime endDate;
  num paidAmount;
  num? dueAmount;
  DateTime paymentDate;

  Subscription({
    this.sport,
    required this.subscriptionDate,
    required this.endDate,
    required this.paidAmount,
    this.dueAmount,
    required this.paymentDate
  });

  factory Subscription.fromJson(Map<String, dynamic> json) {
    return Subscription(
      paidAmount: json["paid_amount"] ?? 0,
      dueAmount: json["due_amount"] ?? 0,
      sport: Sport.fromString(json["sport"]),
      subscriptionDate: DateTime.fromMillisecondsSinceEpoch(
        json["subscription_date"] ?? 0,
      ),
      endDate: DateTime.fromMillisecondsSinceEpoch(json["end_date"] ?? 0),
      paymentDate: DateTime.fromMillisecondsSinceEpoch(json["payment_date"])
    );
  }

  static Map<String, dynamic> toJson(Subscription subscription) {
    return {
      "paid_amount": subscription.paidAmount,
      "due_amount": subscription.dueAmount ?? 0,
      "sport": subscription.sport?.localeKey,
      "subscription_date":
          subscription.subscriptionDate.dateOnly.millisecondsSinceEpoch,
      "end_date": subscription.endDate.dateOnly.millisecondsSinceEpoch,
      "payment_date": subscription.paymentDate.dateOnly.millisecondsSinceEpoch
    };
  }
}
