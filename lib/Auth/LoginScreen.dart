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
            padding: EdgeInsets.all(30),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  children: [
                    SizedBox(
                      height: MediaQuery.of(context).size.height * .1,
                    ),
                    Text(
                      '  Welcome Back',
                      style: TextStyle(
                        fontSize: 37,
                        color: Color(0xff2C364E),
                        fontFamily: 'Lato',
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      'Let\'s sign you in.',
                      style: TextStyle(
                        fontSize: 32,
                        color: Color(0xff2C364E),
                        fontFamily: 'Lato',
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * .1,
                ),
                Column(
                  children: [
                    TextFormField(
                      controller: _userId,
                      decoration: TextFieldDecoration.copyWith(
                        hintText: 'Email',
                      ),
                      cursorColor: Color(0xff3B73E9),
                      onChanged: (value) {},
                    ),
                    SizedBox(
                      height: 25,
                    ),
                    TextFormField(
                      controller: _password,
                      obscureText: !isObscure,
                      decoration: TextFieldDecoration.copyWith(
                        hintText: 'Password',
                        suffixIcon: IconButton(
                          onPressed: () {
                            setState(() {
                              isObscure = !isObscure;
                            });
                          },
                          icon: Icon(
                            !isObscure
                                ? Icons.visibility
                                : Icons.visibility_off,
                            color: Color(0xff2C364E),
                          ),
                        ),
                      ),
                      cursorColor: Color(0xff3B73E9),
                      onChanged: (value) {},
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * .1,
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(40),
                        color: Color(0xff6E7FFC),
                      ),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          elevation: 0,
                          primary: Colors.transparent,
                          shape: StadiumBorder(),
                        ),
                        onPressed: () {
                          isLoading = true;
                          _submitted();
                          isLoading = false;
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(13.0),
                          child: Text(
                            'LOGIN',
                            style: TextStyle(
                              fontSize: 17,
                              color: Colors.white,
                              letterSpacing: 0.7,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
