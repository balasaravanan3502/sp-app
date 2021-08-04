import 'package:flutter/material.dart';

const TextFieldDecoration = InputDecoration(
  hintText: 'Enter a value',
  contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
  enabledBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Colors.blue, width: 1.0),
  ),
  focusedBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Colors.blue, width: 2.0),
  ),
);

const kTextFieldDecoration = InputDecoration(
  labelStyle: TextStyle(
    color: Color(0xff1C1C1C),
    fontSize: 18,
  ),
  contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
  enabledBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Color(0xff2598FA), width: 1.0),
    borderRadius: BorderRadius.all(Radius.circular(10.0)),
  ),
  focusedBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Color(0xff2598FA), width: 1.5),
    borderRadius: BorderRadius.all(Radius.circular(10.0)),
  ),
);

const FromFieldDecoration = BoxDecoration(
  color: Colors.white,
// shape: BoxShape.circle,
  boxShadow: [
    BoxShadow(
      blurRadius: 1,
      color: Colors.grey,
      offset: Offset(0, 1.5),
    )
  ],
);
