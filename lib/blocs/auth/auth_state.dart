import 'package:equatable/equatable.dart';
import 'package:yayatopia/model/auth/user.dart';

abstract class AuthState extends Equatable {
  @override
  List<Object> get props => [];
}
class Authinitialized extends AuthState {}

class TokenValidation extends AuthState{}


class AuthAuthenticated extends AuthState 
{
  final MyUser user;
  final bool loading;
  AuthAuthenticated(this.user,{this.loading=false});
}

// ignore: must_be_immutable
class AuthInvalidLogin extends AuthState 
{
  String? emailError;
  String? passwordError;
}
class AuthValidating extends AuthState{}
// ignore: must_be_immutable
class AuthInvalidRegister extends AuthState 
{
  String? emailError;
  String? passwordError;
  String? passwordConfirmError;
}
class AuthUnAuthenticated extends AuthState 
{
  final String error;
  AuthUnAuthenticated({required this.error});
}
class AuthInvalidToken extends AuthState{}
class AuthLoading extends AuthState {}

class PasswordChanged extends AuthState
{
}
class ChangePasswordError extends AuthState
{
  final String error;
  ChangePasswordError(this.error);
}