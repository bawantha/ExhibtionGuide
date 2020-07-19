import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class HallDetails extends StatefulWidget {
  @override
  _HallDetailsState createState() => _HallDetailsState();
}

class _HallDetailsState extends State<HallDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Hall A"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(left: 10, right: 10),
              child: CarouselSlider(
                options: CarouselOptions(
                    height: MediaQuery.of(context).size.width * 0.8),
                items: [
                  1,
                  2,
                  3,
                ].map((i) {
                  return Builder(
                    builder: (BuildContext context) {
                      return Card(
                        child: Container(
                            width: MediaQuery.of(context).size.width,
                            margin: EdgeInsets.symmetric(horizontal: 5.0),
                            child: Center(
                              child: MaterialButton(
                                onPressed: () {},
                                color: Colors.blue,
                                textColor: Colors.white,
                                child: Icon(
                                  Icons.add,
                                  size: 24,
                                ),
                                padding: EdgeInsets.all(16),
                                shape: CircleBorder(),
                              ),
                            )),
                      );
                    },
                  );
                }).toList(),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10, right: 10),
              child: TextFormField(
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: "Tell about exhibition hall",
                    labelText: "Hall Description"),
                maxLines: 4,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            RaisedButton(
              onPressed: () {},
              child: Text("Add"),
            )
          ],
        ),
      ),
    );
  }
}
