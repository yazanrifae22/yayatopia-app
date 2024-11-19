class LoginMessageSuccessResponse
{
  late String result;
  late String token;
  LoginMessageSuccessResponse.fromJson(Map<String,dynamic> map)
  {
    result=map['result'];
    token=map['token'];
  }
}