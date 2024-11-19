class ChangePasswordRequest
{
  String email;
  String token;
  String oldPassword;
  String newPassword;
  String newPasswordConfirm;
  ChangePasswordRequest({required this.email,required this.token,required this.oldPassword,required this.newPassword,required this.newPasswordConfirm});
  Map<String,dynamic> toJson()
  {
    return 
    {
      'email':this.email,
      'token':this.token,
      'old_password':this.oldPassword,
      'new_password':this.newPassword,
      'new_password_confirm':this.newPasswordConfirm
    };
  }
}