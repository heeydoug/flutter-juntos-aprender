import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_juntos_aprender/screens/home_screen.dart';
import 'package:flutter_juntos_aprender/screens/login_screen.dart';
import 'package:flutter_juntos_aprender/utils/nav.dart';

class AuthService {
  FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  Future<String?> register(
      {required String name,
      required String password,
      required String email}) async {
    try {
      UserCredential userCredential = await _firebaseAuth
          .createUserWithEmailAndPassword(email: email, password: password);
      await userCredential.user!.updateDisplayName(name);
      return null;
    } on FirebaseAuthException catch (e) {
      if (e.code == "email-already-in-use") {
        return "O usuário já está cadastrado!";
      }
      return "Erro desconhecido";
    }
  }

  Future<String?> login(
      {context, required String email, required String password}) async {
    try {
      await _firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
      push(context, Home(), replace: true);
      return null;
    } on FirebaseAuthException catch (e) {
      return e.message;
    }
  }

  void logout(context) {
    _firebaseAuth.signOut();
    push(context, LoginScreen(), replace: true);
  }
}
