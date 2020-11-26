import 'package:Flahscard/database/controllers/users_ctr.dart';
import 'package:Flahscard/functions/account.dart';
import 'package:Flahscard/models/user.dart';
import 'package:Flahscard/pages/homepage.dart';
import 'package:email_validator/email_validator.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SignUp extends StatefulWidget {
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final _formKeyName = GlobalKey<FormState>();
  final _formKeyEmail = GlobalKey<FormState>();
  final _formKeyPassword = GlobalKey<FormState>();
  final _formKeyConfirmPassword = GlobalKey<FormState>();

  TextEditingController _textControllerName = TextEditingController();
  TextEditingController _textControllerEmail = TextEditingController();
  TextEditingController _textControllerPassword = TextEditingController();
  TextEditingController _textControllerConfirmPassword =
      TextEditingController();

  String _name = "";
  String _email = "";
  String _password = "";
  bool _obscureText = true;

  LoginCtr _controller = LoginCtr();

  void _toggle() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  void _submit() async {
    final formName = _formKeyName.currentState;
    final formEmail = _formKeyEmail.currentState;
    final formPassword = _formKeyPassword.currentState;

    if (formName.validate() &&
        formEmail.validate() &&
        formPassword.validate()) {
      setState(() {
        formName.save();
        formEmail.save();
        formPassword.save();
        _controller.saveUser(
          User(name: _name, email: _email, password: _password),
        );
      });
      await logIn(_email, _password).then((value) => value
          ? Navigator.of(context).pushAndRemoveUntil(
              CupertinoPageRoute(builder: (context) => Homepage()),
              (route) => false)
          : print("Não foi possivel cadastrar"));
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScopeNode currentFocus = FocusScope.of(context);

        currentFocus.unfocus();
      },
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              SizedBox(height: 8),
              Center(
                child: Container(
                  width: 40,
                  height: 5,
                  decoration: BoxDecoration(
                    color: Colors.grey,
                    borderRadius: BorderRadius.circular(50),
                  ),
                ),
              ),
              SizedBox(height: 8),
              Text(
                'Criar conta',
                style: TextStyle(
                  color: Colors.grey[800],
                  fontWeight: FontWeight.bold,
                  fontSize: 30,
                ),
              ),
              Text(
                'Crie sua conta e comece a estudar.',
                style: TextStyle(
                  color: Colors.grey[800],
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(height: 44),
              Form(
                key: _formKeyName,
                child: TextFormField(
                  controller: _textControllerName,
                  textCapitalization: TextCapitalization.sentences,
                  onSaved: (input) => _name = input,
                  onChanged: (input) => setState(() => _name = input),
                  validator: (input) {
                    if (input.trim().length < 3)
                      return 'O nome de usuário dever ter no mínimo 3 caracteres';
                    if (input[0] == " ")
                      return "O nome de usuário não deve começar com um espaço em branco";
                    return null;
                  },
                  style: TextStyle(
                    fontSize: 18.0,
                    color: Colors.grey[800],
                    fontWeight: FontWeight.w500,
                  ),
                  decoration: InputDecoration(
                    isDense: true,
                    icon: Icon(
                      EvaIcons.personOutline,
                      size: 30,
                    ),
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                    labelStyle: TextStyle(
                      fontSize: 25.0,
                      color: Colors.grey,
                    ),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                        width: 1,
                        color: Colors.grey[300],
                      ),
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                        width: 2,
                        color: Color(0xffFF8C00),
                      ),
                    ),
                    focusedErrorBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                        width: 2,
                        color: Colors.red,
                      ),
                    ),
                    errorStyle: TextStyle(fontSize: 14, color: Colors.red),
                    errorMaxLines: 2,
                    hintText: "Nome",
                    hintStyle: TextStyle(
                      color: Colors.grey,
                      fontSize: 18.0,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 16),
              Form(
                key: _formKeyEmail,
                child: TextFormField(
                  controller: _textControllerEmail,
                  textCapitalization: TextCapitalization.sentences,
                  onSaved: (input) => _email = input,
                  onChanged: (input) => setState(() => _email = input),
                  validator: (input) {
                    if (!EmailValidator.validate(input))
                      return 'Digite um e-mail válido';
                    return null;
                  },
                  style: TextStyle(
                    fontSize: 18.0,
                    color: Colors.grey[800],
                    fontWeight: FontWeight.w500,
                  ),
                  decoration: InputDecoration(
                    isDense: true,
                    icon: Icon(
                      EvaIcons.emailOutline,
                      size: 30,
                    ),
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                    labelStyle: TextStyle(
                      fontSize: 25.0,
                      color: Colors.grey,
                    ),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                        width: 1,
                        color: Colors.grey[300],
                      ),
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                        width: 2,
                        color: Color(0xffFF8C00),
                      ),
                    ),
                    focusedErrorBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                        width: 2,
                        color: Colors.red,
                      ),
                    ),
                    errorStyle: TextStyle(fontSize: 14, color: Colors.red),
                    errorMaxLines: 2,
                    hintText: "email@exemplo.com.br",
                    hintStyle: TextStyle(
                      color: Colors.grey,
                      fontSize: 18.0,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 16),
              Form(
                key: _formKeyPassword,
                child: TextFormField(
                  obscureText: _obscureText,
                  controller: _textControllerPassword,
                  textCapitalization: TextCapitalization.sentences,
                  onSaved: (input) => _password = input,
                  onChanged: (input) => setState(() => _password = input),
                  validator: (input) {
                    if (input.trim().length < 8)
                      return 'A senha deve ter no mínimo 8 caracteres';
                    if (input.contains(" "))
                      return "A senha não deve conter espaços em branco";
                    return null;
                  },
                  style: TextStyle(
                    fontSize: 18.0,
                    color: Colors.grey[800],
                    fontWeight: FontWeight.w500,
                  ),
                  decoration: InputDecoration(
                    isDense: true,
                    suffixIcon: IconButton(
                      onPressed: _toggle,
                      icon: _obscureText
                          ? Icon(EvaIcons.eyeOutline)
                          : Icon(EvaIcons.eyeOffOutline),
                    ),
                    icon: Icon(
                      EvaIcons.lockOutline,
                      size: 30,
                    ),
                    contentPadding: EdgeInsets.all(8),
                    labelStyle: TextStyle(
                      fontSize: 25.0,
                      color: Colors.grey,
                    ),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                        width: 1,
                        color: Colors.grey[300],
                      ),
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                        width: 2,
                        color: Color(0xffFF8C00),
                      ),
                    ),
                    focusedErrorBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                        width: 2,
                        color: Colors.red,
                      ),
                    ),
                    errorStyle: TextStyle(fontSize: 14, color: Colors.red),
                    errorMaxLines: 2,
                    hintText: 'Senha',
                    hintStyle: TextStyle(
                      color: Colors.grey,
                      fontSize: 18.0,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 55),
              Container(
                width: MediaQuery.of(context).size.width,
                height: 55,
                child: RawMaterialButton(
                  onPressed: () {
                    _submit();
                  },
                  fillColor: Color(0xffFFA200),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Text(
                    "Inscrever-se",
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
