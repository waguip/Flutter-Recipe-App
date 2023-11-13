import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthException implements Exception {
  String message;
  AuthException(this.message);
}

class AuthService extends ChangeNotifier {
  FirebaseAuth _auth = FirebaseAuth.instance;
  User? usuario;
  bool isLoading = true;

  AuthService() {
    _authCheck();
  }

  _authCheck() {
    _auth.authStateChanges().listen((User? user) {
      usuario = (user == null) ? null : user;
      isLoading = false;
      notifyListeners();
    });
  }

  _getUser() {
    usuario = _auth.currentUser;
    notifyListeners();
  }

  Future register(String email, String password) async {
    try {
      await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      print("Do registere auth_service: ${email}, ${password}");
      _getUser();
    } on FirebaseAuthException catch (e) {
      print(e.code);
      if (e.code == 'weak-password') {
        throw AuthException('A senha é muito fraca');
      } else if (e.code == 'email-already-in-use') {
        throw AuthException('Email já cadastrado');
      }
    }
  }

  Future login(String email, String password) async {
    print("Entrou no login");
    try {
      await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      print("Do login auth_service: ${email}, ${password}");
      _getUser();
    } on FirebaseAuthException catch (e) {
      print(e.code);
      if (e.code == 'user-not-found') {
        throw AuthException('Usuario não encontrado');
      } else if (e.code == 'wrong-password') {
        throw AuthException('Senha incorreta');
      } else if (e.code == 'invalid-email') {
        throw AuthException('Email inválido');
      }
    }
  }

  Future logout() async {
    await _auth.signOut();
    _getUser();
  }
}
