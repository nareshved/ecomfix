/*

import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:html';
import 'dart:js';

import 'package:ecomfix/auth/home.dart';
import 'package:ecomfix/bloc/register_state.dart';
import 'package:ecomfix/urls/firebase_urls/firebase_provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../bloc/register_event.dart';
import '../widgets/app_routes.dart';
import '../widgets/prefs_user_logged_in/user_login_prefs.dart';

/// created by sir
//
// class UserBloc extends Bloc<RegisterEvent, RegisterState> {
//
//    BuildContext context;
//   static final firebaseAuthMy = FirebaseAuth.instance;
//   static final firestore = FirebaseFirestore.instance;
//
//   static const String USER_COLLECTION = "users";
//   static const String USER_AUTH_DATA_COLLECTION = "passwords";
//
//   final requestUri =
//       Uri.parse("https://www.infusevalue.live/api/v1/auth/register");
//
//    final loginUri =
//    Uri.parse("https://www.infusevalue.live/api/v1/auth/login");
//
//   UserBloc(this.context) : super(RegisterInitialState()) {
//     /// constructor
//     //
//     // on<CreateUserEvent>((event, emit) async {
//     //   emit(RegisterLoadingState());
//     //
//     //   try {
//     //     final response = await http.post(
//     //       headers: {"content type": "text/ Ecommerce app"},
//     //       requestUri,
//     //       body: {
//     //         "f_name": event.newUser.firstName,
//     //         "l_name": event.newUser.lastName,
//     //         "email": event.newUser.userEmail,
//     //         "password": event.newUser.userPass,
//     //         "phone": event.newUser.userPhone
//     //       },
//     //     );
//     //
//     //     if (response.statusCode == 200) {
//     //       log("account created api encode response success");
//     //
//     //       final encodeResponse = jsonEncode(response.body);
//     //       log("Successfully send Response data $encodeResponse");
//     //
//     //       var bodyPrint = jsonDecode(response.body);
//     //       log("Post Api Body print for me : $bodyPrint");
//     //
//     //
//     //
//     //       // try to creating account in firebase
//     //
//     //       UserCredential credential =
//     //       await firebaseAuthMy.createUserWithEmailAndPassword(
//     //           email: event.newUser.userEmail, password: event.newUser.userPass);
//     //
//     //       if (credential.user != null) {
//     //         /// create collection
//     //         firestore
//     //             .collection(USER_COLLECTION)
//     //             .doc(credential.user!.uid)
//     //             .set(event.newUser.toDoc())
//     //             .then((value) => value);
//     //
//     //         /// ask value
//     //
//     //         firestore
//     //             .collection(USER_AUTH_DATA_COLLECTION)
//     //             .doc(event.newUser.firstName)
//     //             .set({"email": event.newUser.userEmail, "password": event.newUser.userPass});
//     //
//     //         Navigator.pushReplacementNamed(context, AppRoutes.loginPage);
//     //         ScaffoldMessenger.of(context)
//     //             .showSnackBar(const SnackBar(content: Text("account created")));
//     //       }
//     //
//     //       /// end firebase
//     //
//     //
//     //
//     //       emit(RegisterLoadedState(userModel: UserModel.fromDoc(bodyPrint)));
//     //     } else {
//     //       log("post api not work testing");
//     //       /*print("post api not work testing");*/
//     //     }
//     //   } catch (e) {
//     //     log("Firebase Not working");
//     //     emit(RegisterErrorState(errorMsg: e.toString()));
//     //   }
//     // });
//     //
//
//
//
//
//
//
//
//
//
//     /// login event
//     on<LoginUserEvent>((event, emit) async {
//       emit(RegisterLoadingState());
//       try {
//
//         final loginApiUri = Uri.parse("https://www.infusevalue.live/api/v1/auth/login");
//
//         var response = await http.post(
//             loginApiUri,
//           body: {
//             "email": event.mUser.userEmail,
//             "password": event.mUser.userPass,
//           }
//         );
//
//         if (response.statusCode == 200){
//           var mData = jsonDecode(response.body);
//
//           final prefs = await SharedPreferences.getInstance();       /// API Prefs
//           prefs.setString (PrefsUser.LOGIN_TOKEN_PREFS_KEY, mData["token"] ?? "");
//
//           log("your token printed : ${mData["token"]}");
//
//         }
//
//
//         UserCredential credential = await firebaseAuthMy
//             .signInWithEmailAndPassword(email: event.mUser.userEmail, password: event.mUser.userPass);
//
//         if(credential.user!=null) {
//           /// store a prefs uid firebase
//
//           var prefs = await SharedPreferences.getInstance();
//           prefs.setString(PrefsUser.LOGIN_PREFS_KEY, credential.user!.uid);          /// Firebase Prefs
//
//           Navigator.pushReplacementNamed(context, AppRoutes.homePage);
//         }
//       }
//
//       on FirebaseException catch (e) {
//         ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(e.toString())));
//       }
//
//       catch (e) {
//         emit(RegisterErrorState(errorMsg: e.toString()));
//       }
//     });
//   }
// }
//
// class UserBloc extends Bloc<RegisterEvent, RegisterState> {
//   UserBloc() : super(RegisterInitialState()) {
//     on<CreateUserEvent>(createUser as EventHandler<CreateUserEvent, RegisterState>);
//   }
//
//   FutureOr<void> createUser(
//       CreateUserEvent event, Emitter<RegisterState> emit,  BuildContext context) async {
//
//     emit(RegisterLoadingState());
//     final requestUri = Uri.parse("https://www.infusevalue.live/api/v1/auth/register");
//
//     try{
//
//       final response = await http.post(
//         headers: {"content type" : "text/ Ecommerce app"},
//         requestUri,
//         body: {
//           "f_name": event.newUser.firstName,
//           "l_name": event.newUser.lastName,
//           "email": event.newUser.userEmail,
//           "password": event.newUser.userPass,
//           "phone": event.newUser.userPhone
//         },
//       );
//
//       if (response.statusCode == 200) {
//         log("account created api encode response success");
//
//         final encodeResponse = jsonEncode(response.body);
//         log("Successfully send Response data $encodeResponse");
//
//         var bodyPrint = jsonDecode(response.body);
//         log("Post Api Body : $bodyPrint");
//
//         //////
//         emit(RegisterLoadedState(userModel: UserModel.fromDoc(bodyPrint)));
//         FirebaseProvider().createUser(cUser: event.newUser, context: context);
// Navigator.push(context, MaterialPageRoute(builder: (context) => LoginPage(),));
//       } else {
//         log("post api not work testing");
// /*print("post api not work testing");*/
//
//       }
//
//     }catch(e){
//       emit(RegisterErrorState(errorMsg: e.toString()));
//     }
//   }
// }


