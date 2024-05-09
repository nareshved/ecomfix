import 'dart:async';
import 'dart:convert';
import 'dart:developer';


import 'package:ecomfix/auth/home.dart';
import 'package:ecomfix/bloc/register_state.dart';
import 'package:ecomfix/urls/firebase_urls/firebase_provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../bloc/register_event.dart';

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
      log("account created api encode response success");

      var bodyPrint = jsonDecode(response.body);
      log("Post Api Body : $bodyPrint");

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

        Navigator.pushReplacement(event.context, MaterialPageRoute(builder: (context) => const MyHomePage(),));
      }
    }

    on FirebaseException catch (e) {
      ScaffoldMessenger.of(event.context).showSnackBar(SnackBar(content: Text(e.toString())));
      log(e.toString());
    }

    catch (e) {
      emit(RegisterErrorState(errorMsg: e.toString()));
      ScaffoldMessenger.of(event.context).showSnackBar(SnackBar(content: Text(e.toString())));
    }
  }