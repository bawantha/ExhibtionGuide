import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:exhibition_guide/models/message.dart';
import 'package:exhibition_guide/services/db_service.dart';
import 'package:exhibition_guide/services/wifi_service.dart';
import 'package:flutter/material.dart';

class VisitorNotifications extends StatefulWidget {
  @override
  _VisitorNotificationsState createState() => _VisitorNotificationsState();
}

class _VisitorNotificationsState extends State<VisitorNotifications> {
  final EGDbService egDbService = EGDbService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<String>(
        builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
          if (snapshot.hasData) {
            return StreamBuilder<List<Message>>(
              initialData: [Message(message: "Initial", time: Timestamp.now())],
              stream: egDbService.getMessages(snapshot.data),
              builder: (BuildContext context,
                  AsyncSnapshot<List<Message>> messageList) {
                if (snapshot.hasData) {
                  return SingleChildScrollView(
                    child: Column(
                      children: <Widget>[
                        ListView.builder(
                          shrinkWrap: true,
                          itemCount: messageList.data.length,
                          itemBuilder: (BuildContext context, int index) {
                            return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                  decoration: BoxDecoration(
                                      color: Colors.grey,
                                      borderRadius: BorderRadius.circular(25)),
                                  width:
                                      MediaQuery.of(context).size.width * 0.8,
                                  height: 100,
                                  child: Center(
                                      child: Text(
                                    messageList.data[index].message,
                                    style: TextStyle(color: Colors.white),
                                  ))),
                            );
                          },
                        ),
                      ],
                    ),
                  );
                } else {
                  return Center(child: Text("No notifications yet000"));
                }
              },
            );
          } else {
            return Center(
              child: Text("You Haven't Connected to WIFI"),
            );
          }
        },
        stream: getStremWIFIBSD(),
      ),
    );
  }
}
