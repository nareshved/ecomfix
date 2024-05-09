

/// is my bloc

import 'dart:convert';
import 'dart:developer';
import 'package:ecomfix/bloc/register_event.dart';
import 'package:ecomfix/bloc/register_state.dart';
import 'package:ecomfix/models/user_model/my_user_model.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_bloc/flutter_bloc.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  RegisterBloc() : super(RegisterInitialState());

  @override
  Stream<RegisterEvent> mapEventToState(RegisterEvent event) async* {
    if (event is CreateUserEvent) {
      yield* _mapCreateUserEventToState(event);
    }
  }

  Stream<RegisterEvent> _mapCreateUserEventToState(
      CreateUserEvent event) async* {
    try {
      emit( RegisterLoadingState());

      var apiUrl = "https://www.infusevalue.live/api/v1/auth/register";

      final requestUri = Uri.parse(apiUrl);

      final response = await http.post(
        requestUri,
        body: {
          "f_name": event.newUser.firstName,
          "l_name": event.newUser.lastName,
          "email": event.newUser.userEmail,
          "password": event.newUser.userPass,
          "phone": event.newUser.userPhone,
        },
      );

      log(response.body);

      if (response.statusCode == 200) {
        print("Account created successfully");

        var bodyPrint = jsonDecode(response.body);
        print("Post Api Body: $bodyPrint");

        emit( RegisterLoadedState(userModel: UserModel.fromDoc(bodyPrint)));
      } else {
        print('API request failed');
      }
    } catch (e) {
      emit( RegisterErrorState(errorMsg:' -----$e.toString()'));
    }
  }
}





















/*
import 'dart:developer';
import 'package:ecomfix/auth/home.dart';
import 'package:http/http.dart' as httpclient;
import 'dart:convert';
import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../models/user_model/my_user_model.dart';

import '../urls/firebase_urls/firebase_provider.dart';
import '../widgets/api_helper/api_finctions.dart';
part 'register_event.dart';
part 'register_state.dart';
const String BASE_URL_API = "https://www.infusevalue.live/api/v1/";


class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  //
  //  context;
  // FirebaseProvider firebaseProvider;BuildContext

  RegisterBloc() : super(RegisterInitialState()) {
    on<CreateUserEvent>((event, emit) async {
      try{
        emit(RegisterLoadingState());


        var apiUrl = "https://www.infusevalue.live/api/v1/auth/register";

          ///copy the linkk in zoom
          ///

          final requestUri = Uri.parse("$apiUrl");

          final response = await httpclient.post(
            requestUri,
            body: {
              "f_name": event.newUser.firstName,
              "l_name": event.newUser.lastName,
              "email": event.newUser.userEmail,
              "password": event.newUser.userPass,
              "phone": event.newUser.userPhone
            },
          );

          final encodeResponse = jsonEncode(response);
          log(encodeResponse);

          if (response.statusCode == 200) {
            print("account created api encode response success");

            var bodyPrint = jsonDecode(response.body);
            print(
                "Post Api Body -----------------------------------------------------------: $bodyPrint");

            log('Api Hit Success----------------');

            emit(RegisterLoadedState(userModel: UserModel.fromDoc(bodyPrint)));

            // Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => MyHomePage(),));
          }
          else {
            print('---------------------api Not hit');
          }
        }




        catch(e){
        emit(RegisterErrorState(errorMsg: e.toString()));
      }
    }
    );

    on<LoginUserEvent>((event, emit) async {
      emit(RegisterLoadingState());
      try{
        // firebaseProvider.authenticateUser(mEmail: event.eEmail, mPass: event.ePass, context: context);

        ApiHelper.getMyApi();  /// hit LOGIN API for get USER TOKEN


      }catch(e){
        emit(RegisterErrorState(errorMsg: e.toString()));
      }
    }
    );

  }
  }





*/





  /*import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../models/user_model/my_user_model.dart';
import '../urls/firebase_urls/firebase_provider.dart';
import '../widgets/api_helper/api_finctions.dart';
part 'register_event.dart';
part 'register_state.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {

   String? fName;
   String? lName;
   String? userEmail;
   String? userPass;
   String? phone;
  BuildContext context;
  FirebaseProvider firebaseProvider;

  RegisterBloc({required this.firebaseProvider, required this.context, this.fName, this.phone, this.userPass, this.userEmail, this.lName}) : super(RegisterInitialState()) {
    on<CreateUserEvent>((event, emit) async {
      emit(RegisterLoadingState());
      try{
        firebaseProvider.createUser(cUser: event.newUser, context: context);
        ApiHelper.sendRequest(fName: fName!, lName: lName!, userEmail: userEmail!, userPass: userPass!, phone: phone!);
        emit(RegisterLoadedState());
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