/*

import 'dart:convert';
import 'dart:developer';
import 'dart:js';
import 'package:ecomfix/bloc/register_state.dart';
import 'package:ecomfix/urls/firebase_urls/firebase_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import '../bloc/register_event.dart';
import '../models/user_model/my_user_model.dart';

/// created by sir

class UserBloc extends Bloc<RegisterEvent, RegisterState> {

  final FirebaseProvider firebaseProvider;
   BuildContext context;
  final requestUri = Uri.parse("https://www.infusevalue.live/api/v1/auth/register");

  UserBloc({required this.firebaseProvider, required this.context} ) : super(RegisterInitialState()) {

    on<CreateUserEvent>((event, emit) async {

      emit(RegisterLoadingState());

      try{
        final response = await http.post(
          headers: {"content type" : "text/ Ecommerce app"},
          requestUri,
          body: {
            "f_name": event.newUser.firstName,
            "l_name": event.newUser.lastName,
            "email": event.newUser.userEmail,
            "password": event.newUser.userPass,
            "phone": event.newUser.userPhone
          },
        );

        firebaseProvider.createUser(cUser: event.newUser, context: context);      // try to creating account in firebase

        if (response.statusCode == 200) {
          log("account created api encode response success");

          final encodeResponse = jsonEncode(response.body);
          log("Successfully send Response data $encodeResponse");

          var bodyPrint = jsonDecode(response.body);
          log("Post Api Body print for me : $bodyPrint");


          emit(RegisterLoadedState(userModel: UserModel.fromDoc(bodyPrint)));
        } else {
          log("post api not work testing");
          */
