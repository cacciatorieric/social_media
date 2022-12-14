import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:social_media/backend/auth_methods.dart';
import 'package:social_media/components/text_field_input.dart';
import 'package:social_media/pages/screens/home_screen.dart';
import 'package:social_media/pages/screens/signup_screen.dart';
import 'package:social_media/utils/routes.dart';
import 'package:social_media/utils/utils.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool isLoading = false;

  @override
  void dispose() {
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
  }

  void loginUser() async {
    setState(() {
      isLoading = true;
    });

    String res = await AuthMethods().loginUser(
        email: emailController.text, password: passwordController.text);
    if (res == 'sucesso') {
      setState(() {
        isLoading = false;
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (context) => const HomeScreen(),
          ),
        );
      });
    } else {
      setState(() {
        isLoading = false;
      });
      showSnackBar(res, context);
    }
  }

  @override
  Widget build(BuildContext context) {
    final webImage = Image.asset(
      '../assets/img/yp.png',
      width: MediaQuery.of(context).size.width * 0.5,
      height: MediaQuery.of(context).size.height * 0.4,
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
                  kIsWeb ? webImage : mobileImage,
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.1,
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
                      ? isLoading == true
                          ? const Center(
                              child: CircularProgressIndicator(),
                            )
                          : ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                primary: Colors.green,
                                fixedSize: Size(
                                  MediaQuery.of(context).size.width * 0.25,
                                  MediaQuery.of(context).size.height * 0.05,
                                ),
                              ),
                              onPressed: loginUser,
                              child: Text('Entrar'),
                            )
                      : isLoading == true
                          ? const Center(
                              child: CircularProgressIndicator(),
                            )
                          : ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                fixedSize: Size(
                                  MediaQuery.of(context).size.width * 0.85,
                                  MediaQuery.of(context).size.height * 0.05,
                                ),
                                primary: Colors.pink,
                              ),
                              onPressed: loginUser,
                              child: Text('Entrar'),
                            ),
                  TextButton(
                    onPressed: () => Navigator.of(context).pushReplacement(
                      MaterialPageRoute(
                        builder: (context) => const SignUpScreen(),
                      ),
                    ),
                    child: const Text(
                      'Ainda n??o tem uma conta?',
                    ),
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
