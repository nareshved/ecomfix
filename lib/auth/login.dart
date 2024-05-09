import 'package:ecomfix/auth/signup.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/register_event.dart';
import '../example/demo_bloc.dart';
import '../widgets/textform_field.dart';


class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  ///controllers
  TextEditingController emailController = TextEditingController();
  TextEditingController passController = TextEditingController();

  static final mSignInKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: mSignInKey,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "Welcome back!",
                  style: TextStyle(fontSize: 22, color: Colors.orange),
                ),
                const SizedBox(
                  height: 35.0,
                ),
                userTextField(
                  preIcon: const Icon(Icons.email_outlined),
                  hintTxt: "email",
                  myController: emailController,
                  myValidator: (value) {
                    if (value!.isEmpty) {
                      return "Email is Required don't`be Empty";
                    }
                  },
                ),
                const SizedBox(
                  height: 19.0,
                ),
                userTextField(
                  obscureBool: true,
                  preIcon: const Icon(Icons.remove_red_eye),
                  hintTxt: "password",
                  myController: passController,
                  myValidator: (value) {
                    if (value!.isEmpty) {
                      return "password is Required don't`be Empty";
                    }
                  },
                ),
                const SizedBox(
                  height: 55.0,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "Sign In",
                      style: TextStyle(fontSize: 17, color: Colors.deepOrange),
                    ),
                    IconButton(
                      onPressed: () async {
                        if (mSignInKey.currentState!.validate()) {
                          if (emailController.text.isNotEmpty &&
                              passController.text.isNotEmpty) {
                            BlocProvider.of<UserBloc>(context).add(
                                LoginUserEvent(
                                    userEmail: emailController.text,
                                    userPassword: passController.text,
                                    context: context));
                          }
                     //      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const MyHomePage(),));
                        }

                       // ApiHelper.getMyApi();
                      },
                      icon: const Icon(Icons.play_circle_rounded),
                      iconSize: 55,
                      color: Colors.deepOrange,
                    )
                  ],
                ),
                const SizedBox(
                  height: 60.0,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    InkWell(
                      child: const Text(
                        "Sign Up",
                        style:
                            TextStyle(fontSize: 14, color: Colors.deepOrange),
                      ),
                      onTap: () {
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const SignUpPage(),
                            ));
                      },
                    ),
                    const Text(
                      "Forgot Password",
                      style: TextStyle(fontSize: 14, color: Colors.deepOrange),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
