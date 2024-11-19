import 'package:shared_preferences/shared_preferences.dart';
class TokenRepository
{
  Future<String?> get() async
  {
    SharedPreferences prefs=await SharedPreferences.getInstance();
    return prefs.getString('token'); 
  }
  Future<bool> set({required String token})async 
  {
    SharedPreferences prefs=await SharedPreferences.getInstance();

    return prefs.setString('token', token);
  }
  Future<bool> delete() async
  {
    SharedPreferences prefs=await SharedPreferences.getInstance();

    return prefs.remove('token');
  }
  Future<bool> checkIfExist() async
  {
    SharedPreferences prefs=await SharedPreferences.getInstance();
    return prefs.containsKey('token');
  }
}