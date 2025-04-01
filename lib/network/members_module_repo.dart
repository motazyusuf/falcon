import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:opticore/opticore.dart';

import 'member_model.dart';

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

    // stream.listen((onData) {
    //   onData.docs.map((member) =>
    //       member
    //           .data()
    //           .subscriptions
    //           .sort((b, a) => a.endDate.compareTo(b.endDate)));
    // });

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

  Future<void> removeSubscription(String userId,
      Subscription subscription) async {
    final collectionRef = getCollection();
    final docRef = collectionRef.doc(userId);

    await docRef.update({
      'subscriptions': FieldValue.arrayRemove(
          [Subscription.toJson(subscription)])
    });
  }

}
