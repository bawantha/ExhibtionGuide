import 'package:connectivity/connectivity.dart';
import 'package:exhibition_guide/models/hall.dart';
import 'package:exhibition_guide/services/db_service.dart';
import 'package:flutter/material.dart';

class ExhibitionHome extends StatefulWidget {
  @override
  _ExhibitionHomeState createState() => _ExhibitionHomeState();
}

class _ExhibitionHomeState extends State<ExhibitionHome> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          BuildHall(
              hall: Hall(hallName: "Hall A", exhibitionId: 4864),
              top: 50,
              left: 0),
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

class BuildHall extends StatefulWidget {
  final Hall hall;
  final double top;
  final double left;

  const BuildHall(
      {Key key, @required this.hall, @required this.top, @required this.left})
      : super(key: key);

  @override
  _BuildHallState createState() => _BuildHallState(hall, top, left);
}

class _BuildHallState extends State<BuildHall> {
  EGDbService _db = EGDbService();

  final Hall hall;
  final double top;
  final double left;

  _BuildHallState(this.hall, this.top, this.left);

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: top,
      left: left,
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
                    ConnectivityResult result =
                        await Connectivity().checkConnectivity();
                    if (result == ConnectivityResult.wifi) {
                      Connectivity().getWifiBSSID().then((value) async {
                        hall.mac = value;
                        bool result = await _db.adMac(value);
                        print(result);
                        setState(() {});
                        final sn = SnackBar(
                            content: Text(value.toString()),
                            action: SnackBarAction(
                              label: 'Okay',
                              onPressed: () async {},
                            ));
                        Scaffold.of(context).showSnackBar(sn);
                      });
                    } else {
                      setState(() {});
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

                Navigator.pushNamed(context, '/hallDetails');
//                      print("Called");
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
    );
  }
}
