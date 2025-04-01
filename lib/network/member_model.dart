import '../core/enums/sport_enum.dart';
import '../core/functions/my_functions.dart';

class Member {
  String? id;
  String name;
  String? extraNotes;
  num phoneNumber;
  List<Subscription> subscriptions;
  List<String> searchKeywords; // 🔥 Used for Firestore search

  Member({
    this.id,
    required this.name,
    required this.phoneNumber,
    this.extraNotes,
    required this.subscriptions,
  }) : searchKeywords = _generateSearchKeywords(name); // Auto-generate

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
      "name": member.name,
      "extra_notes": member.extraNotes ?? "",
      "phone_number": member.phoneNumber,
      "subscriptions": member.subscriptions
          .map((subscription) => Subscription.toJson(subscription))
          .toList(),
      "search_keywords": member.searchKeywords,
      // 🔥 Store searchable substrings
    };
  }

  /// 🔥 Generate searchable substrings for name & phone number
  static List<String> _generateSearchKeywords(String name) {
    Set<String> keywords = {};

    void generateSubstrings(String text) {
      text = text.toLowerCase();
      for (int i = 0; i < text.length; i++) {
        for (int j = i + 1; j <= text.length; j++) {
          keywords.add(text.substring(i, j));
        }
      }
    }

    generateSubstrings(name);

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
