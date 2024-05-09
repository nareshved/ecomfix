
import 'dart:convert';
import 'dart:developer';
import 'package:ecomfix/models/products/top-rated-product.dart';
import 'package:http/http.dart' as http;


class ApiProductHelper {

  Future getRequest({required String apiUrl}) async {

    final requestUri = Uri.parse(apiUrl);
    final response = await http.get(requestUri);

    try{

      if(response.statusCode == 200) {
        final body = jsonDecode(response.body);
        final saveBody = Model_123.fromJson(body);
        log("body saved on model");
        return saveBody;
      }

      else  {
        log("returning null from response body");
        return log(response.statusCode.toString());
      }
      //emit

    } catch(e){
      return log(e.toString());
    }


  }



}








//
//
// import 'dart:convert';
// import 'dart:developer';
// import 'package:ecomfix/models/products/top-rated-product.dart';
// import 'package:http/http.dart' as http;
//
//
// class ApiProductHelper {
//
//   Future getRequest({required String apiUrl}) async {
//
//     final requestUri = Uri.parse(apiUrl);
//     final response = await http.get(requestUri);
//
//     try{
//
//       if(response.statusCode == 200) {
//         final body = jsonDecode(response.body);
//         final saveBody = Model_123.fromJson(body);
//         log("body saved on model");
//         return saveBody;
//       }
//
//       else  {
//         log("returning null from response body");
//         return log(response.statusCode.toString());
//       }
//       //emit
//
//     } catch(e){
//       return log(e.toString());
//     }
//
//
//
//
//   }
//
//
//
//
//
//
//
//
// }
//
//
//
//
//
//
//
// //
// //
// //
// // import 'dart:convert';
// // import 'dart:developer';
// // import 'package:ecomfix/models/products/top-rated-product.dart';
// // import 'package:http/http.dart' as http;
// //
// //
// // class ApiProductHelper {
// //
// //   Future getRequest({required String apiUrl}) async {
// //
// //     final requestUri = Uri.parse(apiUrl);
// //     final response = await http.get(requestUri);
// //
// //     try{
// //
// //       if(response.statusCode == 200) {
// //         final body = jsonDecode(response.body);
// //         final saveBody = Model_123.fromJson(body);
// //         log("body saved on model");
// //         return saveBody;
// //       }
// //
// //       else  {
// //           log("returning null from response body");
// //           return log(response.statusCode.toString());
// //       }
// //       //emit
// //
// //     } catch(e){
// //       return log(e.toString());
// //     }
// //
// //
// //
// //
// //   }
// //
// //
// //
// //
// //
// //
// //
// //
// // }
