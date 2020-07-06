import 'package:flutter/material.dart';

class ExhibitionIdentifier extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Center(
            child: Container(
                width: 250,
                child: TextField(
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: const BorderRadius.all(
                          const Radius.circular(30.0),
                        ),
                      ),
                      filled: false,
                      hintStyle: TextStyle(color: Colors.grey[800]),
                      hintText: "Enter Exhibition Code",
                      fillColor: Colors.white70),
                )),
          ),
          Text('-OR-'),
          Text('SCAN'),
          IconButton(
            icon: Icon(Icons.crop_landscape),
            onPressed: () {},
          )
        ],
      ),
    );
  }
}
