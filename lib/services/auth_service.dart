import 'dart:io';

import 'package:camera/camera.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart';

class AuthException implements Exception {
  String message;
  AuthException(this.message);
}

class AuthService extends ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  User? usuario;
  bool isLoading = true;

  FirebaseAuth get auth => _auth;

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
    try {
      await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
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

  Future uploadImage(XFile? image) async {
    FirebaseStorage storage = FirebaseStorage.instance;
    Reference ref = storage.ref().child("profile/${DateTime.now().toString()}");
    UploadTask uploadTask = ref.putFile(File(image!.path));
    uploadTask.whenComplete(() async {
      String url = await ref.getDownloadURL();
      print("Profile Picture uploaded $url");
      _updateUserPhoto(url);
    });
  }

  _updateUserPhoto(String url) {
    usuario?.updatePhotoURL(url);
  }
}
