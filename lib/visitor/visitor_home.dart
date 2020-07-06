import 'dart:io';

import 'package:connectivity/connectivity.dart';
import 'package:exhibition_guide/exhibition_map.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

class VisitorHome extends StatefulWidget {
  @override
  _VisitorHomeState createState() => _VisitorHomeState();
}

class _VisitorHomeState extends State<VisitorHome> {
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
      body: Stack(
        children: <Widget>[
          ExhibitionMap(),
          StreamBuilder<ConnectivityResult>(
            builder: (BuildContext context,
                AsyncSnapshot<ConnectivityResult> snapshot) {
              if (snapshot.hasData) {
                //Permission.locationAlways.request().isGranted
                return Center(
                  child: Column(
                    children: <Widget>[
                      snapshot.data == ConnectivityResult.wifi
                          ? FutureBuilder<bool>(
                              builder: (BuildContext context,
                                  AsyncSnapshot<bool> snapshot) {
                                if (snapshot.hasData) {
                                  return Column(
                                    children: <Widget>[
                                      FutureBuilder<String>(
                                        builder: (BuildContext context,
                                            AsyncSnapshot<String> snapshot) {
                                          if (snapshot.hasData) {
                                            return Text(snapshot.data);
                                          } else {
                                            return Text("No DATA");
                                          }
                                        },
                                        future: Connectivity().getWifiBSSID(),
                                      ),
                                      FutureBuilder<String>(
                                        builder: (BuildContext context,
                                            AsyncSnapshot<String> snapshot) {
                                          if (snapshot.hasData) {
                                            return Text(snapshot.data);
                                          } else {
                                            return Text("No DATA");
                                          }
                                        },
                                        future: Connectivity().getWifiName(),
                                      )
                                    ],
                                  );
                                } else {
                                  return Container();
                                }
                              },
                              future: Permission.locationAlways.isGranted)
                          : Text("Connect to WIFI")
                    ],
                  ),
                );
              } else {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
            },
            stream: Connectivity().onConnectivityChanged,
          ),
        ],
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
