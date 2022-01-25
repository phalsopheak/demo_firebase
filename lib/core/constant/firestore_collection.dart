import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreCollection {
  const FirestoreCollection();

  static CollectionReference customer =
      FirebaseFirestore.instance.collection('Customer');
}
