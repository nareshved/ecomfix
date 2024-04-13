
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../models/user_model/my_user_model.dart';
import '../../widgets/api_helper/api_finctions.dart';
import '../../widgets/app_routes.dart';
import '../../widgets/prefs_user_logged_in/user_login_prefs.dart';


class FirebaseProvider {

  static final firebaseAuthMy = FirebaseAuth.instance;
  static final firestore = FirebaseFirestore.instance;
  static const String BASE_URL_API = "https://www.infusevalue.live/api/v1/";


  static const String USER_COLLECTION = "users";
  static const String USER_AUTH_DATA_COLLECTION = "passwords";

  /// create user fun
  Future createUser ({ required UserModel cUser, required BuildContext context}) async {
   try {
     UserCredential credential = await firebaseAuthMy.createUserWithEmailAndPassword(email: cUser.userEmail, password: cUser.userPass);

     if(credential.user != null){
       /// create collection
     firestore.collection(USER_COLLECTION).doc(credential.user!.uid)
         .set(cUser.toDoc()).then((value) => value);  /// ask value

       firestore.collection(USER_AUTH_DATA_COLLECTION).doc(cUser.firstName)
     .set({
         "email" : cUser.userEmail,
         "password" : cUser.userPass
       });

     }

     Navigator.pushReplacementNamed(context, AppRoutes.loginPage);
     ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("account created")));
   }
   on FirebaseAuthException catch(errors){
     ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(errors.code)));
   }

  }



  Future authenticateUser({required mEmail, required String mPass, required BuildContext context}) async {
    try {
      UserCredential credential = await firebaseAuthMy
          .signInWithEmailAndPassword(email: mEmail!, password: mPass);

      if(credential.user!=null) {
        /// store a prefs uid firebase
        ApiHelper.getMyApi(apiUrl: "auth/login");

        var prefs = await SharedPreferences.getInstance();
        prefs.setString(PrefsUser.LOGIN_PREFS_KEY, credential.user!.uid);

        Navigator.pushReplacementNamed(context, AppRoutes.homePage);
      }

    } on FirebaseException catch ( e ){
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(e.toString())));
    }
  }

}



// Future createUser ({ required String mEmail, required String pass, required String fname, required String lname, required BuildContext context, required String email, required String eUser,}) async {