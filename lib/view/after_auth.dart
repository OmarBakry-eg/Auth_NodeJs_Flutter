import 'package:e_learning/database/local.dart';
import 'package:flutter/material.dart';
import '../database/local.dart';

class ViewDetails extends StatefulWidget {
  final String token;
  ViewDetails({@required this.token});
  @override
  _ViewDetailsState createState() => _ViewDetailsState();
}

class _ViewDetailsState extends State<ViewDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: Text('E- learning project'),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Token is : ${widget.token}'),
                RaisedButton(
                  onPressed: () {
                    DataInLocal.saveInLocal(token: 'No value stored');
                    Navigator.pop(context);
                  },
                  child: Text('Logout'),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
