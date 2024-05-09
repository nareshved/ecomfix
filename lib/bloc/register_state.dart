
import '../models/user_model/my_user_model.dart';

abstract class RegisterState {}

class RegisterInitialState extends RegisterState {}

class RegisterLoadingState extends RegisterState{}

class RegisterLoadedState extends RegisterState {
  UserModel userModel;
  RegisterLoadedState({required this.userModel});
}

class RegisterErrorState extends RegisterState {
  String errorMsg;
  RegisterErrorState({required this.errorMsg});
}
