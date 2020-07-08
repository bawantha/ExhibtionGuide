import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ExhibitionHome extends StatefulWidget {
  @override
  _ExhibitionHomeState createState() => _ExhibitionHomeState();
}

class _ExhibitionHomeState extends State<ExhibitionHome> {
  FlutterToast flutterToast;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
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
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Builder(
                    builder: (BuildContext context) {
                      return RaisedButton(
                        padding: EdgeInsets.all(0),
                        textColor: Colors.white,
                        color: Colors.grey,
                        child: Icon(Icons.wifi),
                        onPressed: () async {
                          print("Called");
                          ConnectivityResult result =
                              await Connectivity().checkConnectivity();
                          if (result == ConnectivityResult.wifi) {
                                Connectivity().getWifiBSSID().then((value) {
                                  final sn = SnackBar(
                                      content: Text(value.toString()),
                                      action: SnackBarAction(
                                        label: 'Okay',
                                        onPressed: () {
                                          // Some code to undo the change.
                                        },
                                      ));
                                  Scaffold.of(context).showSnackBar(sn);
                                });
                          } else {
                            final sn = SnackBar(
                                content: Text('Please Connect To a  WIFI Router'),
                                action: SnackBarAction(
                                  label: 'Okay',
                                  onPressed: () {
                                    // Some code to undo the change.
                                  },
                                ));
                            Scaffold.of(context).showSnackBar(sn);
                          }
                        },
                        shape: CircleBorder(),
                      );
                    },
                  ),
                  RaisedButton(
                    textColor: Colors.white,
                    color: Colors.blue,
                    child: Icon(Icons.edit),
                    onPressed: () {
                      print("Called");
                    },
                    shape: CircleBorder(),
                  ),
                  RaisedButton(
                    textColor: Colors.white,
                    color: Colors.blue,
                    child: Icon(Icons.send),
                    onPressed: () {},
                    shape: CircleBorder(),
                  )
                ],
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
      ),
    );
  }
}
