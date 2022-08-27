import 'dart:typed_data';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:social_media/backend/auth_methods.dart';
import 'package:social_media/components/text_field_input.dart';
import 'package:social_media/utils/utils.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController bioController = TextEditingController();
  final TextEditingController usernameController = TextEditingController();
  Uint8List? _image;
  bool _isLoading = false;

  @override
  void dispose() {
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
    bioController.dispose();
    usernameController.dispose();
  }

  void selectImage() async {
    Uint8List im = await pickeImage(ImageSource.gallery);
    setState(() {
      _image = im;
    });
  }

  void signUpUser() async {
    setState(() {
      _isLoading = true;
    });

    String res = await AuthMethods().signUpUser(
      email: emailController.text,
      password: passwordController.text,
      username: usernameController.text,
      bio: bioController.text,
      file: _image!,
    );
    setState(() {
      _isLoading = false;
    });

    if (res != 'sucesso') {
      showSnackBar(res, context);
    }
  }

  @override
  Widget build(BuildContext context) {
    final webImage = Image.asset(
      '../assets/img/yp.png',
      width: MediaQuery.of(context).size.width * 0.3,
      height: MediaQuery.of(context).size.height * 0.2,
    );
    final mobileImage = Image.asset(
      'assets/img/yp.png',
      width: MediaQuery.of(context).size.width * 0.2,
      height: MediaQuery.of(context).size.height * 0.15,
    );
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.symmetric(
            horizontal: 32,
          ),
          width: double.infinity,
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.only(
                  top: MediaQuery.of(context).size.height * 0.1),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Stack(
                    children: [
                      _image != null
                          ? CircleAvatar(
                              radius: 64,
                              backgroundImage: MemoryImage(_image!),
                            )
                          : const CircleAvatar(
                              radius: 64,
                              backgroundColor: Colors.white,
                            ),
                      Positioned(
                        bottom: -10,
                        left: 80,
                        child: IconButton(
                          onPressed: selectImage,
                          icon: Icon(
                            Icons.add_a_photo_sharp,
                            color: Theme.of(context).colorScheme.secondary,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.1,
                  ),
                  kIsWeb
                      ? SizedBox(
                          width: MediaQuery.of(context).size.width * 0.25,
                          child: TextFieldInput(
                            controller: usernameController,
                            hintText: 'Nome de usuário',
                            textInputType: TextInputType.text,
                          ),
                        )
                      : TextFieldInput(
                          controller: usernameController,
                          hintText: 'Nome de usuário',
                          textInputType: TextInputType.text,
                        ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.025,
                  ),
                  kIsWeb
                      ? SizedBox(
                          width: MediaQuery.of(context).size.width * 0.25,
                          child: TextFieldInput(
                            controller: emailController,
                            hintText: 'E-mail',
                            textInputType: TextInputType.emailAddress,
                          ),
                        )
                      : TextFieldInput(
                          controller: emailController,
                          hintText: 'E-mail',
                          textInputType: TextInputType.emailAddress,
                        ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.025,
                  ),
                  kIsWeb
                      ? SizedBox(
                          width: MediaQuery.of(context).size.width * 0.25,
                          child: TextFieldInput(
                            controller: passwordController,
                            hintText: 'Senha',
                            isPass: true,
                            textInputType: TextInputType.emailAddress,
                          ),
                        )
                      : TextFieldInput(
                          controller: passwordController,
                          hintText: 'Senha',
                          isPass: true,
                          textInputType: TextInputType.emailAddress,
                        ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.025,
                  ),
                  kIsWeb
                      ? SizedBox(
                          width: MediaQuery.of(context).size.width * 0.25,
                          child: TextFieldInput(
                            controller: bioController,
                            hintText: 'Bio',
                            textInputType: TextInputType.text,
                          ),
                        )
                      : TextFieldInput(
                          controller: bioController,
                          hintText: 'Bio',
                          textInputType: TextInputType.text,
                        ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.025,
                  ),
                  kIsWeb
                      ? _isLoading
                          ? Center(child: CircularProgressIndicator())
                          : ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                primary: Colors.green,
                                fixedSize: Size(
                                  MediaQuery.of(context).size.width * 0.25,
                                  MediaQuery.of(context).size.height * 0.05,
                                ),
                              ),
                              onPressed: signUpUser,
                              child: Text('Cadastrar'),
                            )
                      : _isLoading
                          ? Center(child: CircularProgressIndicator())
                          : ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                fixedSize: Size(
                                  MediaQuery.of(context).size.width * 0.85,
                                  MediaQuery.of(context).size.height * 0.05,
                                ),
                                primary: Colors.pink,
                              ),
                              onPressed: signUpUser,
                              child: Text('Cadastrar'),
                            ),
                  TextButton(
                    onPressed: () {},
                    child: const Text('Já está cadastrado? '),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
