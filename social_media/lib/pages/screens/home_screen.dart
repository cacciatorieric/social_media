import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _page = 0;
  late PageController pageController;

  @override
  void initState() {
    super.initState();
    pageController = PageController();
  }

  @override
  void dispose() {
    super.dispose();
    pageController.dispose();
  }

  void navigationTapped(int page) {
    pageController.jumpToPage(page);
  }

  void onPageChanged(int page) {
    setState(() {
      _page = page;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: pageController,
        onPageChanged: onPageChanged,
        children: [
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
          kIsWeb
              ? Container(
                  color: Colors.blueAccent,
                  child: const Center(
                    child: Text(
                      'Add Post Web',
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                )
              : Container(
                  color: Colors.greenAccent,
                  child: const Center(
                    child: Text(
                      'Add Post Mobile',
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                ),
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
        ],
      ),
      bottomNavigationBar: CupertinoTabBar(
        items: [
          BottomNavigationBarItem(
            icon: Icon(
              Icons.home,
              color: _page == 0 ? Colors.red : Colors.amber,
            ),
            backgroundColor: Colors.black,
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.search,
              color: _page == 1 ? Colors.red : Colors.amber,
            ),
            label: '',
            backgroundColor: Colors.black,
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.add_circle,
              color: _page == 2 ? Colors.red : Colors.amber,
            ),
            label: '',
            backgroundColor: Colors.black,
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.favorite,
              color: _page == 3 ? Colors.red : Colors.amber,
            ),
            label: '',
            backgroundColor: Colors.black,
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.person,
              color: _page == 4 ? Colors.red : Colors.amber,
            ),
            label: '',
            backgroundColor: Colors.black,
          ),
        ],
        onTap: navigationTapped,
      ),
    );
  }
}
