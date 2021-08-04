import 'package:flutter/material.dart';

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
