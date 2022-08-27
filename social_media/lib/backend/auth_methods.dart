import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:social_media/backend/storage_methods.dart';
import 'package:social_media/models/user.dart';
import 'package:social_media/utils/utils.dart';

class AuthMethods {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  BuildContext? context;

  Future<String> signUpUser({
    required String email,
    required String password,
    required String username,
    required String bio,
    required Uint8List file,
  }) async {
    String resposta = 'Algum erro aconteceu';
    try {
      if (email.isNotEmpty ||
          password.isNotEmpty ||
          username.isNotEmpty ||
          bio.isNotEmpty ||
          file != null) {
        UserCredential cred = await _auth.createUserWithEmailAndPassword(
          email: email,
          password: password,
        );

        String photoUrl = await StorageMethods()
            .uploadImageToStorage('profilePics', file, false);

        Usuarios usuario = Usuarios(
            username: username,
            uid: cred.user!.uid,
            email: email,
            bio: bio,
            followers: [],
            following: [],
            photoUrl: photoUrl);

        //adicionar usuarios no firestore
        await _firestore.collection('users').doc(cred.user!.uid).set(
              usuario.toJson(),
            );
        resposta = 'sucesso';
        print(resposta);
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'invalid-email') {
        resposta = 'O formato do e-mail não está correto';
        print(resposta);
      } else if (e.code == 'weak-password') {
        resposta = 'Senha FRACA. Tente com mais de 6 caracteres';
        print(resposta);
      }
    } catch (e) {
      resposta = 'Erros diversos -> segue codigo: ${e.toString()}';
      print(resposta);
    }
    return resposta;
  }

  //Método para usuario logar na pagina de login (logico que vai logar na pagina de login né retardado)
  Future<String> loginUser({
    required String email,
    required String password,
  }) async {
    String resposta = 'Algum erro aconteceu';
    try {
      if (email.isNotEmpty || password.isNotEmpty) {
        await _auth.signInWithEmailAndPassword(
          email: email,
          password: password,
        );
        resposta = 'sucesso';
        print(resposta);
      } else {
        resposta = 'Preencha todos os campos';
      }
    } on FirebaseAuthException catch (errinho) {
      if (errinho.code == 'invalid-email') {
        resposta = 'O formato do e-mail não está correto';
      } else if (errinho.code == 'wrong-password') {
        resposta = 'Senha errada ';
      } else if (errinho.code == 'internal-error') {
        resposta = 'Preencha todos os campos corretamente';
      }
    } catch (e) {
      resposta = e.toString();
      print(resposta);
    }
    return resposta;
  }
}
