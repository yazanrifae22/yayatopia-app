import 'dart:convert';

class TokenValidateMessageRequest
{
  late String token;
  late String email;

  TokenValidateMessageRequest({required this.token,required this.email});
  String toJson()
  {
    return jsonEncode({
      'token':this.token,
      "email":this.email
    });
  }
}
