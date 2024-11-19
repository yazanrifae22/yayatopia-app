import 'package:equatable/equatable.dart';

class AuthEvent extends Equatable
{
  @override
  List<Object?> get props => [];
}

class AuthInitialize extends AuthEvent
{
  
}
class AuthLoginEvent extends AuthEvent
{
  final String email;
  final String password;
  AuthLoginEvent({required this.email,required this.password});
  
}
class AuthRegisterEvent extends AuthEvent
{
  final String email;
  final String password;
  final String confirmPassword;
  AuthRegisterEvent({required this.email,required this.password,required this.confirmPassword});
  
}
class AuthValidateTokenEvent extends AuthEvent
{
  AuthValidateTokenEvent();
}
class AuthWithGoogle extends AuthEvent
{

}
class AuthWithFacebook extends AuthEvent
{}
class ChangePasswordEvent extends AuthEvent
{
  final String oldPassword;
  final String newPassword;
  final String newPasswordConfirm;
  ChangePasswordEvent({required this.oldPassword,required this.newPassword,required this.newPasswordConfirm});
}
class AuthUpdateProfileEvent extends AuthEvent
{
  final String firstName;
  final String lastName;
  AuthUpdateProfileEvent({required this.firstName,required this.lastName});
}
class AuthGetProfileEvent extends AuthEvent
{

}
class AuthLogout extends AuthEvent
{
  
}
