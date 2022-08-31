import 'dart:typed_data';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:social_media/models/user.dart';
import 'package:social_media/provider/user_provider.dart';
import 'package:social_media/utils/utils.dart';

class AddPostScreen extends StatefulWidget {
  const AddPostScreen({Key? key}) : super(key: key);

  @override
  State<AddPostScreen> createState() => _AddPostScreenState();
}

class _AddPostScreenState extends State<AddPostScreen> {
  Uint8List? _fileOut;

  _selectImage(BuildContext context) async {
    return showDialog(
        context: context,
        builder: (context) {
          return SimpleDialog(
            title: const Text('Inserir informações'),
            children: [
              SimpleDialogOption(
                padding: const EdgeInsets.all(20),
                child: const Text('Tirar foto'),
                onPressed: () async {
                  Navigator.of(context).pop();
                  Uint8List file = await pickeImage(ImageSource.camera);
                  setState(
                    () {
                      _fileOut = file;
                    },
                  );
                },
              ),
              SimpleDialogOption(
                padding: const EdgeInsets.all(20),
                child: const Text('Selecionar imagem da Galeria'),
                onPressed: () async {
                  Navigator.of(context).pop();
                  Uint8List file = await pickeImage(ImageSource.gallery);
                  setState(
                    () {
                      _fileOut = file;
                    },
                  );
                },
              ),
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    final Usuario user = Provider.of<UserProvider>(context).getUser;

    return _fileOut == null || user == null
        ? Center(
            child: IconButton(
              icon: Icon(Icons.abc),
              onPressed: () => _selectImage(context),
            ),
          )
        : Scaffold(
            appBar: AppBar(
              automaticallyImplyLeading: false,
              backgroundColor: Colors.white,
              title: const Text(
                'Adicionar uma foto',
                style: TextStyle(
                  color: kIsWeb ? Colors.cyan : Colors.deepPurpleAccent,
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () {},
                  child: const Text(
                    'Postar',
                    style: TextStyle(
                      color: kIsWeb ? Colors.cyan : Colors.deepPurpleAccent,
                    ),
                  ),
                ),
              ],
            ),
            body: kIsWeb
                ? Container(
                    color: Colors.cyan,
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CircleAvatar(
                              backgroundImage: NetworkImage(user.photoUrl!),
                            ),
                            SizedBox(
                              width: MediaQuery.of(context).size.width * 0.3,
                              child: const TextField(
                                decoration: InputDecoration(
                                  hintText: 'Coloque uma descrição',
                                  border: InputBorder.none,
                                ),
                                maxLines: 8,
                              ),
                            ),
                            _fileOut == null
                                ? Container(
                                    width: 45,
                                    height: 45,
                                    color: Colors.black,
                                  )
                                : SizedBox(
                                    width: 45,
                                    height: 45,
                                    child: AspectRatio(
                                      aspectRatio: 487 / 451,
                                      child: Container(
                                        decoration: BoxDecoration(
                                          image: DecorationImage(
                                            image: MemoryImage(_fileOut!),
                                            fit: BoxFit.fill,
                                            alignment:
                                                FractionalOffset.topCenter,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                            const Divider(),
                          ],
                        ),
                        Text(user.username!),
                      ],
                    ),
                  )
                : Container(
                    color: Colors.deepPurpleAccent,
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            user == null
                                ? const CircleAvatar(
                                    backgroundImage: NetworkImage(''),
                                  )
                                : CircleAvatar(
                                    backgroundImage:
                                        NetworkImage(user.photoUrl!),
                                  ),
                            SizedBox(
                              width: MediaQuery.of(context).size.width * 0.45,
                              child: const TextField(
                                decoration: InputDecoration(
                                  hintText: 'Coloque uma descrição',
                                  border: InputBorder.none,
                                ),
                                maxLines: 8,
                              ),
                            ),
                            _fileOut == null
                                ? Container(
                                    width: 45,
                                    height: 45,
                                    color: Colors.black,
                                  )
                                : SizedBox(
                                    width: 45,
                                    height: 45,
                                    child: AspectRatio(
                                      aspectRatio: 487 / 451,
                                      child: Container(
                                        decoration: BoxDecoration(
                                          image: DecorationImage(
                                            image: MemoryImage(_fileOut!),
                                            fit: BoxFit.fill,
                                            alignment:
                                                FractionalOffset.topCenter,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                            const Divider(),
                          ],
                        )
                      ],
                    ),
                  ),
          );
  }
}
