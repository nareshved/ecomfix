
/// creating a class for api helper functions

import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as httpclient;
import 'package:shared_preferences/shared_preferences.dart';

import '../prefs_user_logged_in/user_login_prefs.dart';

class ApiHelper {

  static const String BASE_URL_API = "https://www.infusevalue.live/api/v1/";


  static Future<void> getMyApi ({String? apiUrl}) async {                                     /// user login

    final registerApiUri = Uri.parse("$BASE_URL_API$apiUrl");

    final response = await httpclient.get(registerApiUri);

    if (response.statusCode == 200){
      final mData = jsonDecode(response.body);

      final prefs = await SharedPreferences.getInstance();
      prefs.setString (PrefsUser.LOGIN_TOKEN_PREFS_KEY, mData["token"] ?? "");

      log("your token printed : ${mData["token"]}");

    }
  }

  static Future<void> sendRequest ({String? apiUrl,

    required String fName, required String lName,
    required String userEmail, required String userPass,
    required String phone,

   }) async {

    final requestUri = Uri.parse("$BASE_URL_API$apiUrl");

    final response = await httpclient.post(
        requestUri,
        body: {
          "f_name" : fName,
          "l_name" : lName,
          "email" : userEmail,
          "password" : userPass,
          "phone":phone
        },
    );
    
    final encodeResponse = jsonEncode(response);
    log(encodeResponse);

    if(response.statusCode == 200){
      print("account created api encode response success");

      var bodyPrint = jsonDecode(response.body);
      print ("Post Api Body : $bodyPrint");
    }
    else {
      log("post api not work testing");
      /*print("post api not work testing");*/
    }

  }







  /*static postApi() async{                                              /// user signup

    var registerApiUri = Uri.parse("https://www.infusevalue.live/api/v1/auth/register");

    var response = await httpclient.post(registerApiUri);

    if (response.statusCode == 200){
      var mData = jsonEncode(response.body);

    }
  }*/
}
