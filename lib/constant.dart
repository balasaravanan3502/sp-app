import 'package:flutter/material.dart';

const kPrimary = Color(0xff2C364E);
const TextFieldDecoration = InputDecoration(
  border: OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(20.0)),
  ),
  hintText: 'Enter a value',
  contentPadding: EdgeInsets.symmetric(vertical: 18.0, horizontal: 25.0),
  enabledBorder: OutlineInputBorder(
    borderSide: BorderSide(
      color: Color(0xff2D5C78),
      width: 1.0,
    ),
    borderRadius: BorderRadius.all(Radius.circular(20.0)),
  ),
  focusedBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Color(0xff2D5C78), width: 2.0),
    borderRadius: BorderRadius.all(Radius.circular(20.0)),
  ),
);

final circleavatar = Container(
  margin: EdgeInsets.all(6.0),
  child: CircleAvatar(
    radius: 30.0,
    backgroundColor: Colors.indigo,
  ),
);

const kTextFieldDecoration = InputDecoration(
  labelStyle: TextStyle(
    color: Color(0xff1C1C1C),
    fontSize: 18,
  ),
  contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
  enabledBorder: OutlineInputBorder(
    borderSide: BorderSide(color: kPrimary, width: 1.0),
    borderRadius: BorderRadius.all(Radius.circular(10.0)),
  ),
  focusedBorder: OutlineInputBorder(
    borderSide: BorderSide(color: kPrimary, width: 1.5),
    borderRadius: BorderRadius.all(Radius.circular(10.0)),
  ),
);
