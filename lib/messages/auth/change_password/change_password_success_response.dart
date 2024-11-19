class ChangePasswordSuccessResponse
{
  late String result;
  late String token;
  ChangePasswordSuccessResponse.fromJson(Map<String,dynamic> map)
  {
    this.result=map['result'];
    this.token=map['token'];
  }

}