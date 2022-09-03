import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:social_media/pages/screens/add_post_screen.dart';
import 'package:social_media/pages/screens/feed_screen.dart';
import 'package:uuid/uuid.dart';

const webScreenSize = 600;

var homeScreenItens = [
  const FeedScreen(),
  kIsWeb
      ? Container(
          color: Colors.blueAccent,
          child: const Center(child: Text('Search Web')),
        )
      : Container(
          color: Colors.greenAccent,
          child: const Center(
            child: Text(
              'Search Mobile',
              style: TextStyle(color: Colors.black),
            ),
          ),
        ),
  const AddPostScreen(),
  kIsWeb
      ? Container(
          color: Colors.blueAccent,
          child: const Center(
            child: Text(
              'Notificações Web',
              style: TextStyle(color: Colors.black),
            ),
          ),
        )
      : Container(
          color: Colors.greenAccent,
          child: const Center(
            child: Text(
              'Notificações Mobile',
              style: TextStyle(color: Colors.black),
            ),
          ),
        ),
  kIsWeb
      ? Container(
          color: Colors.blueAccent,
          child: const Center(
            child: Text(
              'Perfil Web',
              style: TextStyle(color: Colors.black),
            ),
          ),
        )
      : Container(
          color: Colors.greenAccent,
          child: const Center(
            child: Text(
              'Perfil Mobile',
              style: TextStyle(color: Colors.black),
            ),
          ),
        ),
];
