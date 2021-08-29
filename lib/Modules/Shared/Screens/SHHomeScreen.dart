import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:loading_overlay/loading_overlay.dart';
import "package:sp_app/Helpers/Capitalize.dart";
import 'package:sp_app/Modules/Shared/Widgets/BottomNavigationBar.dart';
import 'package:sp_app/Modules/Staff/Widgets/Neumorphic_Chart/pie_chart_view.dart';

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
  bool _isLoading = false;

  var data = [
    {
      "creatorName": "Shankar",
      "creatorId": "Shankar",
      "question": [],
      "title": "Nptel form",
      "unCompleted": [
        {
          "name": "bala",
        },
        {
          "name": "bala",
        },
      ],
      "completed": [
        {
          "name": "bala",
        },
        {
          "name": "bala",
        },
      ],
      "lastDate": DateTime.now(),
      "class": "IIICSEA",
    },
    {
      "creatorName": "Shankar",
      "creatorId": "Shankar",
      "question": [],
      "title": "Feedback form",
      "unCompleted": [
        {
          "name": "bala",
        },
        {
          "name": "bala",
        },
        {
          "name": "bala",
        },
        {
          "name": "bala",
        },
        {
          "name": "bala",
        },
      ],
      "completed": [
        {
          "name": "bala",
        },
        {
          "name": "bala",
        },
      ],
      "lastDate": DateTime.now(),
      "class": "IIICSEA",
    },
  ];
  var calender = [];

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
    return Scaffold(
      // backgroundColor: Color.fromRGBO(193, 214, 233, 1),
      backgroundColor: Colors.white,
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.indigoAccent,
        onPressed: () {
          setState(() => (_isLoading == true)
              ? (_isLoading = false)
              : (_isLoading = true));
        },
        child: _isLoading
            ? Icon(
                Icons.cancel_outlined,
                color: Colors.white,
              )
            : Icon(
                Icons.add,
                color: Colors.white,
              ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(20.0),
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomNavBar(0),
      body: LoadingOverlay(
        progressIndicator: Align(
          alignment: Alignment.bottomCenter,
          heightFactor: 12,
          child: AnimationLimiter(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: AnimationConfiguration.toStaggeredList(
                duration: const Duration(milliseconds: 375),
                childAnimationBuilder: (widget) => SlideAnimation(
                  horizontalOffset: 50.0,
                  child: FadeInAnimation(
                    child: widget,
                  ),
                ),
                children: [
                  Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15.0),
                          ),
                          color: Colors.lightBlue,
                          elevation: 10,
                          child: MaterialButton(
                            onPressed: () {},
                            child: Container(
                              width: MediaQuery.of(context).size.width * .2,
                              child: Text(
                                " Quiz ",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                        ),
                        Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15.0),
                          ),
                          color: Colors.lightBlue,
                          elevation: 10,
                          child: MaterialButton(
                            onPressed: () {},
                            child: Container(
                              width: MediaQuery.of(context).size.width * .2,
                              child: Text(
                                " Form ",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                        ),
                        Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15.0),
                          ),
                          color: Colors.lightBlue,
                          elevation: 10,
                          child: MaterialButton(
                            onPressed: () {},
                            child: Container(
                              width: MediaQuery.of(context).size.width * .23,
                              child: Text(
                                " Acknowledge ",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        isLoading: _isLoading,
        child: SafeArea(
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
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 8),
                                    margin: EdgeInsets.symmetric(
                                        horizontal: 5.5, vertical: 2),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
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
                        gradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [Color(0xff6E7FFC), Colors.lightBlueAccent],
                        ),
                      ),
                      child: Row(
                        children: [
                          Container(
                            width: MediaQuery.of(context).size.width * .1,
                            child: Icon(
                              Icons.task_alt,
                              size: MediaQuery.of(context).size.width * .08,
                              color: Colors.white,
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.all(10.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "You have got 2 task",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 19,
                                    color: Colors.white,
                                  ),
                                ),
                                Text(
                                  "Check your task for today".toUpperCase(),
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 20.0, bottom: 20.0),
                      child: AnimationLimiter(
                        child: ListView.builder(
                          physics: NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemBuilder: (context, index) {
                            return AnimationConfiguration.staggeredList(
                              position: index,
                              duration: const Duration(milliseconds: 375),
                              child: SlideAnimation(
                                verticalOffset: 50.0,
                                child: FadeInAnimation(
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: new Container(
                                      decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(30.0),
                                      ),
                                      height: 150,
                                      padding: const EdgeInsets.all(8.0),
                                      child: Neumorphic(
                                        style: NeumorphicStyle(
                                          shape: NeumorphicShape.flat,
                                          // depth: 20, //customize depth here
                                          color: Colors.white,
                                          border: NeumorphicBorder(
                                            color: Color.fromRGBO(
                                                193, 214, 233, 1),
                                            width: 0.8,
                                          ),
                                        ),
                                        child: new Container(
                                          width: 40.0,
                                          height: 100.0,
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Container(
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    .5,
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                    top: 8.0,
                                                    left: 24,
                                                  ),
                                                  child: Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Text(
                                                        data[index]['title']!
                                                            .toString()
                                                            .capitalizeFirstofEach,
                                                        style: TextStyle(
                                                          fontSize: 26,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          color: Colors.brown,
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        height: 10,
                                                      ),
                                                      Text(
                                                        data[index]['class']!
                                                            .toString(),
                                                        style: TextStyle(
                                                          fontSize: 20,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          color: Colors.grey,
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        height: 10,
                                                      ),
                                                      Text(
                                                        DateFormat.yMMMMd()
                                                            .format(data[index]
                                                                    ['lastDate']
                                                                as DateTime)
                                                            .toString()
                                                            .toString(),
                                                        style: TextStyle(
                                                          fontSize: 15,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          color: Colors.grey,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                              SizedBox(
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    .05,
                                              ),
                                              PieChartView(data[index]),
                                            ],
                                          ),
                                          alignment: Alignment.center,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            );
                          },
                          scrollDirection: Axis.vertical,
                          itemCount: data.length,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
