import 'package:exhibition_guide/models/exhibiton_model.dart';
import 'package:exhibition_guide/services/db_service.dart';
import 'package:flutter/material.dart';

class OrganizerHome extends StatelessWidget {
  final EGDbService _dbService = EGDbService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Exhibition Guide"),
      ),
      body: StreamBuilder<List<ExhibitionModel>>(
        builder: (BuildContext context,
            AsyncSnapshot<List<ExhibitionModel>> snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data.length > 0) {
              return ListView.builder(
                  itemCount: snapshot.data.length,
                  itemBuilder: (contex, index) {
                    return GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, '/exhibitionHome');

                      },
                      child: Card(
                          child: Container(
                              width: MediaQuery.of(context).size.width,
                              height: MediaQuery.of(context).size.height * 0.2,
                              child: Center(
                                  child: Text(snapshot.data[index].name)))),
                    );
                  });
            } else {
              return Center(
                child: Container(
                  width: 300,
                  height: 100,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.grey,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                        "You haven't created any exhibition   start creating by pressing + icons"),
                  ),
                ),
              );
            }
          } else {
            return Text("Loading");
          }
        },
        stream: _dbService.getExhibtions("user"),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          _dbService.createExhibition("Book Exhibition");
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
