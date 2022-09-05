import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:social_media/components/comments_card.dart';

class CommentsScreen extends StatefulWidget {
  const CommentsScreen({Key? key}) : super(key: key);

  @override
  State<CommentsScreen> createState() => _CommentsScreenState();
}

class _CommentsScreenState extends State<CommentsScreen> {
  @override
  Widget build(BuildContext context) {
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
              const CircleAvatar(
                backgroundColor: Colors.blue,
              ),
              const Expanded(
                child: Padding(
                  padding: EdgeInsets.only(left: 16, right: 8),
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: 'Comentar',
                      border: InputBorder.none,
                    ),
                  ),
                ),
              ),
              TextButton(
                onPressed: () {},
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
