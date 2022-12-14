import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:social_media/backend/firestore_methods.dart';
import 'package:social_media/components/like_animation.dart';
import 'package:social_media/models/user.dart';
import 'package:social_media/pages/screens/comments_screen.dart';
import 'package:social_media/provider/user_provider.dart';
import 'package:social_media/utils/utils.dart';

class PostCard extends StatefulWidget {
  final snap;
  const PostCard({Key? key, required this.snap}) : super(key: key);

  @override
  State<PostCard> createState() => _PostCardState();
}

class _PostCardState extends State<PostCard> {
  bool isLikeAnimating = false;
  int commentLen = 0;

  @override
  void initState() {
    super.initState();
    getComments();
  }

  void getComments() async {
    try {
      QuerySnapshot snap = await FirebaseFirestore.instance
          .collection('posts')
          .doc(widget.snap['postId'])
          .collection('comments')
          .get();
      commentLen = snap.docs.length;
    } catch (erro) {
      showSnackBar(
          'Não foi possivel recuperar os comentarios.\nSegue erro -> ${erro.toString()}',
          context);
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final Usuario user = Provider.of<UserProvider>(context).getUser;
    return kIsWeb
        ? SingleChildScrollView(
            child: Container(
              color: Theme.of(context).colorScheme.primary,
              padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 16)
                  .copyWith(right: 0),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      CircleAvatar(
                        radius: 16,
                        backgroundImage: NetworkImage(
                          widget.snap['profImage'],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 8, horizontal: 16),
                        child: Text(
                          widget.snap['username'],
                          style: const TextStyle(
                              fontWeight: FontWeight.bold, color: Colors.black),
                        ),
                      ),
                      Expanded(
                        child: Align(
                          alignment: Alignment.centerRight,
                          child: IconButton(
                            onPressed: () {
                              showDialog(
                                  context: context,
                                  builder: (context) => Dialog(
                                        child: ListView(
                                          padding: const EdgeInsets.symmetric(
                                            vertical: 16,
                                          ),
                                          shrinkWrap: true,
                                          children: ['Excluir comentário']
                                              .map(
                                                (e) => InkWell(
                                                  onTap: () async {
                                                    FirestoreMethods()
                                                        .deletePost(widget
                                                            .snap['postId']);
                                                    Navigator.of(context).pop();
                                                  },
                                                  child: Container(
                                                    padding: const EdgeInsets
                                                            .symmetric(
                                                        vertical: 12,
                                                        horizontal: 16),
                                                    child: Text(e),
                                                  ),
                                                ),
                                              )
                                              .toList(),
                                        ),
                                      ));
                            },
                            icon: const Icon(Icons.more_vert,
                                color: Colors.black),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(left: 8),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              GestureDetector(
                                onDoubleTap: () async {
                                  await FirestoreMethods().likePost(
                                    widget.snap['postId'],
                                    user.uid!,
                                    widget.snap['likes'],
                                  );
                                  setState(() {
                                    isLikeAnimating = true;
                                  });
                                },
                                child: Stack(
                                  alignment: Alignment.center,
                                  children: [
                                    SizedBox(
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.7,
                                      width: MediaQuery.of(context).size.width *
                                          0.9,
                                      child: Image.network(
                                        widget.snap['postUrl'],
                                        fit: BoxFit.scaleDown,
                                      ),
                                    ),
                                    AnimatedOpacity(
                                      duration: const Duration(
                                        milliseconds: 200,
                                      ),
                                      opacity: isLikeAnimating ? 1 : 0,
                                      child: LikeAnimation(
                                        isAnimating: isLikeAnimating,
                                        duration:
                                            const Duration(milliseconds: 400),
                                        onEnd: () {
                                          setState(() {
                                            isLikeAnimating = false;
                                          });
                                        },
                                        child: const Icon(
                                          Icons.favorite,
                                          color: Colors.white,
                                          size: 100,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Row(
                                children: [
                                  LikeAnimation(
                                    smallLike: true,
                                    isAnimating: widget.snap['likes']
                                        .contains(user.uid!),
                                    child: IconButton(
                                      onPressed: () async {
                                        await FirestoreMethods().likePost(
                                          widget.snap['postId'],
                                          user.uid!,
                                          widget.snap['likes'],
                                        );
                                      },
                                      icon: widget.snap['likes']
                                              .contains(user.uid)
                                          ? const Icon(
                                              Icons.favorite,
                                              color: Colors.red,
                                            )
                                          : const Icon(
                                              Icons.favorite_border,
                                              color: Colors.red,
                                            ),
                                    ),
                                  ),
                                  IconButton(
                                    onPressed: () => Navigator.of(context).push(
                                      MaterialPageRoute(
                                        builder: (context) => CommentsScreen(
                                          snap: widget.snap,
                                        ),
                                      ),
                                    ),
                                    icon: const Icon(
                                      Icons.comment_outlined,
                                      color: Colors.black,
                                    ),
                                  ),
                                  IconButton(
                                    onPressed: () {},
                                    icon: const Icon(
                                      Icons.send,
                                      color: Colors.black,
                                    ),
                                  ),
                                  Expanded(
                                    child: Align(
                                      alignment: Alignment.bottomRight,
                                      child: IconButton(
                                        onPressed: () {},
                                        icon: const Icon(
                                          Icons.bookmark_border_outlined,
                                          color: Colors.black,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Container(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 16),
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      '${widget.snap['likes'].length} curtidas',
                                      style: const TextStyle(
                                        color: Colors.black,
                                      ),
                                    ),
                                    Container(
                                      width: double.infinity,
                                      padding: const EdgeInsets.only(
                                        top: 8,
                                      ),
                                      child: RichText(
                                        text: TextSpan(
                                          children: [
                                            TextSpan(
                                              text: widget.snap['username'],
                                              style: const TextStyle(
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            const TextSpan(text: ' '),
                                            TextSpan(
                                              text: widget.snap['description'],
                                              style: const TextStyle(
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    Center(
                                      child: InkWell(
                                        mouseCursor: SystemMouseCursors.click,
                                        child: Container(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 4),
                                          child: Text(
                                            'Mostrar $commentLen comentários',
                                            style: const TextStyle(
                                              fontSize: 16,
                                              color: Colors.black54,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    Container(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 4),
                                      child: Text(
                                        DateFormat('dd/MM/yyyy hh:mm').format(
                                          widget.snap['datePublished'].toDate(),
                                        ),
                                        style: const TextStyle(
                                          fontSize: 12,
                                          color: Colors.black,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          )
        : Container(
            color: Theme.of(context).colorScheme.primary,
            padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 16)
                .copyWith(right: 0),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    CircleAvatar(
                      radius: 16,
                      backgroundImage: NetworkImage(
                        widget.snap['profImage'],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 8, horizontal: 16),
                      child: Text(
                        widget.snap['username'],
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, color: Colors.black),
                      ),
                    ),
                    Expanded(
                      child: Align(
                        alignment: Alignment.centerRight,
                        child: IconButton(
                          onPressed: () {
                            showDialog(
                                context: context,
                                builder: (context) => Dialog(
                                      child: ListView(
                                        padding: const EdgeInsets.symmetric(
                                          vertical: 16,
                                        ),
                                        shrinkWrap: true,
                                        children: ['Excluir comentário']
                                            .map(
                                              (e) => InkWell(
                                                onTap: () async {
                                                  FirestoreMethods().deletePost(
                                                      widget.snap['postId']);
                                                  Navigator.of(context).pop();
                                                },
                                                child: Container(
                                                  padding: const EdgeInsets
                                                          .symmetric(
                                                      vertical: 12,
                                                      horizontal: 16),
                                                  child: Text(e),
                                                ),
                                              ),
                                            )
                                            .toList(),
                                      ),
                                    ));
                          },
                          icon:
                              const Icon(Icons.more_vert, color: Colors.black),
                        ),
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(left: 8),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            GestureDetector(
                              onDoubleTap: () async {
                                await FirestoreMethods().likePost(
                                  widget.snap['postId'],
                                  user.uid!,
                                  widget.snap['likes'],
                                );
                                setState(() {
                                  isLikeAnimating = true;
                                });
                              },
                              child: Stack(
                                alignment: Alignment.center,
                                children: [
                                  SizedBox(
                                    height: MediaQuery.of(context).size.height *
                                        0.35,
                                    width: MediaQuery.of(context).size.width *
                                        0.90,
                                    child: Image.network(
                                      widget.snap['postUrl'],
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  AnimatedOpacity(
                                    duration: const Duration(
                                      milliseconds: 200,
                                    ),
                                    opacity: isLikeAnimating ? 1 : 0,
                                    child: LikeAnimation(
                                      isAnimating: isLikeAnimating,
                                      duration:
                                          const Duration(milliseconds: 400),
                                      onEnd: () {
                                        setState(() {
                                          isLikeAnimating = false;
                                        });
                                      },
                                      child: const Icon(
                                        Icons.favorite,
                                        color: Colors.white,
                                        size: 100,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Row(
                              children: [
                                LikeAnimation(
                                  smallLike: true,
                                  isAnimating:
                                      widget.snap['likes'].contains(user.uid!),
                                  child: IconButton(
                                    onPressed: () async {
                                      await FirestoreMethods().likePost(
                                        widget.snap['postId'],
                                        user.uid!,
                                        widget.snap['likes'],
                                      );
                                    },
                                    icon:
                                        widget.snap['likes'].contains(user.uid)
                                            ? const Icon(
                                                Icons.favorite,
                                                color: Colors.red,
                                              )
                                            : const Icon(
                                                Icons.favorite_border,
                                                color: Colors.red,
                                              ),
                                  ),
                                ),
                                IconButton(
                                  onPressed: () => Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (context) => CommentsScreen(
                                        snap: widget.snap,
                                      ),
                                    ),
                                  ),
                                  icon: const Icon(
                                    Icons.comment_outlined,
                                    color: Colors.black,
                                  ),
                                ),
                                IconButton(
                                  onPressed: () {},
                                  icon: const Icon(
                                    Icons.send,
                                    color: Colors.black,
                                  ),
                                ),
                                Expanded(
                                  child: Align(
                                    alignment: Alignment.bottomRight,
                                    child: IconButton(
                                      onPressed: () {},
                                      icon: const Icon(
                                        Icons.bookmark_border_outlined,
                                        color: Colors.black,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Container(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 16),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    '${widget.snap['likes'].length} curtidas',
                                    style: const TextStyle(
                                      color: Colors.black,
                                    ),
                                  ),
                                  Container(
                                    width: double.infinity,
                                    padding: const EdgeInsets.only(
                                      top: 8,
                                    ),
                                    child: RichText(
                                      text: TextSpan(
                                        children: [
                                          TextSpan(
                                            text: widget.snap['username'],
                                            style: const TextStyle(
                                                color: Colors.black,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          const TextSpan(text: '  '),
                                          TextSpan(
                                            text: widget.snap['description'],
                                            style: const TextStyle(
                                                color: Colors.black,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  Center(
                                    child: InkWell(
                                      onTap: () {},
                                      child: Container(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 4),
                                        child: Text(
                                          'Mostrar os $commentLen comentários',
                                          style: const TextStyle(
                                            fontSize: 16,
                                            color: Colors.black54,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Container(
                                    padding:
                                        const EdgeInsets.symmetric(vertical: 4),
                                    child: Text(
                                      DateFormat('dd/MM/yyyy hh:mm').format(
                                        widget.snap['datePublished'].toDate(),
                                      ),
                                      style: const TextStyle(
                                        fontSize: 12,
                                        color: Colors.black,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          );
  }
}
