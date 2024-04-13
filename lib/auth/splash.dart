
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../widgets/prefs_user_logged_in/user_login_prefs.dart';
import 'home.dart';
import 'login.dart';

class SplashPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return SplashPageState();
  }
}

class SplashPageState extends State<SplashPage> {

  @override
  void initState() {
    super.initState();

    Timer(const Duration(seconds: 3), () async {

      var prefs = await SharedPreferences.getInstance();
      String? tokenKey = prefs.getString(PrefsUser.LOGIN_TOKEN_PREFS_KEY);
      String? loginKeys = prefs.getString(PrefsUser.LOGIN_PREFS_KEY);

      Widget navigateTo = const LoginPage(); /// ask app routes

      if(tokenKey != null && loginKeys != null ){
        navigateTo = const MyHomePage();
      }

      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => navigateTo,));

    },);

  }

  @override
  Widget build(BuildContext context) {
   return const Scaffold(
     backgroundColor: Colors.deepOrange,
     body: Column(
       mainAxisAlignment: MainAxisAlignment.center,
       children: [
         Center(child:
          Text("mahaLaxmi Shop", style: TextStyle(fontSize: 22, color: Colors.white),)),
       ],
     ),
   );
  }
}