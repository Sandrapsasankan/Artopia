
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:helloworld/artist/Ahome.dart';
import 'package:helloworld/artist/Aregister.dart';
import 'package:helloworld/customer/home.dart';
import 'package:helloworld/login.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {

  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  late SharedPreferences localStorage;
  String role="";
  String user="user";
  String artist="artist";


  Future<void> checkRoleAndNavigate() async {
    localStorage = await SharedPreferences.getInstance();
  role =  (localStorage.getString('role')??'');

    if (user == role ) {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => Homescreen()));
    } else if (artist == role ) {
      Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => Ahome(),
      ));
    }else {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => login()));
    }
  }



@override
void initState() {
  super.initState();
  startTime();
}

startTime() async {
  var duration = new Duration(seconds: 4);
  return Timer(duration, checkRoleAndNavigate);
}
/*
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Timer(Duration(seconds: 5),
            ()=>Navigator.pushReplacement(context,
            MaterialPageRoute(builder:
                (context) => LoginPage()
            )
        )
    );
  }*/
@override
Widget build(BuildContext context) {

  return Scaffold(

    body: Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage('images/img_3.png'),
          fit: BoxFit.cover,
        ),
      ),
      child: null /* add child content here */,
    ),
  );
}
}