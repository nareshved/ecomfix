import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/register_bloc.dart';
import '../models/user_model/my_user_model.dart';
import '../widgets/app_routes.dart';
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
                Text(
                  "Create an account!",
                  style: TextStyle(fontSize: 22, color: Colors.orange),
                ),
                SizedBox(
                  height: 35.0,
                ),
                userTextField(
                  preIcon: Icon(Icons.person),
                  hintTxt: "first name",
                  myController: fnameController,
                  myValidator: (value) {
                    if (value!.isEmpty) {
                      return "first name is Required don't`be Empty";
                    }
                  },
                ),
                SizedBox(
                  height: 19.0,
                ),
                userTextField(
                  preIcon: Icon(Icons.person),
                  hintTxt: "last name",
                  myController: lnameController,
                  myValidator: (value) {
                    if (value!.isEmpty) {
                      return "last name is Required don't`be Empty";
                    }
                  },
                ),
                SizedBox(
                  height: 19.0,
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
                SizedBox(
                  height: 19.0,
                ),
                userTextField(
                  obscureBool: true,
                  preIcon: Icon(Icons.remove_red_eye),
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
                SizedBox(
                  height: 40.0,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "SignUp",
                      style: TextStyle(fontSize: 17, color: Colors.deepOrange),
                    ),
                    IconButton(
                      onPressed: () async {
                        /// user created
                        if (mSignUpKey.currentState!.validate()) {
                          if (fnameController.text.isNotEmpty &&
                              lnameController.text.isNotEmpty &&
                              emailController.text.isNotEmpty &&
                              passController.text.isNotEmpty) {
                            var ekUser = UserModel(
                                firstName: fnameController.text.trim(),
                                lastName: lnameController.text.trim(),
                                userEmail: emailController.text.toString(),
                                userPass: passController.text.toString(),
                                userPhone: phoneController.text.toString(),

                            ); BlocProvider.of<RegisterBloc>(context)
                                .add(CreateUserEvent(newUser: ekUser));


                          }
                        }
                      },
                      icon: const Icon(Icons.play_circle_rounded),
                      iconSize: 55,
                      color: Colors.deepOrange,
                    )
                  ],
                ),
                SizedBox(
                  height: 30.0,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    InkWell(
                        child: Text("Sign In",
                            style: TextStyle(
                                fontSize: 14, color: Colors.deepOrange)),
                        onTap: () {
                          Navigator.pushReplacementNamed(
                              context, AppRoutes.loginPage);
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

/// before bloc builder
///
///
// Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 Text(
//                   "Create an account!",
//                   style: TextStyle(fontSize: 22, color: Colors.orange),
//                 ),
//                 SizedBox(
//                   height: 35.0,
//                 ),
//                 userTextField(
//                   preIcon: Icon(Icons.person),
//                   hintTxt: "first name",
//                   myController: fnameController,
//                   myValidator: (value) {
//                     if (value!.isEmpty) {
//                       return "first name is Required don't`be Empty";
//                     }
//                   },
//                 ),
//                 SizedBox(
//                   height: 19.0,
//                 ),
//                 userTextField(
//                   preIcon: Icon(Icons.person),
//                   hintTxt: "last name",
//                   myController: lnameController,
//                   myValidator: (value) {
//                     if (value!.isEmpty) {
//                       return "last name is Required don't`be Empty";
//                     }
//                   },
//                 ),
//                 SizedBox(
//                   height: 19.0,
//                 ),
//                 userTextField(
//                   preIcon: const Icon(Icons.email_outlined),
//                   hintTxt: "email",
//                   myController: emailController,
//                   myValidator: (value) {
//                     if (value!.isEmpty) {
//                       return "Email is Required don't`be Empty";
//                     }
//                   },
//                 ),
//                 SizedBox(
//                   height: 19.0,
//                 ),
//                 userTextField(
//                   obscureBool: true,
//                   preIcon: Icon(Icons.remove_red_eye),
//                   hintTxt: "password",
//                   myController: passController,
//                   myValidator: (value) {
//                     if (value!.isEmpty) {
//                       return "password is Required don't`be Empty";
//                     } else if (value.length <= 6) {
//                       return "at least password 6 length";
//                     }
//                   },
//                 ),
//                 SizedBox(
//                   height: 40.0,
//                 ),
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     Text(
//                       "SignUp",
//                       style: TextStyle(fontSize: 17, color: Colors.deepOrange),
//                     ),
//                     IconButton(
//                       onPressed: () async {
//                         /// user created
//                         if (mSignUpKey.currentState!.validate()) {
//                           if (fnameController.text.isNotEmpty &&
//                               lnameController.text.isNotEmpty &&
//                               emailController.text.isNotEmpty &&
//                               passController.text.isNotEmpty) {
//
//                             /*FirebaseProvider.createUser(
//                                 email: emailController.text.trim(),
//                                 pass: passController.text.trim(),
//                                 fname: fnameController.text.trim(),
//                                 lname: lnameController.text.trim(),
//                                 context: context, );*/
//
//                             var ekUser = UserModel(
//                                 firstName: fnameController.text.trim(),
//                                 lastName: lnameController.text.trim(),
//                                 userEmail: emailController.text.toString(),
//                                 userPass: passController.text.toString());
//
//                             BlocProvider.of<RegisterBloc>(context).add(
//                                 CreateUserEvent(newUser: ekUser,));
//                           }
//                         }
//                       },
//                       icon: const Icon(Icons.play_circle_rounded),
//                       iconSize: 55,
//                       color: Colors.deepOrange,
//                     )
//                   ],
//                 ),
//                 SizedBox(
//                   height: 30.0,
//                 ),
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     InkWell(
//                         child: Text("Sign In",
//                             style: TextStyle(
//                                 fontSize: 14, color: Colors.deepOrange)),
//                         onTap: () {
//                           Navigator.pushReplacementNamed(
//                               context, AppRoutes.loginPage);
//                         }),
//                   ],
//                 ),
//               ],
//             ),
