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

class PostCard extends StatefulWidget {
  final snap;
  const PostCard({Key? key, required this.snap}) : super(key: key);

  @override
  State<PostCard> createState() => _PostCardState();
}

class _PostCardState extends State<PostCard> {
  bool isLikeAnimating = false;

  @override
  Widget build(BuildContext context) {
    final Usuario user = Provider.of<UserProvider>(context).getUser;
    return kIsWeb
        ? SingleChildScrollView(
            child: Container(
              color: Theme.of(context).colorScheme.primary,
              padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 16)
                  .copyWith(right: 0),
              //Cabeçalho
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 16,
                    backgroundImage: NetworkImage(
                      widget.snap['profImage'],
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 8),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8),
                            child: Text(
                              widget.snap['username'],
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black),
                            ),
                          ),
                          //Imagem da postagem WEB
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
                                      MediaQuery.of(context).size.height * 0.7,
                                  width: double.infinity,
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
                                    duration: const Duration(milliseconds: 400),
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

                          //Seção de likes e comentarios WEB

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
                                  icon: widget.snap['likes'].contains(user.uid)
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

                          //Descrição e numeros de comentarios WEB

                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 16),
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
                                      child: const Text(
                                        'Ver todos os comentários',
                                        style: TextStyle(
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
                          )
                        ],
                      ),
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      showDialog(
                          context: context,
                          builder: (context) => Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 180),
                                child: Dialog(
                                  child: ListView(
                                    padding: const EdgeInsets.symmetric(
                                      vertical: 16,
                                    ),
                                    shrinkWrap: true,
                                    children: ['Deletar']
                                        .map(
                                          (e) => InkWell(
                                            onTap: () {},
                                            child: Container(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 12,
                                                      horizontal: 16),
                                              child: Text(e),
                                            ),
                                          ),
                                        )
                                        .toList(),
                                  ),
                                ),
                              ));
                    },
                    icon: const Icon(Icons.more_vert, color: Colors.black),
                  ),
                ],
              ),
            ),
          )
        : Container(
            color: Theme.of(context).colorScheme.primary,
            padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 16)
                .copyWith(right: 0),

            //Cabeçalho MOBILE

            child: Row(
              children: [
                CircleAvatar(
                  radius: 16,
                  backgroundImage: NetworkImage(widget.snap['profImage']),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 8),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8),
                          child: Text(
                            widget.snap['username'],
                            style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.black),
                          ),
                        ),

                        // Imagem da Postagem MOBILE

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
                                    MediaQuery.of(context).size.height * 0.35,
                                width: double.infinity,
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
                                  duration: const Duration(milliseconds: 400),
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

                        //Seção de likes e comentarios MOBILE

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
                                icon: widget.snap['likes'].contains(user.uid)
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

                        //Descrição e numeros de comentarios MOBILE

                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
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
                                    padding:
                                        const EdgeInsets.symmetric(vertical: 4),
                                    child: const Text(
                                      'Ver todos os comentários',
                                      style: TextStyle(
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
                IconButton(
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (context) => Dialog(
                        child: ListView(
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          shrinkWrap: true,
                          children: ['Deletar']
                              .map(
                                (e) => InkWell(
                                  onTap: () {},
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 12, horizontal: 16),
                                    child: Text(e),
                                  ),
                                ),
                              )
                              .toList(),
                        ),
                      ),
                    );
                  },
                  icon: const Icon(Icons.more_vert, color: Colors.black),
                ),
              ],
            ),
          );
  }
}
