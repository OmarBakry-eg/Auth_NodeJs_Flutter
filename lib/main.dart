import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'view/authentication.dart';

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
