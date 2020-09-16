import 'package:e_learning/sign_up.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

String errorMessage = 'no';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Authentication(),
    );
  }
}

class Authentication extends StatefulWidget {
  @override
  _AuthenticationState createState() => _AuthenticationState();
}

class _AuthenticationState extends State<Authentication> {
  String email, password, username, gender;
  var _formKey = GlobalKey<FormState>();
  bool spinner = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ModalProgressHUD(
        inAsyncCall: spinner,
        child: Form(
          key: _formKey,
          child: SafeArea(
              child: Center(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  TextFiledEditing(
                    labelName: 'Email',
                    hint: 'Type your Email',
                    onChangedFunc: (String val) {
                      email = val;
                    },
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  TextFiledEditing(
                    labelName: 'Password',
                    hint: 'type pass',
                    onChangedFunc: (String val) {
                      password = val;
                    },
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  TextFiledEditing(
                    labelName: 'Gender',
                    hint: 'your gender',
                    onChangedFunc: (String val) {
                      gender = val;
                    },
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  TextFiledEditing(
                    labelName: 'username',
                    hint: 'name',
                    onChangedFunc: (String val) {
                      username = val;
                    },
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      RaisedButton(
                        onPressed: () async {
                          if (_formKey.currentState.validate()) {
                            setState(() {
                              spinner = true;
                            });
                            await AuthController.authFunc(
                              email: email,
                              password: password,
                              username: username,
                              gender: gender,
                              login: false,
                            );
                            print('validate');
                            setState(() {
                              spinner = false;
                            });
                          }
                          errorMessage == 'no'
                              ? Text('')
                              : errorWhileSignUp(errorMessage, context);
                        },
                        child: Text('Sign up'),
                      ),
                      RaisedButton(
                        onPressed: () async {
                          if (_formKey.currentState.validate()) {
                            setState(() {
                              spinner = true;
                            });
                            await AuthController.authFunc(
                              email: email,
                              password: password,
                              login: true,
                            );
                            print('validate');
                            setState(() {
                              spinner = false;
                            });
                          }
                          errorMessage == 'no'
                              ? Text('')
                              : errorWhileSignUp(errorMessage, context);
                        },
                        child: Text('Sign In'),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          )),
        ),
      ),
    );
  }
}

class TextFiledEditing extends StatelessWidget {
  final String labelName;
  final String hint;
  final Function onChangedFunc;
  TextFiledEditing({this.hint, this.labelName, this.onChangedFunc});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextFormField(
        validator: (String val) {
          if (val.isEmpty) {
            return 'fill the field';
          }
          return null;
        },
        onChanged: onChangedFunc,
        decoration: InputDecoration(
          enabledBorder: outlineInputBorder,
          focusedBorder: outlineInputBorder,
          errorBorder: errorOutBorder,
          focusedErrorBorder: errorOutBorder,
          labelText: labelName,
          hintText: hint,
        ),
      ),
    );
  }
}

OutlineInputBorder outlineInputBorder = OutlineInputBorder(
  borderRadius: BorderRadius.all(Radius.circular(20)),
  borderSide: BorderSide(color: Colors.blue),
);

OutlineInputBorder errorOutBorder = outlineInputBorder.copyWith(
  borderSide: BorderSide(
    color: Colors.red,
  ),
);

Future<void> errorWhileSignUp(errorMessage, BuildContext context) {
  return showCupertinoDialog<void>(
      context: context,
      builder: (context) => AlertDialog(
            title: Text('Error While Registering'),
            content: Text(errorMessage.toString()),
            actions: <Widget>[
              FlatButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text(
                  'Try Again',
                  style: TextStyle(color: Colors.blueAccent),
                ),
              ),
            ],
          ));
}
