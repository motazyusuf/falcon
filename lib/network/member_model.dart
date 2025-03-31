import '../core/enums/sport_enum.dart';
import '../core/functions/my_functions.dart';

class Member {
  String? id;
  String firstName;
  String lastName;
  String? extraNotes;
  num phoneNumber;
  List<Subscription> subscriptions;
  bool isActive;
  List<String> searchKeywords; // 🔥 Used for Firestore search

  Member({
    this.id,
    required this.firstName,
    required this.lastName,
    required this.phoneNumber,
    this.extraNotes,
    required this.subscriptions,
    required this.isActive,
  }) : searchKeywords =
  _generateSearchKeywords(firstName, lastName, phoneNumber); // Auto-generate

  factory Member.fromJson(Map<String, dynamic> json) {
    return Member(
      id: json["id"],
      firstName: json["first_name"],
      lastName: json["last_name"],
      extraNotes: json["extra_notes"],
      phoneNumber: json["phone_number"],
      subscriptions: (json["subscriptions"] as List<dynamic>)
          .map((subscription) => Subscription.fromJson(subscription))
          .toList(),
      isActive: json["is_active"],
    );
  }

  static Map<String, dynamic> toJson(Member member) {
    return {
      "id": member.id ?? "",
      "first_name": member.firstName,
      "extra_notes": member.extraNotes ?? "",
      "last_name": member.lastName,
      "phone_number": member.phoneNumber,
      "subscriptions": member.subscriptions
          .map((subscription) => Subscription.toJson(subscription))
          .toList(),
      "is_active": member.isActive,
      "search_keywords": member.searchKeywords,
      // 🔥 Store searchable substrings
    };
  }

  /// 🔥 Generate searchable substrings for name & phone number
  static List<String> _generateSearchKeywords(String firstName, String lastName,
      num phoneNumber) {
    Set<String> keywords = {};

    void generateSubstrings(String text) {
      text = text.toLowerCase();
      for (int i = 0; i < text.length; i++) {
        for (int j = i + 1; j <= text.length; j++) {
          keywords.add(text.substring(i, j));
        }
      }
    }

    generateSubstrings(firstName);
    generateSubstrings(lastName);

    return keywords.toList();
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
      sport: Sport.fromString(json["sport"]),
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
      "end_date":
          MyFunctions.extractDate(subscription.endDate).millisecondsSinceEpoch,
    };
  }
}
