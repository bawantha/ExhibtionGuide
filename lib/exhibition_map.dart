import 'package:flutter/material.dart';

class ExhibitionMap extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Positioned(
          top: 50,
          left: 0,
          child: Container(
            width: 150,
            height: 250,
            decoration: BoxDecoration(
              border: Border.all(color: Colors.black),
            ),
            child: Center(
              child: RaisedButton(
                textColor: Colors.white,
                color: Colors.redAccent,
                child: Text("A"),
                onPressed: () {
                  Navigator.pushNamed(context, '/stall');
                },
                shape: CircleBorder(),
              ),
            ),
          ),
        ),
        Positioned(
          top: 150,
          right: 0,
          child: Container(
            width: 150,
            height: 250,
            decoration: BoxDecoration(
              border: Border.all(color: Colors.black),
            ),
            child: Center(
              child: RaisedButton(
                textColor: Colors.white,
                color: Colors.grey,
                child: Text("B"),
                onPressed: () {},
                shape: CircleBorder(),
              ),
            ),
          ),
        ),
        Positioned(
          bottom: 0,
          left: 0,
          child: Container(
            width: 300,
            height: 150,
            child: Center(
              child: RaisedButton(
                textColor: Colors.white,
                color: Colors.grey,
                child: Text("C"),
                onPressed: () {},
                shape: CircleBorder(),
              ),
            ),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.black),
            ),
          ),
        )
      ],
    );
  }
}
