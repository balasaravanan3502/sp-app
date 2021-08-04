import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sp_app/Provider/Auth.dart';

import '../../constant.dart';

class LoginScreen extends StatefulWidget {
  static const routeName = 'login';
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool isLoading = false;
  bool isObscure = false;
  bool isChecked = false;
  final TextEditingController _userId = TextEditingController();
  final TextEditingController _password = TextEditingController();

  void _submitted() async {
    FocusManager.instance.primaryFocus?.unfocus();
    if (_userId.text != '' && _password.text != '') {
      final provider = Provider.of<Auth>(context, listen: false);

      final result =
          await provider.login(_userId.text, _password.text, isChecked);

      if (result == '200') {
        // final provider = Provider.of<Data>(context, listen: false);
        // await provider.fetchData();
        // Navigator.pushReplacement(
        //   context,
        //   MaterialPageRoute(
        //     // builder: (context) => HomeScreen(),
        //   ),
        // );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        backgroundColor: Color(0xffF5F6FD),
        resizeToAvoidBottomInset: false,
        body: SafeArea(
          child: Container(
              child: Column(
            children: [
              Text(
                'Lets Sign you in',
                style: TextStyle(
                  fontSize: 27,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          )),
        ),
      ),
    );
  }
}
