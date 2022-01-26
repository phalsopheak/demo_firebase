import 'package:firebase_storage/firebase_storage.dart';

class FirebaseStorageReference {
  const FirebaseStorageReference();

  static Reference customerProfile =
      FirebaseStorage.instance.ref().child('customer_profile');
}
