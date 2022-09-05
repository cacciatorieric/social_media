import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class CommentsCard extends StatefulWidget {
  const CommentsCard({Key? key}) : super(key: key);

  @override
  State<CommentsCard> createState() => _CommentsCardState();
}

class _CommentsCardState extends State<CommentsCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 16),
      child: Row(
        children: [
          const CircleAvatar(
            backgroundColor: Colors.red,
            radius: 18,
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(left: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  RichText(
                    text: const TextSpan(
                      children: [
                        TextSpan(
                          text: 'usuario',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, color: Colors.white),
                        ),
                        TextSpan(
                          text: '  ',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, color: Colors.white),
                        ),
                        TextSpan(
                          text: 'descrição escrita / para escrever',
                          style: TextStyle(color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(
                      top: 4,
                    ),
                    child: Text(
                      '23/10/2022',
                      style:
                          TextStyle(fontSize: 12, fontWeight: FontWeight.w400),
                    ),
                  ),
                ],
              ),
            ),
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.favorite,
              size: 20,
              color: Colors.red,
            ),
          ),
        ],
      ),
    );
  }
}
