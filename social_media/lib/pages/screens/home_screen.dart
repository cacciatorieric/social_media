import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String username = '';
  FirebaseAuth userData = FirebaseAuth.instance;

  @override
  void initState() {
    super.initState();
    getUsername();
  }

  void getUsername() async {
    DocumentSnapshot snap = await FirebaseFirestore.instance
        .collection('users')
        .doc(userData.currentUser!.uid)
        .get();

    setState(() {
      username = (snap.data() as Map<String, dynamic>)['username'];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: kIsWeb
          ? Container(
              color: Colors.blueAccent,
              child: Center(
                child: Text('Seja bem vindo $username'),
              ),
            )
          : Container(
              color: Colors.greenAccent,
              child: Center(
                child: Text('Seja bem vindo $username'),
              ),
            ),
    );
  }
}
