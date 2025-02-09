// auth_repository.dart
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/userDetail.dart';
import 'user_repository.dart';

class AuthRepository {
  final FirebaseAuth _firebaseAuth;
  final UserRepository _userRepository;

  AuthRepository({
    FirebaseAuth? firebaseAuth,
    required UserRepository userRepository,
  })  : _firebaseAuth = firebaseAuth ?? FirebaseAuth.instance,
        _userRepository = userRepository;

  Future<User?> signUp({
    required String name,
    required String surname,
    required String email,
    required String password,
  }) async {
    try {
      UserCredential userCredential = await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      User? firebaseUser = userCredential.user;
      if (firebaseUser != null) {
        final appUser = Userdetail(
          email: firebaseUser.email ?? '',
          password: 'burada şifre tutulmaz', // Şifreyi doğrudan saklamazsınız.
          name: firebaseUser.displayName ?? name,
          surname: surname,
        );

        final userData = {
          "name": appUser.name,
          "surname": appUser.surname,
          "email": appUser.email,
          "logintimes": 1,
          "timestamp": FieldValue.serverTimestamp(),
        };

        await _userRepository.createUser(firebaseUser.uid, userData);
      }
      return firebaseUser;
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<User?> login({
    required String email,
    required String password,
  }) async {
    try {
      UserCredential userCredential = await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      User? user = userCredential.user;
      if (user != null) {
        await _userRepository.incrementLoginTimes(user.uid);
      }
      return user;
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<void> resetPassword({required String email}) async {
    try {
      await _firebaseAuth.sendPasswordResetEmail(email: email);
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<void> signOut() async {
    await _firebaseAuth.signOut();
  }
}
