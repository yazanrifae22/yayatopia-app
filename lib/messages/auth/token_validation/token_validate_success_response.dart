class TokenValidateSucessResponse
{
  late bool result;

  TokenValidateSucessResponse.fromJson(Map<String,dynamic> map)
  {
    result=map['result'];
  }
}