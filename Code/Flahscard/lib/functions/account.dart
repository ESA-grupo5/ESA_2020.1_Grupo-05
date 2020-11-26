import 'package:Flahscard/constants.dart';
import 'package:Flahscard/database/controllers/users_ctr.dart';
import 'package:Flahscard/models/user.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<bool> logIn(String email, String password) async {
  LoginCtr _controller = LoginCtr();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  User user = await _controller.getLogin(email, password);
  if (user != null) {
    prefs.setBool("isLogin", true);
    prefs.setInt("userId", user.id);
    userIdConstant = user.id;
    return true;
  }
  return false;
}

Future<bool> logOut() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setBool("isLogin", false);
  prefs.setInt("userId", 0);
  userIdConstant = 0;
  return true;
}