/*print("post api not work testing");*/ /*

        }

      }catch(e){
        emit(RegisterErrorState(errorMsg: e.toString()));
      }
    }
    );

    on<LoginUserEvent>((event, emit) async {
      emit(RegisterLoadingState());
      try{
        firebaseProvider.authenticateUser(mEmail: event.eEmail, mPass: event.ePass, context: context);
      }catch(e){
        emit(RegisterErrorState(errorMsg: e.toString()));
      }
    }
    );

  }
}



*/

/*
/// my try

// Define bloc
class UserBloc extends Bloc<RegisterEvent, RegisterState> {

   final firebaseProvider;

  UserBloc({required this.firebaseProvider}) : super(RegisterInitialState()) {
    on<CreateUserEvent>(createUser as EventHandler<CreateUserEvent, RegisterState>);
  }

  FutureOr<void> createUser(
      CreateUserEvent event, Emitter<RegisterState> emit,  FirebaseProvider firebaseProvider,  BuildContext context) async {

    emit(RegisterLoadingState());
    final requestUri = Uri.parse("https://www.infusevalue.live/api/v1/auth/register");

    try{
      firebaseProvider.createUser(cUser: event.newUser, context: context);

      final response = await http.post(
        headers: {"content type" : "text/ Ecommerce app"},
        requestUri,
        body: {
          "f_name": event.newUser.firstName,
          "l_name": event.newUser.lastName,
          "email": event.newUser.userEmail,
          "password": event.newUser.userPass,
          "phone": event.newUser.userPhone
        },
      );

      if (response.statusCode == 200) {
        log("account created api encode response success");

        final encodeResponse = jsonEncode(response.body);
        log("Successfully send Response data $encodeResponse");

        var bodyPrint = jsonDecode(response.body);
        log("Post Api Body : $bodyPrint");

        //////
        emit(RegisterLoadedState(userModel: UserModel.fromDoc(bodyPrint)));
      } else {
        log("post api not work testing");
        */
/*print("post api not work testing");*/ /*

      }

    }catch(e){
      emit(RegisterErrorState(errorMsg: e.toString()));
    }
  }
}

*/

/*
import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:ecomfix/bloc/register_state.dart';
import 'package:ecomfix/models/user_model/my_user_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import '../bloc/register_event.dart';
/// function ki help se bloc
/// created by sir



// Define bloc






 */

