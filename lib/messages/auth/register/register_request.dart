import 'dart:convert';

class RegisterMessageRequest
{
  late String email;
  late String password;
  RegisterMessageRequest({required this.email,required this.password});
  String toJson()
  {
    return jsonEncode({
      'email':this.email,
      'username':this.email,
      'password':this.password,
      'password_confirm':this.password
    });
  }
}