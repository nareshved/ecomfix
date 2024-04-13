part of 'register_bloc.dart';

abstract class RegisterEvent {}

class CreateUserEvent extends RegisterEvent {
 UserModel newUser;
 CreateUserEvent({required this.newUser,});
}

class LoginUserEvent extends RegisterEvent {
 String eEmail;
 String ePass;
 LoginUserEvent({required this.eEmail, required this.ePass});

}