class UserBloc extends Bloc<RegisterEvent, RegisterState> {
  UserBloc() : super(RegisterInitialState()) {
    on<CreateUserEvent>(createUser);


    on<LoginUserEvent>(loginUser);
  }
}


  FutureOr<void> createUser(
      CreateUserEvent event, Emitter<RegisterState> emit) async {
    emit(RegisterLoadingState());
    final requestUri = Uri.parse("https://www.infusevalue.live/api/v1/auth/register");

    final response = await http.post(
      requestUri,
      body: {
        "f_name": event.newUser.firstName,
        "l_name": event.newUser.lastName,
        "email": event.newUser.userEmail,
        "password": event.newUser.userPass,
        "phone": event.newUser.userPhone
      },
    );

    final encodeResponse = jsonEncode(response.body);
    log(encodeResponse);

    if (response.statusCode == 200) {
      print("account created api encode response success");

      var bodyPrint = jsonDecode(response.body);
      print("Post Api Body : $bodyPrint");

      //////

      // emit(RegisterLoadedState(userModel: UserModel.fromDoc(bodyPrint)));

      FirebaseProvider().createUser(cUser: event.newUser, context: event.context);
    } else {
      log("post api not work testing");

/*print("post api not work testing");*/

    }
  }

  FutureOr<void> loginUser(LoginUserEvent event,Emitter<RegisterState> emit) async {
    emit(RegisterLoadingState());
    try {

      final loginApiUri = Uri.parse("https://www.infusevalue.live/api/v1/auth/login");

      var response = await http.post(
          loginApiUri,
          body: {
            "email": event.userEmail,
            "password": event.userPassword,
          }
      );

      if (response.statusCode == 200){
        var mData = jsonDecode(response.body);

        final prefs = await SharedPreferences.getInstance();       /// API Prefs
        prefs.setString (PrefsUser.LOGIN_TOKEN_PREFS_KEY, mData["token"] ?? "");

        log("your token Saved to prefs : ${mData["token"]}");

      }


      UserCredential credential = await FirebaseProvider.firebaseAuthMy
          .signInWithEmailAndPassword(email: event.userEmail, password: event.userPassword);

      if(credential.user!=null) {
        /// store a prefs uid firebase

        var prefs = await SharedPreferences.getInstance();
        prefs.setString(PrefsUser.LOGIN_PREFS_KEY, credential.user!.uid);          /// Firebase Prefs

        Navigator.pushReplacement(event.context, MaterialPageRoute(builder: (context) => MyHomePage(),));
      }
    }

    on FirebaseException catch (e) {
      ScaffoldMessenger.of(event.context).showSnackBar(SnackBar(content: Text(e.toString())));
    }

    catch (e) {
      emit(RegisterErrorState(errorMsg: e.toString()));
    }
  }

*/



//// removed from page

/*
if (mSignUpKey.currentState!.validate()) {
if (fnameController.text.isNotEmpty &&
lnameController.text.isNotEmpty &&
emailController.text.isNotEmpty &&
phoneController.text.isNotEmpty &&
passController.text.isNotEmpty) {
log('yes!!!');


}
else{

log('you need to fill');
}
}
else{

log('you need to fill');
}

*/

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



/// before bloc builder
///
// Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               const Text("Welcome back!", style: TextStyle(fontSize: 22, color: Colors.orange),),
//               const SizedBox(height: 35.0,),
//               userTextField(
//                 preIcon: Icon(Icons.email_outlined),
//                 hintTxt: "email",
//                 myController: emailController, myValidator: (value) {
//                 if(value!.isEmpty){
//                   return "Email is Required don't`be Empty";
//                 }
//               },),
//               const SizedBox(height: 19.0,),
//               userTextField(
//                 obscureBool: true,
//                 preIcon: Icon(Icons.remove_red_eye),
//                 hintTxt: "password",
//                 myController: passController, myValidator: (value) {
//                 if(value!.isEmpty){
//                   return "password is Required don't`be Empty";
//                 }
//               },),
//               const SizedBox(height: 55.0,),
//                Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   const Text("Sign In", style: TextStyle(fontSize: 17, color: Colors.deepOrange),),
//                   IconButton(onPressed: () async {
//
//                     if(mSignInKey.currentState!.validate()){
//                       if(emailController.text.isNotEmpty && passController.text.isNotEmpty){
//
//                         BlocProvider.of<RegisterBloc>(context).add(
//                             LoginUserEvent(eEmail: emailController.text.toString(), ePass: passController.text.toString(),));
//                       }
//                     }
//
//                     ApiHelper.getMyApi();
//                   }, icon: const Icon(Icons.play_circle_rounded), iconSize: 55,color: Colors.deepOrange,)
//                 ],
//               ),
//               const SizedBox(height: 60.0,),
//                Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   InkWell(child: Text("Sign Up", style: TextStyle(fontSize: 14, color: Colors.deepOrange),),
//                     onTap: (){
//                     Navigator.pushReplacementNamed(context, AppRoutes.signupPage);
//
//                     },
//                   ),
//                   Text("Forgot Password", style: TextStyle(fontSize: 14, color: Colors.deepOrange),),
//                 ],
//               ),
//             ],
//             ),
