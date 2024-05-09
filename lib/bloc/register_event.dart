import 'package:flutter/material.dart';
import '../models/user_model/my_user_model.dart';

abstract class RegisterEvent {}

class CreateUserEvent extends RegisterEvent {
 UserModel newUser;
 BuildContext context;
 CreateUserEvent({required this.context, required this.newUser,});
}

class LoginUserEvent extends RegisterEvent {
 String userEmail;
 String userPassword;
 BuildContext context;
 LoginUserEvent({required this.userEmail, required this.userPassword, required this.context});

}
