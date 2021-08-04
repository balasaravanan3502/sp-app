import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sp_app/Auth/LoginScreen.dart';

import 'Provider/Auth.dart';

void main() async {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(
          value: Auth(),
        ),
        // ChangeNotifierProvider.value(
        //   value: Data(),
        // ),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
          fontFamily: 'Lato',
        ),
        routes: {},
        home: LandingScreen(),
      ),
    );
  }
}

class LandingScreen extends StatefulWidget {
  @override
  _LandingScreenState createState() => _LandingScreenState();
}

class _LandingScreenState extends State<LandingScreen> {
  Future<String> landingPageDecider() async {
    final SharedPreferences sharedpref = await SharedPreferences.getInstance();
    if (sharedpref.getString('uid') != null) {
      // final provider = Provider.of<Data>(context, listen: false);
      // await provider.fetchData();
      // await provider.grahakMasterData();
      return 'home';
    } else {
      return 'signIn';
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<String>(
        future: landingPageDecider(),
        builder: (context, AsyncSnapshot<String> snapshot) {
          // if (snapshot.data == 'home') return Home();
          // if (snapshot.data == 'signIn') return FormScreen();

          return LoginScreen();
        });
  }
}
