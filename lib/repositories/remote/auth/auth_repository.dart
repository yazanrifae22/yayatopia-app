
import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:yayatopia/core/dio_base.dart';
import 'package:yayatopia/messages/auth/change_password/change_password_request.dart';
import 'package:yayatopia/messages/auth/login/login_request.dart';
import 'package:yayatopia/messages/auth/profile/get_profile_request.dart';
import 'package:yayatopia/messages/auth/register/register_request.dart';
import 'package:yayatopia/messages/auth/social_login/create_social_login_rqeuest.dart';
import 'package:yayatopia/messages/auth/token_validation/token_validate_request.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:yayatopia/messages/auth/update_profile/update_profile_request.dart';
import 'package:yayatopia/repositories/local/token_repository.dart';

class AuthRepository
{
  Future<Response> login({required LoginMessageRequest message})  
  {
      return DioBase.instance.post('auth/login',data: message.toJson());  
  }
  Future<Response> register({required RegisterMessageRequest message}) 
  {
    return DioBase.instance.post('auth/signup',data:message.toJson());
  }
  Future<Response> validateToken({required TokenValidateMessageRequest message}) 
  {
    return DioBase.instance.post('auth/validate-token',data:message.toJson());
  }
  Future<Response> getProfile({required GetProfileMessageRequest message})
  { 
    return DioBase.instance.post('user/profile',data:message.toJson());
  }
  Future<Response> changePassword({required ChangePasswordRequest message})
  { 
    return DioBase.instance.post('user/update-password',data:message.toJson());
  }
  Future<Response> changeName({required UpdateProfileRequest message,required String token,required String email})
  { 
    return DioBase.instance.post
    (
      'user/update-profile',
      options: Options
      (
        headers: 
        {
          "email":email,
          "auth-token":token
        }
      ),
      data:message.toJson(),
    );
  }
  Future<Response> signUpSocialAccount({required CreateSocialLoginRequest message})
  { 
    return DioBase.instance.post('auth/signup-social-account',data:message.toJson());
  }
  Future<bool> signInWithGoogle() async
  {
    try 
    {
      // Trigger the authentication flow
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      // Obtain the auth details from the request
      final GoogleSignInAuthentication googleAuth = await googleUser!.authentication;
      // Create a new credential
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );
      // Once signed in, return the UserCredential
      await FirebaseAuth.instance.signInWithCredential(credential);

      return true;
    }
    catch(e)
    {
      return false;
    } 
  }
  Future<bool> signInWithFacebook() async {
  try
  {
    // Trigger the sign-in flow
    final LoginResult result = await FacebookAuth.instance.login();

    // Create a credential from the access token
    final facebookAuthCredential = FacebookAuthProvider.credential(result.accessToken!.token);

    // Once signed in, return the UserCredential
    await FirebaseAuth.instance.signInWithCredential(facebookAuthCredential);
    return true;
  }
  catch(e)
  {
    return false;
  }
  }
  Future<void> logout() async
  {
    if(FirebaseAuth.instance.currentUser!=null)
    {
      if(await GoogleSignIn().isSignedIn())
        await GoogleSignIn().disconnect();
      else
      {
         FacebookAuth.instance.logOut();
      }
      await FirebaseAuth.instance.signOut();
    }
    TokenRepository().delete();
      
  }

}