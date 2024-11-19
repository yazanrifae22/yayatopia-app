class RegisterMessageErrorResponse
{
  late String error;
  RegisterMessageErrorResponse.fromJson(Map<String,dynamic> map)
  {
    if(map['error'].containsKey('username'))
      this.error= map['error']['username'][0];
  }
}