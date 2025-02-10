// user_repository.dart
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UserRepository {
  final FirebaseFirestore _firestore;
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

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
      throw Exception("Kullanıcı Bulunamadı.");
    }
  }
/*  Future<DocumentSnapshot> getUserInfo(String uid) async {
    try {
      return await _firestore.collection('users').doc(uid).get();
    } catch (e) {
      throw Exception('Kullanıcı bilgileri alınırken hata oluştu: $e');
    }
  }*/
  Future<void> updateUserInfo(String uid, Map<String, dynamic> data) async {
    try {
      await _firestore.collection("users").doc(uid).update(data);
    } catch (e) {
      throw Exception('Kullanıcı bilgisi güncellenirken hata oluştu: $e');
    }
  }

  Future<void> deleteUser(String uid) async {
    try{
      DocumentSnapshot userDoc = await _firestore.collection('users').doc(uid).get();
      var userData = userDoc.data() as Map<String, dynamic>?;

      if(userData != null && userDoc.exists) {
        var permissionId = userData['permissionId'];
        String permissionIdStr = permissionId.toString();
        await _firestore.collection('users').doc(uid).delete();
        final user = FirebaseAuth.instance.currentUser;
        if(user != null && user.uid == uid) {
          await FirebaseFirestore.instance
              .collection('permissions')
              .doc(permissionIdStr)
              .delete();

          await user.delete();
        } else {
          throw Exception('kullanıcı oturum açmamış.');
        }
      } else {
        throw Exception('Kullanıcı bulunamadı.');
      }
    } catch (e) {
      throw Exception('Kullanıcı silerken hata oluştu.');
    }
  }

  Future<void> updateEmail(String newEmail) async {
    final user = FirebaseAuth.instance.currentUser;

    try {
      if(user != null){
        await user.updateEmail(newEmail);
        await user.sendEmailVerification();
        await FirebaseAuth.instance.signOut();
      } else {
        throw Exception('Şu anda oturum açmış bir kullanıcı bulunmuyor.');
      }
    }catch(e){
      throw Exception('E posta adresiniz güncellenmiştir.  Lütfen yeni e-posta adresinize gelen doğrulama bağlantısını kontrol edin ve yeniden giriş yapın.');
    }
  }

  Future<void> updatePassword(String oldPassword, String newPassword) async{
    final user = _firebaseAuth.currentUser;
    final credential = EmailAuthProvider.credential(
      email: user!.email!,
      password: oldPassword,
    );

    try {
      await user.reauthenticateWithCredential(credential);
      await user.updatePassword(newPassword);
    } catch (e) {
      throw Exception('Şifre güncellenirken bir hata oluştu: $e');
    }
  }
}
