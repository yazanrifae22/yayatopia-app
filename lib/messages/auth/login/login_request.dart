import 'dart:convert';


class LoginMessageRequest
{
  late String email;
  late String password;
  LoginMessageRequest({required this.email,required this.password});
  String toJson()
  {
    return jsonEncode({
      'email':this.email,
      'password':this.password
    });
  }
}