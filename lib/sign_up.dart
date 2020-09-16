import 'package:e_learning/main.dart';
import 'reg_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class AuthController {
  static const String regUrl =
      "Link Here";
  static const String loginUrl =
       "Link Here";
  static const Map<String, String> myHeaders = {
    " Headers" : "Here",
  };
  static AuthModel regModel = AuthModel();

  static Future authFunc({
    String email,
    String password,
    String username,
    String gender,
    bool login,
  }) async {
    Map<String, dynamic> signUpMap = {
      "email": email,
      "password": password,
      "username": username,
      "gender": gender
    };
    Map<String, dynamic> signInMap = {
      "email": email,
      "password": password,
      "username": username,
      "gender": gender
    };
    final user = json.encode(login ? signInMap : signUpMap);

    http.Response response = await http.post(
      login ? loginUrl : regUrl,
      headers: myHeaders,
      body: user,
    );
    if (response.statusCode == 200 || response.statusCode == 201) {
      regModel = AuthModel.fromJson(json.decode(response.body));
      login
          ? print("LoggedIn token ${[regModel.token, regModel.user.email]}")
          : print("SignUp token ${[regModel.token, regModel.user.email]}");
      return regModel;
    } else {
      print(jsonDecode(response.body));
      errorMessage = jsonDecode(response.body).toString();
      print("failed in Auth ${response.statusCode}");
    }
  }
}
