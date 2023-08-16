
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:helloworld/artist/Ahome.dart';
import 'package:helloworld/artist/Aregister.dart';
import 'package:helloworld/customer/home.dart';
import 'package:helloworld/login.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
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


       return Container(
         decoration: const BoxDecoration(
           image: DecorationImage(
               image: AssetImage("images/splash.jpeg"),
               fit: BoxFit.cover),
         ),
         child: Column(
           mainAxisAlignment: MainAxisAlignment.center,
           crossAxisAlignment: CrossAxisAlignment.center,
           children: [ SizedBox(
           width: 250.0,
           child: DefaultTextStyle(
             style: const TextStyle(
               color: Colors.white,fontWeight: FontWeight.bold,
               fontSize: 50.0,
               fontFamily: 'Canterbury',
             ),
             child: AnimatedTextKit(
               animatedTexts: [
                 ScaleAnimatedText('ARTOPIA'),
                 ScaleAnimatedText('ARTOPIA'),
                 ScaleAnimatedText('ARTOPIA'),
               ],
               onTap: () {
                 print("Tap Event");
               },
             ),
           ),
         )
           ],
         ),
       );

}
}