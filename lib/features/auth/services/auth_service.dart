import 'package:e_commerce_app/models/user.dart';

class AuthService {
  // sign up user
  void signUpUser(
      {required String email,
      required String password,
      required String name}) async {
    try {
      UserModel user = UserModel(
          id: '',
          name: name,
          email: email,
          password: password,
          address: '',
          type: '',
          token: ''
          );
        
    } catch (e) {}
  }
}
