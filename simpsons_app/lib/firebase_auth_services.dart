import 'package:firebase_auth/firebase_auth.dart';

class FirebaseAuthService {

  FirebaseAuth _auth = FirebaseAuth.instance;

  Future<User?> signUpWithEmailAndPassword(String email, String password) async {

    // Email ve şifre ile kullanıcı kaydı işlemini gerçekleştirildi.

    try {
      UserCredential credential =await _auth.createUserWithEmailAndPassword(email: email, password: password);

      // FirebaseAuth.createUserWithEmailAndPassword kullanarak kullanıcı oluşturma işlemi gerçekleştirildi.

      return credential.user; // Oluşturulan kullanıcıyı döndürür

    } on FirebaseAuthException catch (e) {

    }
    return null;
  }

  Future<User?> signInWithEmailAndPassword(String email, String password) async {

    try {

      UserCredential credential =await _auth.signInWithEmailAndPassword(email: email, password: password);

      return credential.user;

    } on FirebaseAuthException catch (e) {

    }
    return null;
  }

}