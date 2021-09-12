import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import "package:sp_app/Helpers/Capitalize.dart";
import 'package:sp_app/Modules/Shared/Screens/SubjectListScreen.dart';
import 'package:sp_app/Modules/Staff/Screens/STFormStatus.dart';
import 'package:sp_app/Modules/Staff/Widgets/Neumorphic_Chart/pie_chart_view.dart';
import 'package:sp_app/Modules/Students/Screens/STSubmitFromScreen.dart';
import 'package:sp_app/Provider/Data.dart';

import '../../../constant.dart';
import 'DownloadsScreen.dart';
import 'SHCreateFormScreen.dart';

class SHHomeScreen extends StatefulWidget {
  final name;
  SHHomeScreen(this.name);

  @override
  _SHHomeScreenState createState() => _SHHomeScreenState();
}

class _SHHomeScreenState extends State<SHHomeScreen> {
  final now = DateTime.now();
  var selected;
  var icons = [
    Icons.home,
    Icons.label,
    Icons.my_library_books,
    Icons.cloud_download_sharp,
  ];
  int currentIndex = 0;
  bool _isLoading = false;

  var data = [
    // {
    //   "creatorName": "Shankar",
    //   "creatorId": "Shankar",
    //   "questions": [
    //     {
    //       "id": 0,
    //       "question": "What is your department?",
    //     },
    //     {
    //       "id": 0,
    //       "question": "What is your department?",
    //     },
    //     {
    //       "id": 0,
    //       "question": "What is your department?",
    //     },
    //   ],
    //   "title": "Nptel form",
    //   "unCompleted": [
    //     {
    //       "name": "bala",
    //     },
    //     {
    //       "name": "bala",
    //     },
    //     {
    //       "name": "bala",
    //     },
    //     {
    //       "name": "bala",
    //     },
    //   ],
    //   "completed": [
    //     {
    //       "name": "bala",
    //       "response": [
    //         {"id": 0, "answer": "ECE"},
    //         {"id": 1, "answer": "ECE"},
    //         {"id": 2, "answer": "ECE"},
    //       ]
    //     },
    //     {
    //       "name": "bala",
    //       "response": [
    //         {"id": 0, "answer": "ECE"},
    //         {"id": 1, "answer": "ECE"},
    //         {"id": 2, "answer": "ECE"},
    //       ]
    //     },
    //   ],
    //   "lastDate": DateTime.now(),
    //   "class": "IIICSEA",
    // },
    // {
    //   "creatorName": "Shankar",
    //   "creatorId": "Shankar",
    //   "question": [],
    //   "title": "Feedback form",
    //   "unCompleted": [
    //     {
    //       "name": "bala",
    //     },
    //     {
    //       "name": "bala",
    //     },
    //     {
    //       "name": "bala",
    //     },
    //     {
    //       "name": "bala",
    //     },
    //     {
    //       "name": "bala",
    //     },
    //   ],
    //   "completed": [
    //     {
    //       "name": "bala",
    //     },
    //     {
    //       "name": "bala",
    //     },
    //   ],
    //   "lastDate": DateTime.now(),
    //   "class": "IIICSEA",
    // },
    // {
    //   "creatorName": "Shankar",
    //   "creatorId": "Shankar",
    //   "question": [],
    //   "title": "Feedback form",
    //   "unCompleted": [
    //     {
    //       "name": "bala",
    //     },
    //     {
    //       "name": "bala",
    //     },
    //     {
    //       "name": "bala",
    //     },
    //     {
    //       "name": "bala",
    //     },
    //     {
    //       "name": "bala",
    //     },
    //   ],
    //   "completed": [
    //     {
    //       "name": "bala",
    //     },
    //     {
    //       "name": "bala",
    //     },
    //   ],
    //   "lastDate": DateTime.now(),
    //   "class": "IIICSEA",
    // },
    // {
    //   "creatorName": "Shankar",
    //   "creatorId": "Shankar",
    //   "question": [],
    //   "title": "Feedback form",
    //   "unCompleted": [
    //     {
    //       "name": "bala",
    //     },
    //     {
    //       "name": "bala",
    //     },
    //     {
    //       "name": "bala",
    //     },
    //     {
    //       "name": "bala",
    //     },
    //     {
    //       "name": "bala",
    //     },
    //   ],
    //   "completed": [
    //     {
    //       "name": "bala",
    //     },
    //     {
    //       "name": "bala",
    //     },
    //   ],
    //   "lastDate": DateTime.now(),
    //   "class": "IIICSEA",
    // },
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
      bottomNavigationBar: AnimatedBottomNavigationBar(
        elevation: 20,
        onTap: (index) {
          if (index == currentIndex)
            return;
          else {
            setState(() {
              currentIndex = index;
            });
          }
        },
        activeIndex: currentIndex,
        icons: icons,
        backgroundColor: Colors.white,
        inactiveColor: Colors.indigo,
        activeColor: Colors.lightBlue,
        height: 60,
        gapLocation: GapLocation.center,
        notchSmoothness: NotchSmoothness.verySmoothEdge,
      ),
      body: LoadingOverlay(
        color: Colors.black,
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
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      SHCreateFormScreen('quiz'),
                                ),
                              );
                            },
                            child: Container(
                              width: MediaQuery.of(context).size.width * .2,
                              child: Text(
                                "Quiz",
                                style: TextStyle(
                                  fontSize: 13,
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
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      SHCreateFormScreen('form'),
                                ),
                              );
                            },
                            child: Container(
                              width: MediaQuery.of(context).size.width * .2,
                              child: Text(
                                "Form",
                                style: TextStyle(
                                  fontSize: 13,
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
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      SHCreateFormScreen('ack'),
                                ),
                              );
                            },
                            child: Container(
                              width: MediaQuery.of(context).size.width * .23,
                              child: Text(
                                "Acknowledge",
                                style: TextStyle(
                                  fontSize: 13,
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
          child: currentIndex == 0
              ? HomeScreen()
              : currentIndex == 1
                  ? SubjectListScreen()
                  : currentIndex == 2
                      ? SubjectListScreen()
                      : DownloadsScreen(),
        ),
      ),
    );
  }

  Widget HomeScreen() {
    return Stack(
      children: [
        SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Container(
                height: 100,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      margin: EdgeInsets.all(15.0),
                      child: Row(
                        children: [
                          Container(child: circleavatar),
                          Column(
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
                                widget.name.toUpperCase() ?? '',
                                style: TextStyle(
                                  color: Color(0xff2C364E),
                                  fontSize: 19,
                                  fontWeight: FontWeight.w900,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15.0),
                      child: IconButton(
                        onPressed: () {},
                        icon: Icon(
                          Icons.settings,
                          color: Colors.indigoAccent,
                        ),
                      ),
                    )
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
                height: MediaQuery.of(context).size.height * 0.14,
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
                      width: MediaQuery.of(context).size.width * .11,
                      child: Icon(
                        Icons.task_alt,
                        size: MediaQuery.of(context).size.width * .08,
                        color: Colors.white,
                      ),
                    ),
                    Consumer<Data>(builder: (context, tripsProvider, child) {
                      data = tripsProvider.data;
                      return Container(
                        margin: EdgeInsets.all(10.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "You have got ${data.length} task",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 19,
                                color: Colors.white,
                              ),
                            ),
                            SizedBox(
                              height: 4,
                            ),
                            Container(
                              width: MediaQuery.of(context).size.width * .66,
                              child: Text(
                                "Check your task status for today"
                                    .toUpperCase(),
                                style: TextStyle(
                                  fontSize: 15,
                                  color: Colors.white,
                                ),
                                maxLines: 2,
                              ),
                            ),
                          ],
                        ),
                      );
                    }),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 20.0, bottom: 20.0),
                child: Consumer<Data>(builder: (context, tripsProvider, child) {
                  data = tripsProvider.data;
                  print(data);
                  return AnimationLimiter(
                    child: ListView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        return InkWell(
                          onTap: () async {
                            final SharedPreferences sharedpref =
                                await SharedPreferences.getInstance();

                            if (sharedpref.getString('role') == 'staff')
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      STFormStatus(data[index]),
                                ),
                              );
                            if (sharedpref.getString('role') == 'student')
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      STSubmitFormScreen(data[index]),
                                ),
                              );
                          },
                          child: AnimationConfiguration.staggeredList(
                            position: index,
                            duration: const Duration(milliseconds: 375),
                            child: SlideAnimation(
                              verticalOffset: 50.0,
                              child: FadeInAnimation(
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: new Container(
                                    height: 150,
                                    padding: const EdgeInsets.all(8.0),
                                    child: Neumorphic(
                                      style: NeumorphicStyle(
                                        shape: NeumorphicShape.flat,
                                        // depth: 20, //customize depth here
                                        color: Colors.white,
                                        border: NeumorphicBorder(
                                          color:
                                              Color.fromRGBO(193, 214, 233, 1),
                                          width: 0.8,
                                        ),
                                      ),
                                      child: new Container(
                                        width: 40.0,
                                        height: 100.0,
                                        decoration: BoxDecoration(
                                          border: Border(
                                            left: BorderSide(
                                              color:
                                                  data[index]['type'] == 'form'
                                                      ? Colors.green
                                                      : data[index]['type'] !=
                                                              'quiz'
                                                          ? Colors.red
                                                          : Colors.blue,
                                              width: 5,
                                            ),
                                          ),
                                        ),
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
                                                padding: const EdgeInsets.only(
                                                  top: 8.0,
                                                  left: 24,
                                                ),
                                                child: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      data[index]['title']!
                                                          .toString()
                                                          .capitalizeFirstofEach,
                                                      style: TextStyle(
                                                        fontSize: 24,
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
                                                        fontSize: 18,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: Colors.grey,
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      height: 10,
                                                    ),
                                                    Text(
                                                      data[index]['lastDate'],
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
                          ),
                        );
                      },
                      scrollDirection: Axis.vertical,
                      itemCount: data.length,
                    ),
                  );
                }),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
