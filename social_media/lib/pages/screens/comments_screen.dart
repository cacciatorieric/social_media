import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:social_media/backend/firestore_methods.dart';
import 'package:social_media/components/comments_card.dart';
import 'package:social_media/models/user.dart';
import 'package:social_media/provider/user_provider.dart';

class CommentsScreen extends StatefulWidget {
  final snap;
  const CommentsScreen({Key? key, required this.snap}) : super(key: key);

  @override
  State<CommentsScreen> createState() => _CommentsScreenState();
}

class _CommentsScreenState extends State<CommentsScreen> {
  final TextEditingController _commentController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    _commentController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Usuario usuario = Provider.of<UserProvider>(context).getUser;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Navigator.of(context).pop(),
          icon: const Icon(
            Icons.arrow_back_ios,
            color: kIsWeb
                ? Color.fromARGB(255, 52, 5, 146)
                : Color.fromARGB(255, 255, 0, 179),
          ),
        ),
        backgroundColor: Colors.white,
        title: const Text(
          'Tela de Feed',
          style: TextStyle(
            color: kIsWeb
                ? Color.fromARGB(255, 52, 5, 146)
                : Color.fromARGB(255, 255, 0, 179),
          ),
        ),
      ),
      body: const CommentsCard(),
      bottomNavigationBar: SafeArea(
        child: Container(
          height: kToolbarHeight,
          margin: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          padding: const EdgeInsets.only(left: 16, right: 8),
          child: Row(
            children: [
              CircleAvatar(
                backgroundImage: NetworkImage(usuario.photoUrl!),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(left: 16, right: 8),
                  child: TextField(
                    controller: _commentController,
                    decoration: InputDecoration(
                      hintText: 'Comentar como ${usuario.username!}',
                      border: InputBorder.none,
                    ),
                  ),
                ),
              ),
              TextButton(
                onPressed: () async {
                  await FirestoreMethods().postComment(
                    widget.snap['postId'],
                    _commentController.text,
                    usuario.uid!,
                    usuario.username!,
                    usuario.photoUrl!,
                  );
                },
                child: const Text(
                  'Postar',
                  style: TextStyle(
                      color: kIsWeb
                          ? Color.fromARGB(255, 52, 5, 146)
                          : Color.fromARGB(255, 255, 0, 179),
                      fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
