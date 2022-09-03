import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:social_media/components/post_card.dart';

class FeedScreen extends StatelessWidget {
  const FeedScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        title: const Text(
          'Tela de Feed',
          style: TextStyle(
            color: kIsWeb ? Colors.lightGreenAccent : Colors.redAccent,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.message_outlined),
          ),
        ],
      ),
      body: const PostCard(),
    );
  }
}
