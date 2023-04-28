import 'package:flutter/material.dart';
import 'package:helloworld/login.dart';
import 'package:helloworld/register.dart';
class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
          body: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("HELLO THERE",style: TextStyle(fontSize:30),),
              SizedBox(height: 20,),
              Align(alignment: Alignment.center,),
              SizedBox(height: 35,),
              Image.asset("images/paint.jpeg" ,width: 600, height:350,),
              ElevatedButton(onPressed: (){
                Navigator.push(context, MaterialPageRoute(builder: (context)=>LoginPage()));
              },
              style: ElevatedButton.styleFrom(shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(29)),primary: Colors.blueAccent,fixedSize: Size(350, 57)),
              child: Text("Login",style: TextStyle(fontSize: 18,color: Colors.white),)),
              SizedBox(height: 35,),
              ElevatedButton(onPressed: (){
                Navigator.push(context, MaterialPageRoute(builder: (context)=>SignupPage()));
              },
                  style: ElevatedButton.styleFrom(shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(29)),primary: Colors.blueAccent,fixedSize: Size(350, 57)),
                  child: Text("Sign Up",style: TextStyle(fontSize: 18,color: Colors.white),)),

            ],
          ),
        ),
          
        );

  }
}
