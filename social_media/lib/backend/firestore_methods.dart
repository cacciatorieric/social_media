import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:social_media/backend/storage_methods.dart';
import 'package:social_media/models/post.dart';
import 'package:uuid/uuid.dart';

class FirestoreMethods {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

//Método para postar
  Future<String> uploadPost(
    String uid,
    String description,
    String username,
    String profImage,
    Uint8List file,
  ) async {
    String res = 'Foi detectado um erro, tente novamente';

    try {
      String photoUrl =
          await StorageMethods().uploadImageToStorage('posts', file, true);
      String postId = const Uuid().v1();
      Post post = Post(
        uid: uid,
        description: description,
        username: username,
        postId: postId,
        datePublished: DateTime.now(),
        postUrl: photoUrl,
        profImage: profImage,
        likes: [],
      );
      _firestore.collection('posts').doc(postId).set(post.toJson());
      res = 'sucesso';
    } catch (err) {
      res = err.toString();
    }
    return res;
  }
}
