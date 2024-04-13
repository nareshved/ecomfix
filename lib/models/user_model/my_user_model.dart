
/// creating model for firebase collection
class UserModel {

  String firstName;
  String lastName;
  String userEmail;
  String userPass;
  String userPhone;

  UserModel({required this.firstName, required this.lastName, required this.userEmail, required this.userPass,
    required this.userPhone
  });

  factory UserModel.fromDoc(Map<String, dynamic> userdata){
    return UserModel(
        firstName: userdata["firstName"],
        lastName: userdata["lastName"],
        userEmail: userdata["userEmail"],
        userPass: userdata["userPass"],
        userPhone: userdata["userPhone"]
    );
  }

  Map<String, dynamic> toDoc(){
    return {
      "firstName" : firstName,
      "lastName" : lastName,
      "userEmail" : userEmail,
      "userPass" : userPass,

    };
  }


}