import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eco_track/src/repositories/user_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../models/userDetail.dart';

class AuthRepository {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final CollectionReference collectionUsers =
  FirebaseFirestore.instance.collection("Users");
  final UserRepository userRepository = UserRepository();

  Future<void> signUp({
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

      await _addUserToFirestore(
        uid: userCredential.user?.uid,
        email: email,
        name: name,
        surname: surname,
      );

      String? token = await userRepository.getMessageToken();
      await userRepository.saveMessageToken(
          userCredential.user?.uid ?? "", token);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        throw Exception('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        throw Exception('The email address is already in use.');
      } else {
        throw Exception('Authentication error: ${e.message}');
      }
    } catch (e) {
      throw Exception('An error occurred: $e');
    }
  }

  Future<bool> signIn({required String email, required String password}) async {
    try {
      // Firebase ile kullanıcı girişi
      UserCredential userCredential = await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      String? uid = userCredential.user?.uid;

      if (uid != null) {
        DocumentSnapshot snapshot = await collectionUsers.doc(uid).get();

        print("Firestore'dan gelen veri: ${snapshot.data()}");

        final userData = snapshot.data() as Map<String, dynamic>?;

        if (userData != null) {
          UserDetail userDetail = UserDetail.fromMap(userData);
          print("Kullanıcı Bilgileri: ${userDetail.email}");
        } else {
          throw Exception("Kullanıcı verileri bulunamadı.");
        }

        await collectionUsers.doc(uid).update({
          'loginTimes': FieldValue.arrayUnion([Timestamp.now()]),
        });
      }

      String? token = await userRepository.getMessageToken();
      await userRepository.saveMessageToken(uid ?? "", token);

      return true;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        throw Exception('Bu e-postayla kayıtlı kullanıcı bulunamadı.');
      } else if (e.code == 'wrong-password') {
        throw Exception('Girilen şifre hatalı.');
      } else {
        throw Exception('Authentication error: ${e.message}');
      }
    } catch (e) {
      throw Exception('Bir hata oluştu: $e');
    }
  }


  Future<void> resetPassword({required String email}) async {
    try {
      await _firebaseAuth.sendPasswordResetEmail(email: email);
    } on FirebaseAuthException catch (e) {
      throw Exception('Password reset error: ${e.message}');
    }
  }

  Future<void> _addUserToFirestore({
    required String? uid,
    required String email,
    required String name,
    required String surname,
  }) async {
    if (uid == null) throw Exception('Invalid UID');

    Timestamp now = Timestamp.now();

    await collectionUsers.doc(uid).set({
      'email': email,
      'name': name,
      'surname': surname,
      'createdAt': now,
      'loginTimes': [now],
    }, SetOptions(merge: true));
  }
}
