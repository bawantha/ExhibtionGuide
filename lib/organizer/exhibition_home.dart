import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connectivity/connectivity.dart';
import 'package:exhibition_guide/Providers/exhibtion_home_provider.dart';
import 'package:exhibition_guide/models/hall.dart';
import 'package:exhibition_guide/models/message.dart';
import 'package:exhibition_guide/services/db_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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

  const BuildHall({Key key, @required this.hall, @required this.top, @required this.left})
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

  Future _openShowModalBottomSheet(
      BuildContext context, ExhibitionHomeProvider provider) async {
    TextEditingController _controller = TextEditingController();

    final option = await showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        builder: (BuildContext context) {
          return SingleChildScrollView(
              child: Container(
                  padding: EdgeInsets.only(
                      bottom: MediaQuery.of(context).viewInsets.bottom),
                  child: Row(
                    children: <Widget>[
                      Container(
                        height: 100,
                        child: Center(
                          child: Padding(
                            padding: const EdgeInsets.only(left: 8),
                            child: TextField(
                              controller: _controller,
                              decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                    borderRadius: const BorderRadius.all(
                                      const Radius.circular(30.0),
                                    ),
                                  ),
                                  filled: true,
                                  hintStyle: TextStyle(color: Colors.grey[800]),
                                  hintText: "Type in your text",
                                  fillColor: Colors.white70),
                            ),
                          ),
                        ),
                        width: MediaQuery.of(context).size.width * 0.7,
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width * 0.3,
                        child: RaisedButton(
                          child: Icon(
                            Icons.send,
                            size: 25,
                          ),
                          shape: CircleBorder(),
                          onPressed: () async {
                            _controller.clear();
                            Message message = Message(
                                message: _controller.value.text,
                                time: Timestamp.now());
                            await _db.createMessage(provider.hall1Mac, message);
                          },
                        ),
                      )
                    ],
                  )));
        });
  }

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
                return Consumer<ExhibitionHomeProvider>(
                  builder: (BuildContext context,
                      ExhibitionHomeProvider provider, Widget child) {
                    return RaisedButton(
                      padding: EdgeInsets.all(0),
                      textColor: Colors.white,
                      color:
                      provider.isMAcSetHall1 ? Colors.green : Colors.grey,
                      child: Icon(Icons.wifi),
                      onPressed: provider.isMAcSetHall1
                          ? () async {
                        bool result =
                        await _db.deleteMac(provider.hall1Mac);
                        provider.macDeSetHall1();
                        final sn = SnackBar(
                            content: Text("MAC has been removed"),
                            action: SnackBarAction(
                              label: 'Okay',
                              onPressed: () async {},
                            ));
                        Scaffold.of(context).showSnackBar(sn);
                      }
                          : () async {
                        ConnectivityResult result =
                        await Connectivity().checkConnectivity();
                        if (result == ConnectivityResult.wifi) {
                          Connectivity()
                              .getWifiBSSID()
                              .then((value) async {
                            hall.mac = value;

                            bool result = await _db.adMac(value);
                            provider.setHall1Mac(value);
                            provider.macSetHall1();
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
                              content: Text(
                                  'Please Connect To a  WIFI Router'),
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
                );
              },
            ),
            Consumer<ExhibitionHomeProvider>(
              builder: (BuildContext context, ExhibitionHomeProvider value,
                  Widget child) {
                return RaisedButton(
                  textColor: Colors.white,
                  color: Colors.blue,
                  child: Icon(Icons.edit),
                  onPressed: value.isMAcSetHall1
                      ? () {
                    Navigator.pushNamed(context, '/hallDetails');
//                      print("Called");
                  }
                      : null,
                  shape: CircleBorder(),
                );
              },
            ),
            Consumer<ExhibitionHomeProvider>(
              builder: (BuildContext context, ExhibitionHomeProvider value,
                  Widget child) {
                return RaisedButton(
                  textColor: Colors.white,
                  color: Colors.blue,
                  child: Icon(Icons.send),
                  onPressed: value.isMAcSetHall1
                      ? () async {
                    await _openShowModalBottomSheet(context, value);
                  }
                      : null,
                  shape: CircleBorder(),
                );
              },
            ),
            Consumer<ExhibitionHomeProvider>(
              builder: (BuildContext context, ExhibitionHomeProvider value,
                  Widget child) {
                return Text("CROWD");
              },
            ),
          ],
        ),
      ),
    );
  }
}
