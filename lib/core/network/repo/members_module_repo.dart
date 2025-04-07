import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:opticore/opticore.dart';

import '../model/member_model.dart';

class MembersModuleRepo extends BaseRepo {
  static CollectionReference<Member> getCollection() {
    return FirebaseFirestore.instance
        .collection('Members')
        .withConverter<Member>(
          fromFirestore: (snapshot, _) => Member.fromJson(snapshot.data()!),
          toFirestore: (value, _) => Member.toJson(value),
        );
  }

  Future<void> addMember(Member member) async {
    // reference the collection || create if !exist
    var collectionRef = getCollection();

    // create empty document with id
    var documentRef = collectionRef.doc();

    member.id = documentRef.id;

    member.subscriptions.sort((b, a) => a.endDate.compareTo(b.endDate));

    // set values to document
    await documentRef.set(member);
  }

  Stream<QuerySnapshot<Member>> getDataStream() {
    // reference the collection and query || create if !exist and query
    var collectionRef = getCollection();

    // stream snapshots
    var stream = collectionRef.snapshots();
    return stream;
  }

  Future<List<Member>> searchMembers(String query) async {
    var collectionRef = getCollection();

    print("Typed: ${query}");
    if (query.isEmpty) return [];

    // Search by 'name'
    final keywordsQuery =
        await collectionRef
            .where('search_keywords', arrayContains: query)
            .get();

    final results = keywordsQuery.docs.map((doc) => doc.data()).toList();

    print(results);
    return results;
  }

  Future<void> cancelSubscription(
    String userId,
    Subscription subscription,
  ) async {
    final docRef = FirebaseFirestore.instance.collection('Members').doc(userId);
    await docRef.update({
      'subscriptions': FieldValue.arrayRemove([
        {
          'due_amount': int.parse(subscription.dueAmount!.toString()),
          'end_date': int.parse(
            subscription.endDate.millisecondsSinceEpoch.toString(),
          ),
          'paid_amount': int.parse(subscription.paidAmount.toString()),
          'sport': subscription.sport?.displayName.toString(),
          'subscription_date': int.parse(
            subscription.subscriptionDate.millisecondsSinceEpoch.toString(),
          ),
        },
      ]),
    });
  }

  Future<void> settleSubscription(String userId,
      Subscription subscription) async
  {
    final docRef = FirebaseFirestore.instance.collection('Members').doc(userId);

    await FirebaseFirestore.instance.runTransaction((transaction) async {
      final snapshot = await transaction.get(docRef);


      List<dynamic> subscriptions = snapshot.get('subscriptions');

      // Create a modified list
      List<dynamic> updatedSubscriptions = subscriptions.map((sub) {
        if (sub['sport'] == subscription.sport?.displayName &&
            sub['subscription_date'] ==
                subscription.subscriptionDate.millisecondsSinceEpoch &&
            sub['end_date'] == subscription.endDate.millisecondsSinceEpoch) {
          return {
            ...sub, // Keep other properties the same
            'due_amount': int.parse(subscription.dueAmount!.toString()),
            'paid_amount': int.parse(subscription.paidAmount.toString()),
          };
        }
        return sub;
      }).toList();

      // Update the document
      transaction.update(docRef, {'subscriptions': updatedSubscriptions});
    });
  }

  Future<void> editMember(Member member) async
  {
    // reference the collection || create if !exist
    var collectionRef = getCollection();

    var documentRef = collectionRef.doc(member.id);
    await documentRef.set(member, SetOptions(merge: true));
  }


  Future<void> deleteMember(String userId) async {
    final docRef = FirebaseFirestore.instance.collection('Members').doc(userId);
    await docRef.delete();
  }
}
