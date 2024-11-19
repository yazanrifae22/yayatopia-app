class RegisterMessageSuccessResponse
{
  late bool result;
  late String token;
  RegisterMessageSuccessResponse.fromJson(Map<String,dynamic> map)
  {
    result=map['result'];
    token=map['token'];
  }
}