import 'package:e_learning/view/after_auth.dart';
import 'package:e_learning/database/local.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import '../consts.dart';
import '../controller/authController.dart';
import '../main.dart';

class Authentication extends StatefulWidget {
  @override
  _AuthenticationState createState() => _AuthenticationState();
}

class _AuthenticationState extends State<Authentication> {
  String email, password, username, gender;
  var _formKey = GlobalKey<FormState>();
  bool spinner = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    DataInLocal.useValueToNavigate(context);
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Text('E-Learning Project'),
          bottom: TabBar(
            tabs: [
              Tab(
                child: Text('Login'),
              ),
              Tab(
                child: Text('Sign up'),
              ),
            ],
          ),
        ),
        body: ModalProgressHUD(
          inAsyncCall: spinner,
          child: Form(
            key: _formKey,
            child: SafeArea(
                child: Center(
              child: TabBarView(
                physics: NeverScrollableScrollPhysics(),
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
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
                              ? Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => ViewDetails(
                                        token: AuthController.authModel.token),
                                  ),
                                )
                              : errorWhileSignUp(errorMessage, context);
                        },
                        child: Text('Sign In'),
                      ),
                    ],
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
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
                              ? Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => ViewDetails(
                                        token: AuthController.authModel.token),
                                  ),
                                )
                              : errorWhileSignUp(errorMessage, context);
                        },
                        child: Text('Sign up'),
                      ),
                    ],
                  ),
                ],
              ),
            )),
          ),
        ),
      ),
    );
  }
}
