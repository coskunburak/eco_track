// user_repository.dart
import 'package:cloud_firestore/cloud_firestore.dart';

class UserRepository {
  final FirebaseFirestore _firestore;

  UserRepository({FirebaseFirestore? firestore})
      : _firestore = firestore ?? FirebaseFirestore.instance;

  Future<void> createUser(String uid, Map<String, dynamic> data) async {
    await _firestore.collection("users").doc(uid).set(data);
  }

  Future<void> incrementLoginTimes(String uid) async {
    await _firestore.collection("users").doc(uid).update({
      "logintimes": FieldValue.increment(1),
    });
  }

  Future<Map<String, dynamic>> getUser(String uid) async {
    DocumentSnapshot doc = await _firestore.collection("users").doc(uid).get();
    if (doc.exists) {
      return doc.data() as Map<String, dynamic>;
    } else {
      throw Exception("User not found");
    }
  }
}
