import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:we_vest/dataStructures/bankInfo.dart';

final CollectionReference basicCollection = Firestore.instance.collection('Bank');

class FirebaseFirestoreService {

  static final FirebaseFirestoreService _instance = new FirebaseFirestoreService.internal();

  factory FirebaseFirestoreService() => _instance;

  FirebaseFirestoreService.internal();

  Future<Bank> createBank(String userId, String acct, String rout) async {
    final DocumentReference documentReference = Firestore.instance.document("Bank/" + userId);
    final Bank bank = new Bank(userId,acct,rout);
    final Map<String, dynamic> data = bank.toMap();
    documentReference.setData(data).whenComplete(() {
      return print("Document Added");
    }).catchError((e) => print(e));
  }

/*  Stream<QuerySnapshot> getBank({int offset, int limit}) {
    Stream<QuerySnapshot> snapshots = basicCollection.snapshots();

    if (offset != null) {
      snapshots = snapshots.skip(offset);
    }

    if (limit != null) {
      snapshots = snapshots.take(limit);
    }

    return snapshots;
  }*/

  Future<List<String>> getBank() async {
    DocumentSnapshot querySnapshot = await basicCollection.document("KL1GCdQQwsZhlJhjd9g1dnYfb0w2").get();
    if (querySnapshot.exists /*&&
        querySnapshot.data.containsKey('favorites') &&
        querySnapshot.data['favorites'] is List*/) {
      print(querySnapshot.data.toString());
      // Create a new List<String> from List<dynamic>
      return List<String>.from(querySnapshot.data['favorites']);
    }
    return [];
  }

  Future<dynamic> updateNote(Bank bank) async {
    final TransactionHandler updateTransaction = (Transaction tx) async {
      final DocumentSnapshot ds = await tx.get(basicCollection.document(bank.id));

      await tx.update(ds.reference, bank.toMap());
      return {'updated': true};
    };

    return Firestore.instance
        .runTransaction(updateTransaction)
        .then((result) => result['updated'])
        .catchError((error) {
      print('error: $error');
      return false;
    });
  }

  Future<dynamic> deleteNote(String id) async {
    final TransactionHandler deleteTransaction = (Transaction tx) async {
      final DocumentSnapshot ds = await tx.get(basicCollection.document(id));

      await tx.delete(ds.reference);
      return {'deleted': true};
    };

    return Firestore.instance
        .runTransaction(deleteTransaction)
        .then((result) => result['deleted'])
        .catchError((error) {
      print('error: $error');
      return false;
    });
  }
}