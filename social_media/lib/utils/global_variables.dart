import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:social_media/pages/screens/add_post_screen.dart';

const webScreenSize = 600;

var homeScreenItens = [
  kIsWeb
      ? Container(
          color: Colors.blueAccent,
          child: const Center(
            child: Text(
              'Feed Web',
              style: TextStyle(color: Colors.black),
            ),
          ),
        )
      : Container(
          color: Colors.greenAccent,
          child: const Center(
            child: Text(
              'Feed Mobile',
              style: TextStyle(color: Colors.black),
            ),
          ),
        ),
  kIsWeb
      ? Container(
          color: Colors.blueAccent,
          child: const Center(
            child: Text(
              'Search Web',
              style: TextStyle(color: Colors.black),
            ),
          ),
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
  AddPostScreen(),
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
