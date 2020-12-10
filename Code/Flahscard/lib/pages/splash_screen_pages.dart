import 'package:Flahscard/constants.dart';
import 'package:Flahscard/pages/homepage.dart';
import 'package:Flahscard/pages/welcome_page.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:splashscreen/splashscreen.dart';

class SplashScreenPage extends StatefulWidget {
  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<SplashScreenPage> {
  bool _isLogin = false;
  int _userId = 0;

  Future<bool> _checkLogin() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool isLogin = (prefs.get('isLogin') ?? false);
    int userId = (prefs.get('userId') ?? 0);

    setState(() {
      _isLogin = isLogin;
      _userId = userId;
    });
    userIdConstant = userId;
    return isLogin;
  }

  @override
  void initState() {
    _checkLogin();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _checkLogin(),
      builder: (context, snapshot) {
        return snapshot.hasData
            ? SplashScreenWidget(isLogin: _isLogin)
            : Material();
      },
    );
  }
}

class SplashScreenWidget extends StatelessWidget {
  final bool isLogin;

  const SplashScreenWidget({Key key, this.isLogin}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          SplashScreen(
            seconds: 3,
            backgroundColor: Color(0xff622162),
            navigateAfterSeconds: !isLogin ? WelcomePage() : Homepage(),
            loaderColor: Colors.transparent,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Spacer(),
              Center(
                  child: Container(
                child: Image.asset(
                  "assets/flashly-smile.png",
                  height: 125,
                  width: 125,
                ),
              )),
              Spacer(),
              Text(
                "FLASHLY",
                style: TextStyle(
                  color: Colors.white24,
                  fontSize: 34,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 32),
            ],
          ),
        ],
      ),
    );
  }
}
