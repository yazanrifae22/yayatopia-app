import 'dart:async';

import 'package:dio/dio.dart';
import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:yayatopia/blocs/auth/auth_event.dart';
import 'package:yayatopia/blocs/auth/auth_state.dart';
import 'package:yayatopia/messages/auth/change_password/change_password_request.dart';
import 'package:yayatopia/messages/auth/change_password/change_password_success_response.dart';
import 'package:yayatopia/messages/auth/login/login_request.dart';
import 'package:yayatopia/messages/auth/login/login_success_response.dart';
import 'package:yayatopia/messages/auth/profile/get_profile_request.dart';
import 'package:yayatopia/messages/auth/register/register_request.dart';
import 'package:yayatopia/messages/auth/social_login/create_social_login_rqeuest.dart';
import 'package:yayatopia/messages/auth/update_profile/update_profile_request.dart';
import 'package:yayatopia/model/auth/user.dart';
import 'package:yayatopia/repositories/local/email_repository.dart';
import 'package:yayatopia/repositories/local/token_repository.dart';
import 'package:yayatopia/repositories/remote/auth/auth_repository.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthRepository authRepo = AuthRepository();
  EmailRepository emailRepo = EmailRepository();
  TokenRepository tokenRepo = TokenRepository();
  late MyUser user = MyUser();
  AuthBloc(AuthState initialState) : super(initialState);

  @override
  Stream<AuthState> mapEventToState(AuthEvent event) async* {
    if (event is AuthLogout) {
      yield AuthLoading();
      await authRepo.logout();
      yield Authinitialized();
    } else if (event is AuthWithFacebook) {
      if (await authRepo.signInWithFacebook()) {
        yield AuthLoading();
        try {
          Response r = await authRepo.signUpSocialAccount(
              message: CreateSocialLoginRequest(
                  email: FirebaseAuth.instance.currentUser!.email!,
                  uid: FirebaseAuth.instance.currentUser!.uid));
          MyUser u = MyUser.fromJson(
              r.data, FirebaseAuth.instance.currentUser!.email!);
          tokenRepo.set(token: u.token!);
          emailRepo.set(email: u.email!);
          user = u;
          yield AuthAuthenticated(u);
        } on DioError catch (e) {
          if (e.response != null)
            yield AuthUnAuthenticated(error: "Facebook Auth Error");
        }
      } else {
        yield Authinitialized();
      }
    } else if (event is AuthWithGoogle) {
      if (await authRepo.signInWithGoogle()) {
        yield AuthLoading();
        try {
          Response r = await authRepo.signUpSocialAccount(
              message: CreateSocialLoginRequest(
                  email: FirebaseAuth.instance.currentUser!.email!,
                  uid: FirebaseAuth.instance.currentUser!.uid));
          MyUser u = MyUser.fromJson(
              r.data, FirebaseAuth.instance.currentUser!.email!);
          tokenRepo.set(token: u.token!);
          emailRepo.set(email: u.email!);
          user = u;
          yield AuthAuthenticated(u);
        } on DioError catch (e) {
          if (e.response != null)
            yield AuthUnAuthenticated(error: "Google Auth Error");
        }
      } else {
        yield Authinitialized();
      }
    } else if (event is AuthInitialize) {
      yield Authinitialized();
    } else if (event is AuthGetProfileEvent) {
      print("Profile");
      if (await tokenRepo.checkIfExist()) {
        try {
          String? token = await tokenRepo.get();
          String? email = await emailRepo.get();
          Response res = await authRepo.getProfile(
              message: GetProfileMessageRequest(token: token!, email: email!));
          if (res.statusCode == 200) {
            user = MyUser.fromJson(res.data, email);
            yield AuthAuthenticated(MyUser.fromJson(res.data, email));
          }
        } on DioError catch (e) {
          if (e.response != null) yield AuthInvalidToken();
        }
      } else {
        yield AuthInvalidToken();
      }
    }
    // else if(event is AuthValidateTokenEvent)
    // {

    //   if(await tokenRepo.checkIfExist())
    //   {
    //     try
    //     {
    //       String? token=await tokenRepo.get();
    //       String? email=await emailRepo.get();
    //       Response res=await authRepo.validateToken
    //       (
    //         message:TokenValidateMessageRequest
    //         (
    //           token:token!,
    //           email:email!
    //         ));
    //       if(res.statusCode==200)
    //       {
    //         yield AuthAuthenticated();
    //       }
    //     }
    //     on DioError catch(e)
    //     {
    //       if(e.response!=null)
    //         yield AuthInvalidToken();
    //     }
    //   }
    //   else
    //   {
    //     yield AuthInvalidToken();
    //   }
    // }
    else if (event is AuthRegisterEvent) {
      yield AuthValidating();
      if (EmailValidator.validate(event.email) &&
          event.password.length >= 6 &&
          event.password == event.confirmPassword) {
        yield AuthLoading();
        try {
          Response res = await authRepo.register(
              message: RegisterMessageRequest(
                  email: event.email, password: event.password));
          LoginMessageSuccessResponse message =
              LoginMessageSuccessResponse.fromJson(res.data);
          tokenRepo.set(token: message.token);
          emailRepo.set(email: event.email);
          this.add(AuthGetProfileEvent());
          // yield AuthAuthenticated();
        } on DioError catch (e) {
          if (e.response != null) {
            if (e.response!.statusCode == 400) {
              yield AuthUnAuthenticated(
                  error:
                      "Sorry,it appears that this email address is already registered");
            }
          }
        }
      } else {
        AuthInvalidRegister authError = AuthInvalidRegister();
        if (!EmailValidator.validate(event.email))
          authError.emailError = "Please enter a valid email address";
        if (event.password.length < 6)
          authError.passwordError =
              'Password must be at least 6 characters long.';
        if (event.password != event.confirmPassword) {
          authError.passwordConfirmError = 'Passwords do not match!';
        }
        yield authError;
      }
    } else if (event is AuthLoginEvent) {
      yield AuthValidating();
      if (EmailValidator.validate(event.email) && event.password.length > 0) {
        yield AuthLoading();
        try {
          Response res = await authRepo.login(
              message: LoginMessageRequest(
                  email: event.email, password: event.password));
          LoginMessageSuccessResponse message =
              LoginMessageSuccessResponse.fromJson(res.data);
          tokenRepo.set(token: message.token);
          emailRepo.set(email: event.email);
          print("ok");
          // if (res.statusCode == 400) {
          //   yield AuthUnAuthenticated(
          //       error: "Invalid username and/or password.");
          // }
          this.add(AuthGetProfileEvent());
          // yield AuthAuthenticated();
        } on DioError catch (e) {
          if (e.response != null) {
            if (e.response!.statusCode == 400) {
              print('auth');
              yield AuthUnAuthenticated(
                  error: "Invalid username and/or password.");
            }
          }
        }
      } else {
        AuthInvalidLogin authError = AuthInvalidLogin();
        if (!EmailValidator.validate(event.email))
          authError.emailError = "Please enter a valid email address";
        if (event.password.length < 1)
          authError.passwordError = 'This field is required';
        yield authError;
      }
    } else if (event is ChangePasswordEvent) {
      yield AuthLoading();
      try {
        Response r = await authRepo.changePassword(
            message: ChangePasswordRequest(
                email: (await emailRepo.get())!,
                token: (await tokenRepo.get())!,
                oldPassword: event.oldPassword,
                newPassword: event.newPassword,
                newPasswordConfirm: event.newPasswordConfirm));
        ChangePasswordSuccessResponse res =
            ChangePasswordSuccessResponse.fromJson(r.data);
        tokenRepo.set(token: res.token);
        EasyLoading.showSuccess('Password Changed');

        yield PasswordChanged();

        yield AuthAuthenticated(user);
      } on DioError catch (e) {
        if (e.response != null) if (e.response!.statusCode == 400)
          yield ChangePasswordError(e.response!.data['error']);
      }
    } else if (event is AuthUpdateProfileEvent) {
      yield AuthLoading();
      try {
        await authRepo.changeName(
          message: UpdateProfileRequest(
              firstName: event.firstName, lastName: event.lastName),
          email: (await emailRepo.get())!,
          token: (await tokenRepo.get())!,
        );
        EasyLoading.showSuccess('Name Changed');
        yield AuthAuthenticated(MyUser(
            email: user.email,
            firstName: event.firstName,
            lastName: event.lastName,
            profileImage: user.profileImage,
            token: user.token));
      } on DioError catch (e) {
        if (e.response != null) if (e.response!.statusCode == 400)
          EasyLoading.showError('Error');
      }
    }
  }
}
