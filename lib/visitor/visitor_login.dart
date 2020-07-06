import 'package:exhibition_guide/visitor/exhibition_identifier.dart';
import 'package:flutter/material.dart';

class VisitorLogin extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: RaisedButton(
          onPressed: () {
            Navigator.popAndPushNamed(context, '/exhibitionIdentifier');
          },
          child: Text("Login"),
        ),
      ),
    );
  }
}
