import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sp_app/Modules/Shared/Screens/SHHomeScreen.dart';
import 'package:sp_app/Provider/Data.dart';

import '../../../../constant.dart';

class QuizScreen extends StatefulWidget {
  final data;
  QuizScreen(this.data);
  @override
  _QuizScreenState createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  int _counter = 10;
  var _timer;
  var questions;
  var correctOptions;
  var options;
  int currentIndex = 0;
  int score = 0;
  var option = {
    '0': 'A',
    '1': 'B',
    '2': 'C',
    '3': 'D',
  };

  void _startTimer() {
    _counter = 10;
    if (_timer != null) {
      _timer.cancel();
    }
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        if (_counter > 0) {
          _counter--;
        } else {
          _timer.cancel();
          setState(() {
            currentIndex++;
          });
          if (currentIndex == questions.length) _submitted();
        }
      });
    });
  }

  var selectedOptions = [];

  Future<void> _submitted() async {
    final provider = Provider.of<Data>(context, listen: false);
    final SharedPreferences sharedpref = await SharedPreferences.getInstance();
    var result = await provider.completeWork({
      "workID": widget.data["_id"],
      "studentID": sharedpref.getString('id'),
      "studentName": sharedpref.getString('name'),
      "score": '$score'
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    questions = widget.data['questions'];
    correctOptions = widget.data['correctOptions'];
    options = widget.data['options'];
    _startTimer();
  }

  @override
  Widget build(BuildContext context) {
    print(widget.data);
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: Color(0xff2C364E),
      appBar: AppBar(
        // Fluttter show the back button automatically
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Stack(
        children: [
          SafeArea(
            child: currentIndex < questions.length
                ? Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: kDefaultPadding),
                        child: Container(
                          width: double.infinity,
                          height: 35,
                          decoration: BoxDecoration(
                            border:
                                Border.all(color: Color(0xFF3F4768), width: 3),
                            borderRadius: BorderRadius.circular(50),
                          ),
                          child: Stack(
                            children: [
                              // LayoutBuilder provide us the available space for the conatiner
                              // constraints.maxWidth needed for our animation
                              LayoutBuilder(
                                builder: (context, constraints) => Container(
                                  // from 0 to 1 it takes 60s
                                  width: constraints.maxWidth,
                                  decoration: BoxDecoration(
                                    gradient: kPrimaryGradient,
                                    borderRadius: BorderRadius.circular(50),
                                  ),
                                ),
                              ),
                              Positioned.fill(
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: kDefaultPadding / 2),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        "${_counter} sec",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: kDefaultPadding),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: kDefaultPadding),
                        child: Text(
                          'Question ${currentIndex + 1} / ${questions.length}',
                          style: Theme.of(context)
                              .textTheme
                              .headline4!
                              .copyWith(color: kSecondaryColor),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15.0),
                        child: Divider(thickness: 1.5),
                      ),
                      SizedBox(height: kDefaultPadding),
                      Expanded(
                        child: PageView.builder(
                          // Block swipe to next qn
                          physics: NeverScrollableScrollPhysics(),

                          itemBuilder: (context, index) => Container(
                            // margin: EdgeInsets.symmetric(horizontal: kDefaultPadding),
                            padding: EdgeInsets.all(kDefaultPadding),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(25),
                            ),
                            child: Column(
                              children: [
                                Text(
                                  questions[currentIndex]['question'],
                                  style: Theme.of(context)
                                      .textTheme
                                      .headline6!
                                      .copyWith(color: kBlackColor),
                                ),
                                SizedBox(height: kDefaultPadding / 2),
                                ...List.generate(
                                  4,
                                  (index) => InkWell(
                                    onTap: () {
                                      selectedOptions.add(options[currentIndex]
                                          ['options'][index]);

                                      setState(() {
                                        if (option[index.toString()] ==
                                            correctOptions[currentIndex])
                                          score++;
                                        currentIndex++;
                                      });
                                      if (currentIndex == questions.length)
                                        _submitted();
                                      print(score);
                                    },
                                    child: Container(
                                      margin:
                                          EdgeInsets.only(top: kDefaultPadding),
                                      padding: EdgeInsets.all(kDefaultPadding),
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                            color: Color(0xFFC1C1C1)),
                                        borderRadius: BorderRadius.circular(15),
                                      ),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            "${index + 1}. ${options[currentIndex]['options'][index]}",
                                            style: TextStyle(
                                              fontSize: 16,
                                              color: Color(0xFFC1C1C1),
                                            ),
                                          ),
                                          Container(
                                            height: 26,
                                            width: 26,
                                            decoration: BoxDecoration(
                                              // color: getTheRightColor() == kGrayColor
                                              //     ? Colors.transparent
                                              //     : getTheRightColor(),
                                              borderRadius:
                                                  BorderRadius.circular(50),
                                              // border: Border.all(color: getTheRightColor()),
                                            ),
                                            // child: getTheRightColor() == kGrayColor
                                            //     ? null
                                            //     : Icon(getTheRightIcon(), size: 16),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  )
                : Column(
                    // mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: MediaQuery.of(context).size.height * .2,
                      ),
                      Text(
                        "Score",
                        style: Theme.of(context)
                            .textTheme
                            .headline3!
                            .copyWith(color: kSecondaryColor),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * .05,
                      ),
                      Text(
                        score.toString(),
                        style: Theme.of(context)
                            .textTheme
                            .headline4!
                            .copyWith(color: kSecondaryColor),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: MediaQuery.of(context).size.width * .4),
                        child: Divider(
                          color: Colors.white,
                        ),
                      ),
                      Text(
                        questions.length.toString(),
                        style: Theme.of(context)
                            .textTheme
                            .headline4!
                            .copyWith(color: kSecondaryColor),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * .1,
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width * .7,
                        child: InkWell(
                          onTap: () async {
                            final SharedPreferences sharedpref =
                                await SharedPreferences.getInstance();
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) => SHHomeScreen(
                                  sharedpref.getString('name'),
                                ),
                              ),
                            );
                          },
                          child: Container(
                            width: double.infinity,
                            alignment: Alignment.center,
                            padding:
                                EdgeInsets.all(kDefaultPadding * 0.75), // 15
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                                colors: [
                                  Color(0xff6E7FFC),
                                  Colors.lightBlueAccent
                                ],
                              ),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(12)),
                            ),
                            child: Text(
                              "Done",
                              style:
                                  Theme.of(context).textTheme.button!.copyWith(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                      ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
          )
        ],
      ),
    );
  }
}
