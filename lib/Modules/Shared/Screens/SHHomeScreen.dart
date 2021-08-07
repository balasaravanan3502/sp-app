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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffF5F6FD),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Container(
                padding: EdgeInsets.all(10.0),
                margin: EdgeInsets.only(left: 10.0),
                height: MediaQuery.of(context).size.height * 0.13,
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
                margin: EdgeInsets.only(top: 5.0, bottom: 20.0),
                padding: EdgeInsets.symmetric(vertical: 1.0),
                height: MediaQuery.of(context).size.height * 0.12,
                child: new ListView.builder(
                  itemBuilder: (context, index) {
                    return selected != calender[index]
                        ? GestureDetector(
                            onTap: () {
                              setState(() {
                                selected = calender[index];
                              });
                            },
                            child: Container(
                              padding: EdgeInsets.all(5),
                              margin: EdgeInsets.symmetric(
                                  horizontal: 9.0, vertical: 2),
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
                            padding: EdgeInsets.all(5),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(40),
                              color: Color(0xff6E7FFC),
                            ),
                            margin: EdgeInsets.symmetric(
                                horizontal: 9.0, vertical: 2),
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
      ),
    );
  }
}
