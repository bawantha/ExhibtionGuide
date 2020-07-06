import 'package:carousel_pro/carousel_pro.dart';
import 'package:flutter/material.dart';

class StallDescription extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Hall A"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Stack(
              children: <Widget>[
                Container(
                  height: 300,
                  width: double.infinity,
                  child: SizedBox(
                    height: 150.0,
                    width: 300.0,
                    child: Carousel(
                      boxFit: BoxFit.cover,
                      autoplay: false,
                      animationCurve: Curves.fastOutSlowIn,
                      animationDuration: Duration(milliseconds: 1000),
                      dotSize: 6.0,
                      dotIncreasedColor: Color(0xFFFF335C),
                      dotBgColor: Colors.transparent,
                      dotPosition: DotPosition.bottomCenter,
                      dotVerticalPadding: 10.0,
                      showIndicator: true,
                      indicatorBgPadding: 7.0,
                      images: [
                        NetworkImage(
                            'https://www.oneelephant.lk/wp-content/uploads/2017/02/LED-Video-screen-at-Novo-Nordisk-Exhibition-Stall.jpg'),
                        NetworkImage(
                            'https://static.wixstatic.com/media/5800b8_4eafbd0ff3304136bcb77958fb6937e0~mv2.jpg'),
                        NetworkImage(
                            'https://miro.medium.com/max/700/1*kxW4CK-YcvPpDAcdc9DU6w.jpeg'),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding:
                  const EdgeInsets.only(left: 16.0, right: 16.0, bottom: 16.0),
              child: Text('Bawa'),
            ),
          ],
        ),
      ),
    );
  }
}
