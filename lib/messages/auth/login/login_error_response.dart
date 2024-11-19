
class LoginMessageErrorResponse
{
  late String error;
  LoginMessageErrorResponse.fromJson(Map<String,dynamic> map)
  {

    if(map['error'] is String)
      this.error=map['error'];
  }
}