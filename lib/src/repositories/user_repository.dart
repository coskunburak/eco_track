import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

class UserRepository {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final CollectionReference<Map<String, dynamic>> collectionUsers =
  FirebaseFirestore.instance.collection("Users");
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;

  Future<DocumentSnapshot<Map<String, dynamic>>> getUserInfo(String uid) async {
    try {
      final snapshot = await collectionUsers.doc(uid).get();
      return snapshot as DocumentSnapshot<Map<String, dynamic>>;
    } catch (e) {
      throw Exception('Error fetching user info: $e');
    }
  }



  Future<void> updateUserInfo(String uid, Map<String, dynamic> data) async {
    try {
      await collectionUsers.doc(uid).update(data);
    } catch (e) {
      throw Exception('Error updating user info: $e');
    }
  }

  Future<void> deleteUser(String uid) async {
    try {
      DocumentSnapshot<Map<String, dynamic>> userDoc =
      await collectionUsers.doc(uid).get();

      if (userDoc.exists) {
        await collectionUsers.doc(uid).delete();

        final user = _firebaseAuth.currentUser;
        if (user != null && user.uid == uid) {
          await user.delete();
        } else {
          throw Exception('No user is logged in.');
        }
      } else {
        throw Exception('User not found.');
      }
    } catch (e) {
      throw Exception('Error deleting user: $e');
    }
  }

  Future<void> updateEmail(String newEmail) async {
    final user = _firebaseAuth.currentUser;

    try {
      if (user != null) {
        await user.updateEmail(newEmail);
        await user.sendEmailVerification();
        await _firebaseAuth.signOut();
      } else {
        throw Exception('No user is logged in.');
      }
    } catch (e) {
      throw Exception('Error updating email: $e');
    }
  }

  Future<void> updatePassword(String oldPassword, String newPassword) async {
    final user = _firebaseAuth.currentUser;
    final credential = EmailAuthProvider.credential(
      email: user!.email!,
      password: oldPassword,
    );

    try {
      await user.reauthenticateWithCredential(credential);
      await user.updatePassword(newPassword);
    } catch (e) {
      throw Exception('Error updating password: $e');
    }
  }

  Future<String?> getMessageToken() async {
    try {
      return await _firebaseMessaging.getToken();
    } catch (e) {
      throw Exception('Error fetching message token: $e');
    }
  }

  Future<void> saveMessageToken(String uid, String? token) async {
    if (token == null) return;
    try {
      await collectionUsers.doc(uid).update({'messageToken': token});
    } catch (e) {
      throw Exception('Error saving message token: $e');
    }
  }
}
