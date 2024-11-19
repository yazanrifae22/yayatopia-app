class CreateSocialLoginRequest
{
  String email;
  String uid;
  CreateSocialLoginRequest({required this.email,required this.uid});
  Map<String,dynamic> toJson()
  {
    return 
    {
      'email':this.email,
      'uid':this.uid
    };
  }
}