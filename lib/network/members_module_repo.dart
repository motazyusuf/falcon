import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:opticore/opticore.dart';

import 'member_model.dart';

class MembersModuleRepo extends BaseRepo {

  static CollectionReference<Member> getCollection() {
    return FirebaseFirestore.instance
        .collection('Members')
        .withConverter<Member>(
        fromFirestore: (snapshot, _) =>
            Member.fromJson(snapshot.data()!),
        toFirestore: (value, _) => Member.toJson(value));
  }

  Future<void> addMember(Member member) async {
    // reference the collection || create if !exist
    var collectionRef = getCollection();

    // create empty document with id
    var documentRef = collectionRef.doc();

    member.id = documentRef.id;

    print(">>>>>>>>>>>>>>$member.id");

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
}
