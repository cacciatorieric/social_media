import 'dart:typed_data';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:social_media/backend/firestore_methods.dart';
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
  final TextEditingController _descriptionController = TextEditingController();
  bool _isLoading = false;

  void postImage(
    String uid,
    String username,
    String profImage,
  ) async {
    try {
      setState(() {
        _isLoading = true;
      });
      String res = await FirestoreMethods().uploadPost(
        uid,
        _descriptionController.text,
        username,
        profImage,
        _fileOut!,
      );

      if (res == 'sucesso') {
        setState(() {
          _isLoading = false;
        });
        showSnackBar('Conteudo postado', context);
      } else {
        setState(() {
          _isLoading = false;
        });
        showSnackBar(res, context);
      }
    } catch (err) {
      setState(() {
        _isLoading = false;
      });
      showSnackBar(err.toString(), context);
    }
  }

  _selectImage(BuildContext context) async {
    return showDialog(
        context: context,
        builder: (context) {
          return SimpleDialog(
            title: const Text('Inserir informações'),
            children: [
              kIsWeb
                  ? const SizedBox()
                  : SimpleDialogOption(
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
              SimpleDialogOption(
                padding: const EdgeInsets.all(20),
                child: const Text('Cancelar'),
                onPressed: () async {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        });
  }

  @override
  void dispose() {
    super.dispose();
    _descriptionController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Usuario user = Provider.of<UserProvider>(context).getUser;

    return Scaffold(
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
            onPressed: () =>
                postImage(user.uid!, user.username!, user.photoUrl!),
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
                  _isLoading ? const LinearProgressIndicator() : Container(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CircleAvatar(
                        backgroundImage: NetworkImage(user.photoUrl!),
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.3,
                        child: TextField(
                          controller: _descriptionController,
                          decoration: const InputDecoration(
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
                                      alignment: FractionalOffset.topCenter,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                      const Divider(),
                    ],
                  ),
                  IconButton(
                    onPressed: () => _selectImage(context),
                    icon: const Icon(Icons.add_a_photo),
                  ),
                ],
              ),
            )
          : Container(
              color: Colors.deepPurpleAccent,
              child: Column(
                children: [
                  _isLoading ? const LinearProgressIndicator() : Container(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      user == null
                          ? const CircleAvatar(
                              backgroundImage: NetworkImage(''),
                            )
                          : CircleAvatar(
                              backgroundImage: NetworkImage(user.photoUrl!),
                            ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.45,
                        child: TextField(
                          controller: _descriptionController,
                          decoration: const InputDecoration(
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
                                      alignment: FractionalOffset.topCenter,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                      const Divider(),
                    ],
                  ),
                  IconButton(
                    onPressed: () => _selectImage(context),
                    icon: const Icon(Icons.add_a_photo),
                  ),
                ],
              ),
            ),
    );
  }
}
