import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../constant.dart';

class SHHomeScreen extends StatefulWidget {
  const SHHomeScreen({Key? key}) : super(key: key);

  @override
  _SHHomeScreenState createState() => _SHHomeScreenState();
}

class _SHHomeScreenState extends State<SHHomeScreen> {
  final now = DateTime.now();
  var selected;
  int currentIndex = 0;

  var calender = [];
  final style = TextStyle(
    fontWeight: FontWeight.w500,
    letterSpacing: 2.0,
    fontSize: 10.0,
    fontFamily: 'Kameron',
  );
  final styleBold = TextStyle(
    fontWeight: FontWeight.w500,
    letterSpacing: 2.0,
    fontSize: 10.0,
    fontFamily: 'Kameron',
  );

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    selected = now;
    calender = [
      DateTime(now.year, now.month, now.day - 3),
      DateTime(now.year, now.month, now.day - 2),
      DateTime(now.year, now.month, now.day - 1),
      now,
      DateTime(now.year, now.month, now.day + 1),
      DateTime(now.year, now.month, now.day + 2),
      DateTime(now.year, now.month, now.day + 3),
      DateTime(now.year, now.month, now.day + 4),
      DateTime(now.year, now.month, now.day + 5),
      DateTime(now.year, now.month, now.day + 6),
      DateTime(now.year, now.month, now.day + 7),
    ];
  }

  setBottomBarIndex(index) {
    setState(() {
      currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Color(0xffF5F6FD),
      body: SafeArea(
        child: Stack(
          children: [
            SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.all(10.0),
                    margin: EdgeInsets.only(left: 10.0),
                    height: 100,
                    child: Row(
                      children: [
                        Container(child: circleavatar),
                        Container(
                          margin: EdgeInsets.all(10.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Hello there,",
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.grey.shade600,
                                ),
                              ),
                              Text(
                                "arjun".toUpperCase(),
                                style: TextStyle(
                                  color: Color(0xff2C364E),
                                  fontSize: 19,
                                  fontWeight: FontWeight.w900,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 5.0, bottom: 20.0, left: 20),
                    padding: EdgeInsets.symmetric(vertical: 1.0),
                    height: 100,
                    child: new ListView.builder(
                      itemBuilder: (context, index) {
                        return selected != calender[index]
                            ? InkWell(
                                onTap: () {
                                  setState(() {
                                    selected = calender[index];
                                  });
                                },
                                child: Container(
                                  padding: EdgeInsets.symmetric(horizontal: 8),
                                  margin: EdgeInsets.symmetric(
                                      horizontal: 5.5, vertical: 2),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Container(
                                        width: 40.0,
                                        child: Text(
                                          DateFormat('E')
                                              .format(calender[index])
                                              .toString(),
                                          style: TextStyle(
                                            color: Color(0xffa6a5ba),
                                            fontSize: 16,
                                            // fontWeight: FontWeight.w900,
                                          ),
                                        ),
                                        alignment: Alignment.center,
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Container(
                                        width: 40.0,
                                        child: Text(
                                          DateFormat('d')
                                              .format(calender[index])
                                              .toString(),
                                          style: TextStyle(
                                            color: Color(0xff2C364E),
                                            fontSize: 19,
                                            fontWeight: FontWeight.w900,
                                          ),
                                        ),
                                        alignment: Alignment.center,
                                      ),
                                    ],
                                  ),
                                ),
                              )
                            : Container(
                                padding: EdgeInsets.symmetric(horizontal: 8),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(40),
                                  color: Color(0xff6E7FFC),
                                ),
                                margin: EdgeInsets.symmetric(
                                    horizontal: 5.5, vertical: 2),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Container(
                                      width: 40.0,
                                      child: Text(
                                        DateFormat('E')
                                            .format(calender[index])
                                            .toString(),
                                        style: TextStyle(
                                          color: Colors.grey.shade100,
                                          fontSize: 16,
                                          // fontWeight: FontWeight.w900,
                                        ),
                                      ),
                                      alignment: Alignment.center,
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Container(
                                      width: 40.0,
                                      child: Text(
                                        DateFormat('d')
                                            .format(calender[index])
                                            .toString(),
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 19,
                                          fontWeight: FontWeight.w900,
                                        ),
                                      ),
                                      alignment: Alignment.center,
                                    ),
                                  ],
                                ),
                              );
                      },
                      scrollDirection: Axis.horizontal,
                      itemCount: calender.length,
                    ),
                  ),
                  Container(
                      padding: EdgeInsets.all(10.0),
                      margin: EdgeInsets.only(left: 20.0, right: 20.0),
                      height: MediaQuery.of(context).size.height * 0.13,
                      width: MediaQuery.of(context).size.width * 1,
                      decoration: BoxDecoration(
                        color: Colors.lightBlueAccent,
                        borderRadius: BorderRadius.circular(25.0),
                      ),
                      child: Row(
                        children: [
                          Container(
                            child: circleavatar,
                          ),
                          Container(
                            margin: EdgeInsets.all(10.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Text(
                                  "you have got two task                       "
                                      .toUpperCase(),
                                ),
                                Text(
                                  "check your task for today".toUpperCase(),
                                  style: styleBold,
                                ),
                              ],
                            ),
                          ),
                        ],
                      )),
                  Container(
                    margin: EdgeInsets.only(top: 20.0, bottom: 20.0),
                    child: ListView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        return new Container(
                          width: 50.0,
                          height: 110.0,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30.0),
                            color: Colors.indigo,
                          ),
                          margin: EdgeInsets.only(
                              top: 5.0, bottom: 5.0, right: 15.0, left: 15.0),
                          child: new Container(
                            width: 40.0,
                            height: 100.0,
                            child: Text('Hello'),
                            alignment: Alignment.center,
                          ),
                        );
                      },
                      scrollDirection: Axis.vertical,
                      itemCount: 15,
                    ),
                  ),
                ],
              ),
            ),
            Positioned(
              bottom: 0,
              left: 0,
              child: Container(
                width: size.width,
                height: 80,
                child: Stack(
                  clipBehavior: Clip.none,
                  children: [
                    CustomPaint(
                      size: Size(size.width, 80),
                      painter: BNBCustomPainter(),
                    ),
                    Center(
                      heightFactor: 0.6,
                      child: FloatingActionButton(
                          backgroundColor: Colors.orange,
                          child: Icon(Icons.shopping_basket),
                          elevation: 0.1,
                          onPressed: () {}),
                    ),
                    Container(
                      width: size.width,
                      height: 80,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          IconButton(
                            icon: Icon(
                              Icons.home,
                              color: currentIndex == 0
                                  ? Colors.orange
                                  : Colors.grey.shade400,
                            ),
                            onPressed: () {
                              setBottomBarIndex(0);
                            },
                            splashColor: Colors.white,
                          ),
                          IconButton(
                              icon: Icon(
                                Icons.restaurant_menu,
                                color: currentIndex == 1
                                    ? Colors.orange
                                    : Colors.grey.shade400,
                              ),
                              onPressed: () {
                                setBottomBarIndex(1);
                              }),
                          Container(
                            width: size.width * 0.20,
                          ),
                          IconButton(
                              icon: Icon(
                                Icons.bookmark,
                                color: currentIndex == 2
                                    ? Colors.orange
                                    : Colors.grey.shade400,
                              ),
                              onPressed: () {
                                setBottomBarIndex(2);
                              }),
                          IconButton(
                              icon: Icon(
                                Icons.notifications,
                                color: currentIndex == 3
                                    ? Colors.orange
                                    : Colors.grey.shade400,
                              ),
                              onPressed: () {
                                setBottomBarIndex(3);
                              }),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class BNBCustomPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = new Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill;

    Path path = Path();
    path.moveTo(0, 20); // Start
    path.quadraticBezierTo(size.width * 0.20, 0, size.width * 0.35, 0);
    path.quadraticBezierTo(size.width * 0.40, 0, size.width * 0.40, 20);
    path.arcToPoint(Offset(size.width * 0.60, 20),
        radius: Radius.circular(20.0), clockwise: false);
    path.quadraticBezierTo(size.width * 0.60, 0, size.width * 0.65, 0);
    path.quadraticBezierTo(size.width * 0.80, 0, size.width, 20);
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    path.lineTo(0, 20);
    canvas.drawShadow(path, Colors.black, 5, true);
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}
