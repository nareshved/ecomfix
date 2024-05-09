import 'dart:developer';
import 'package:ecomfix/auth/login.dart';
import 'package:ecomfix/bloc/register_event.dart';
import 'package:ecomfix/example/demo_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../models/user_model/my_user_model.dart';
import '../widgets/textform_field.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  ///controllers
  TextEditingController fnameController = TextEditingController();
  TextEditingController lnameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passController = TextEditingController();
  TextEditingController phoneController = TextEditingController();

  static final mSignUpKey = GlobalKey<FormState>();

  /// key for global form validation

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: mSignUpKey,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "Create an account!",
                  style: TextStyle(fontSize: 22, color: Colors.orange),
                ),
                const SizedBox(
                  height: 35.0,
                ),
                userTextField(
                  preIcon: const Icon(Icons.person),
                  hintTxt: "first name",
                  myController: fnameController,
                  myValidator: (value) {
                    if (value!.isEmpty) {
                      return "first name is Required don't`be Empty";
                    }
                  },
                ),
                const SizedBox(
                  height: 19.0,
                ),
                userTextField(
                  preIcon: const Icon(Icons.person),
                  hintTxt: "last name",
                  myController: lnameController,
                  myValidator: (value) {
                    if (value!.isEmpty) {
                      return "last name is Required don't`be Empty";
                    }
                  },
                ),
                const SizedBox(
                  height: 19.0,
                ),
                userTextField(
                  preIcon: const Icon(Icons.email_outlined),
                  hintTxt: "email address",
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
                  preIcon: const Icon(Icons.mobile_friendly_rounded),
                  hintTxt: "mobile number",
                  myController: phoneController,
                  myValidator: (value) {
                    if (value!.isEmpty) {
                      return "Phone number don't`be Empty";
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
                    } else if (value.length <= 6) {
                      return "at least password 6 length";
                    }
                  },
                ),
                const SizedBox(
                  height: 40.0,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "SignUp",
                      style: TextStyle(fontSize: 17, color: Colors.deepOrange),
                    ),
                    IconButton(
                      onPressed: () async {
                        /// user created

                        var ekUser = UserModel(
                          firstName: fnameController.text.trim(),
                          lastName: lnameController.text.trim(),
                          userEmail: emailController.text.toString(),
                          userPass: passController.text.toString(),
                          userPhone: phoneController.text.toString(),
                        );

                        context.read<UserBloc>().add(
                            CreateUserEvent(newUser: ekUser, context: context));

                        log('user created');

                    //    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LoginPage(),));
                      },
                      icon: const Icon(Icons.play_circle_rounded),
                      iconSize: 55,
                      color: Colors.deepOrange,
                    )
                  ],
                ),
                const SizedBox(
                  height: 30.0,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    InkWell(
                        child: const Text("Sign In",
                            style: TextStyle(
                                fontSize: 14, color: Colors.deepOrange)),
                        onTap: () {
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const LoginPage(),
                              ));
                        }),
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
