import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../models/user_model/my_user_model.dart';
import '../urls/firebase_urls/firebase_provider.dart';
import '../widgets/api_helper/api_finctions.dart';
part 'register_event.dart';
part 'register_state.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {

  BuildContext context;
  FirebaseProvider firebaseProvider;

  RegisterBloc({required this.firebaseProvider, required this.context,}) : super(RegisterInitialState()) {
    on<CreateUserEvent>((event, emit) async {
      emit(RegisterLoadingState());
      try{
        firebaseProvider.createUser(cUser: event.newUser, context: context);
        log('Api Hit Success');
        /// hit createUser API
        ApiHelper.sendRequest(
          apiUrl: 'auth/register',
          fName: event.newUser.firstName,
          lName: event.newUser.lastName,
          phone: event.newUser.userPhone,
          userEmail: event.newUser.userEmail,
          userPass: event.newUser.userPass,
        );
log('Api Hit Success');

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

        ApiHelper.getMyApi();  /// hit LOGIN API for get USER TOKEN


      }catch(e){
        emit(RegisterErrorState(errorMsg: e.toString()));
      }
    }
    );

  }
  }










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