import 'package:shared_preferences/shared_preferences.dart';
class EmailRepository
{
  Future<String?> get() async
  {
    SharedPreferences prefs=await SharedPreferences.getInstance();
    return prefs.getString('email'); 
  }
  Future<bool> set({required String email})async 
  {
    SharedPreferences prefs=await SharedPreferences.getInstance();

    return prefs.setString('email', email);
  }
  Future<bool> delete() async
  {
    SharedPreferences prefs=await SharedPreferences.getInstance();

    return prefs.remove('email');
  }
  Future<bool> checkIfExist() async
  {
    SharedPreferences prefs=await SharedPreferences.getInstance();
    return prefs.containsKey('email');
  }
}