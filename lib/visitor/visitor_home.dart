import 'dart:io';

import 'package:connectivity/connectivity.dart';
import 'package:exhibition_guide/services/db_service.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

class VisitorHome extends StatefulWidget {
  @override
  _VisitorHomeState createState() => _VisitorHomeState();
}

class _VisitorHomeState extends State<VisitorHome> {
  EGDbService _db = EGDbService();

  @override
  Future<void> initState() {
    permissionGet();
    super.initState();
  }

  Future<String> getWIFIBsd() async {
    return await Connectivity().getWifiBSSID();
  }

  Stream<String> getStremWIFIBSD() async* {
    while (true) {
      String result = await Connectivity().getWifiBSSID();
      yield result;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("ABC Exhibition"),
        actions: <Widget>[
          Icon(Icons.notifications),
        ],
      ),
      body: StreamBuilder<ConnectivityResult>(
        stream: Connectivity().onConnectivityChanged,
        builder:
            (BuildContext context, AsyncSnapshot<ConnectivityResult> snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data == ConnectivityResult.wifi) {
              return FutureBuilder<bool>(
                builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
                  if (snapshot.data) {
                    return StreamBuilder<String>(
                      builder: (BuildContext context,
                          AsyncSnapshot<String> macdata) {
                        if (macdata.hasData) {
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
                                      color: macdata.data == "7c:76:68:80:70:80"
                                          ? Colors.green
                                          : Colors.grey,
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
                                      color: macdata.data == "90:61:0c:52:b5:2f"
                                          ? Colors.green
                                          : Colors.grey,
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
                        } else {
                          return Text("no data");
                        }
                      },
                      stream: getStremWIFIBSD(),
                    );
                  } else {
                    return Text("NO PERMISSION ALLOWD");
                  }
                },
                future: Permission.locationAlways.isGranted,
              );
            } else {
              return Text("Connect Free WIFI");
            }
          } else {
            print("Connect to free wifi");
            return Text("Connect to Fe WIFI");
          }
        },
      ),
    );
  }

  void permissionGet() async {
    if (Platform.isAndroid) {
      print('Checking Android permissions');
      var status = await Permission.location.status;
      // Blocked?
      if (status.isUndetermined || status.isDenied || status.isRestricted) {
        // Ask the user to unblock
        if (await Permission.location.request().isGranted) {
          // Either the permission was already granted before or the user just granted it.
          print('Location permission granted');
        } else {
          print('Location permission not granted');
        }
      } else {
        print('Permission already granted (previous execution?)');
      }
    }
  }
}
