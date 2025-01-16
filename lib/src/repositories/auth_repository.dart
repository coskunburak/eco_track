import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthRepository {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final CollectionReference collectionUsers =
      FirebaseFirestore.instance.collection("Users");
  final CollectionReference collectionPermissions =
      FirebaseFirestore.instance.collection("permissions");

  Future<UserCredential> signUp({
    required String email,
    required String password,
    required String name,
    required String surname,
  }) async {
    try {
      UserCredential userCredential =
          await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      int permissionId = await _getNextPermissionId();

      await collectionPermissions.doc(permissionId.toString()).set({
        'canEditUser': false,
        'authorityLevel': 0,
        'permissionId': permissionId,
      });

      await _addUserToFirestore(
          userCredential.user?.uid, email, name, surname, permissionId);

      return userCredential;
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<UserCredential> signIn({
    required String email,
    required String password,
  }) async {
    try {
      UserCredential userCredential =
          await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      await collectionUsers.doc(userCredential.user?.uid).update({
        'loginTimes': FieldValue.serverTimestamp(),
      });

      return userCredential;
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<void> resetPassword({required String email}) async {
    try {
      await _firebaseAuth.sendPasswordResetEmail(email: email);
    } on FirebaseAuthException catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<Map<String, dynamic>?> getUserPermissions(String uid) async {
    try {
      DocumentSnapshot snapshot = await collectionUsers.doc(uid).get();
      if (snapshot.exists) {
        var data = snapshot.data() as Map<String, dynamic>;
        String permissionId = data['permissionId'].toString();

        DocumentSnapshot permissionSnapshot =
            await collectionPermissions.doc(permissionId).get();
        if (permissionSnapshot.exists) {
          return permissionSnapshot.data() as Map<String, dynamic>?;
        }
      }
      return null;
    } catch (e) {
      throw Exception('Error getting permissions: $e');
    }
  }

  Future<int> _getNextPermissionId() async {
    QuerySnapshot snapshot = await collectionPermissions
        .orderBy('permissionId', descending: true)
        .limit(1)
        .get();
    if (snapshot.docs.isEmpty) {
      return 1;
    }
    int maxId = snapshot.docs.first['permissionId'] as int;
    return maxId + 1;
  }

  Future<void> _addUserToFirestore(
    String? uid,
    String email,
    String name,
    String surname,
    int permissionId,
  ) async {
    if (uid == null) return;

    Timestamp now = Timestamp.now();

    await collectionUsers.doc(uid).set({
      'email': email,
      'name': name,
      'surname': surname,
      'createdAt': now,
      'loginTimes': FieldValue.arrayUnion([now]),
      'permissionId': permissionId,
    }, SetOptions(merge: true));
  }

  Stream<int?> getUserAuthorityLevelStream(String uid) {
    return FirebaseFirestore.instance
        .collection('Users')
        .doc(uid)
        .snapshots()
        .asyncMap((snapshot) async {
      if (snapshot.exists) {
        var userData = snapshot.data() as Map<String, dynamic>;
        String permissionId = userData['permissionId'].toString();

        DocumentSnapshot permissionSnapshot = await FirebaseFirestore.instance
            .collection('permissions')
            .doc(permissionId)
            .get();

        if (permissionSnapshot.exists) {
          var permissionData =
              permissionSnapshot.data() as Map<String, dynamic>;
          return permissionData['authorityLevel'] as int?;
        }
      }
      return null;
    });
  }

  Future<bool> getCanEditUser(String uid) async {
    try {
      DocumentSnapshot userSnapshot =
          await FirebaseFirestore.instance.collection('Users').doc(uid).get();

      if (userSnapshot.exists) {
        var userData = userSnapshot.data() as Map<String, dynamic>;
        String permissionId = userData['permissionId'].toString();

        DocumentSnapshot permissionSnapshot = await FirebaseFirestore.instance
            .collection('permissions')
            .doc(permissionId)
            .get();

        if (permissionSnapshot.exists) {
          var permissionData =
              permissionSnapshot.data() as Map<String, dynamic>;
          return permissionData['canEditUser'] as bool;
        }
      }
      return false;
    } catch (e) {
      throw Exception('Error getting canEditUser: $e');
    }
  }
}
