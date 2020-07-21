import 'dart:io';

import 'package:connectivity/connectivity.dart';
import 'package:exhibition_guide/services/db_service.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';

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
              bool _isPermissionGranted = Provider.of<bool>(context)??false;
              String mac=Provider.of<String>(context);
              print(mac);
              if (_isPermissionGranted) {
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
                            color: mac == "90:61:0c:52:b5:2f"
                                ? Colors.green
                                : Colors.grey,
                            child: Text("A"),
                            onPressed: () async {
//                              await _db.visitorVisited("90:61:0c:52:b5:2f");
//                                          Navigator.pushNamed(
//                                              context, '/stall');
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
                            color: mac == "7c:76:68:80:70:80"
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
                return Text("No permisison");
              }
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
