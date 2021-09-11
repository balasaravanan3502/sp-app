import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:flutter_svg/svg.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:provider/provider.dart';
import 'package:sp_app/Modules/Shared/Screens/SHHomeScreen.dart';
import 'package:sp_app/Modules/Shared/Widgets/CustomSnackBar.dart';
import 'package:sp_app/Provider/Data.dart';

import '../../constant.dart';

class LoginScreen extends StatefulWidget {
  static const routeName = 'login';
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool isLoading = false;
  bool trySubmitted = false;
  bool isObscure = false;
  bool isChecked = false;
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _userId = TextEditingController();
  final TextEditingController _password = TextEditingController();

  void _submitted() async {
    setState(() {
      isLoading = true;
    });
    FocusManager.instance.primaryFocus?.unfocus();
    trySubmitted = true;
    if (_formKey.currentState!.validate()) {
      final provider = Provider.of<Data>(context, listen: false);

      var result = await provider
          .login({"email": _userId.text, "password": _password.text});

      if (result["code"] == '200') {
        await provider.getWorks();
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => SHHomeScreen(),
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          customSnackBar(
            content: result['message'].toString(),
          ),
        );
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
        body: LoadingOverlay(
          color: Colors.black,
          isLoading: isLoading,
          progressIndicator: Center(
            child: Container(
              color: Color(0xff6E7FFC),
              height: 130,
              width: 130,
              padding: EdgeInsets.all(20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Loading',
                    style: TextStyle(
                      fontSize: MediaQuery.of(context).size.height * 0.025,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  Container(
                    height: 40,
                    width: 40,
                    child: LoadingIndicator(
                        indicatorType: Indicator.ballPulseSync,
                        colors: const [Colors.white],
                        strokeWidth: 0,
                        backgroundColor: Colors.transparent,
                        pathBackgroundColor: Colors.black),
                  ),
                ],
              ),
            ),
          ),
          child: SafeArea(
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
                          color: kPrimary,
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
                          color: kPrimary,
                          fontFamily: 'Lato',
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * .1,
                  ),
                  Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        TextFormField(
                          controller: _userId,
                          decoration: TextFieldDecoration.copyWith(
                            hintText: 'Email',
                          ),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Enter a email';
                            }
                            return null;
                          },
                          cursorColor: Color(0xff3B73E9),
                          onChanged: (value) {
                            if (trySubmitted) _formKey.currentState!.validate();
                          },
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
                                color: kPrimary,
                              ),
                            ),
                          ),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Enter a password';
                            }
                            return null;
                          },
                          cursorColor: Color(0xff3B73E9),
                          onChanged: (value) {
                            if (trySubmitted) _formKey.currentState!.validate();
                          },
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * .1,
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(40),
                          ),
                          child: Neumorphic(
                            style: NeumorphicStyle(
                              shape: NeumorphicShape.flat,
                              depth: 20, //customize depth here
                              color: Color(0xff6E7FFC),
                              border: NeumorphicBorder(
                                color: Color.fromRGBO(193, 214, 233, 1),
                                width: 0.8,
                              ),
                            ),
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                elevation: 0,
                                primary: Colors.transparent,
                                // shape: StadiumBorder(),
                              ),
                              onPressed: () {
                                _submitted();
                                setState(() {
                                  isLoading = false;
                                });
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
                        ),
                        SizedBox(
                          height: 40,
                        ),
                        Column(
                          children: [
                            Text(
                              'Or Login With',
                              style: TextStyle(
                                color: kPrimary,
                                fontWeight: FontWeight.bold,
                                fontSize: 17,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            primary: Colors.transparent,
                            elevation: 0,
                          ),
                          child: CircleAvatar(
                            backgroundColor: Colors.transparent,
                            child: SvgPicture.asset(
                              'assets/icons/google.svg',
                              fit: BoxFit.cover,
                              allowDrawingOutsideViewBox: true,
                            ),
                            radius: MediaQuery.of(context).size.width * .038,
                          ),
                          onPressed: () {},
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
