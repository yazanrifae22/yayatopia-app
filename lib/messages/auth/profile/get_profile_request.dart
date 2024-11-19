import 'dart:convert';

class GetProfileMessageRequest
{
  late String token;
  late String email;

  GetProfileMessageRequest({required this.token,required this.email});
  String toJson()
  {
    return jsonEncode({
      'token':this.token,
      "email":this.email
    });
  }
}
