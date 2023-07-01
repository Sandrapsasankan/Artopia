import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:helloworld/artist/Ahome.dart';
import 'package:helloworld/Home.dart';
import 'package:helloworld/api_service/api.dart';
import 'package:helloworld/choose.dart';
import 'package:helloworld/customer/forget.dart';
import 'package:helloworld/customer/home.dart';
import 'package:helloworld/register.dart';
import 'package:shared_preferences/shared_preferences.dart';
class login extends StatefulWidget {
  const login({Key? key}) : super(key: key);

  @override
  State<login> createState() => _loginState();
}

class _loginState extends State<login> {
  late SharedPreferences localStorage;
  String role = "";
  String status = "";
  String user = "user";
  String artist = "artist";
  String storedvalue = "1";
  TextEditingController userController = TextEditingController();
  TextEditingController pwdController = TextEditingController();


  _pressLoginButton() async {
    setState(() {
      var _isLoading = true;
    });
    var data = {
      'username': userController.text.trim(), //username for email
      'password': pwdController.text.trim()
    };
    var res = await Api().authData(data, '/api/user_login');
    var body = json.decode(res.body);

    if (body['success'] == true) {
      print(body);

      role = body['data']['role'];
      status = body['data']['l_status'];

      localStorage = await SharedPreferences.getInstance();
      localStorage.setString('role', role.toString());
      localStorage.setInt('login_id', body['data']['login_id']);
      localStorage.setInt('user_id', body['data']['user_id']);

      print('login_id ${body['data']['login_id']}');
      print('user_id ${body['data']['user_id']}');

      //      if (user == role.replaceAll('"', '') &&
      //      storedvalue == status.replaceAll('"', '')) {
      //    Navigator.push(
      //        context, MaterialPageRoute(builder: (context) => MyHomePage()));
      //  } else if (doctor == role.replaceAll('"', '') &&
      //      storedvalue == status.replaceAll('"', '')) {
      //    Navigator.of(context).push(MaterialPageRoute(
      //      builder: (context) => DoctHome(),
      //    ));
      // }

      if (user == role &&
          storedvalue == status) {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => Homescreen()));
      }
      else if (artist == role &&
          storedvalue == status) {
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => Ahome(),
        ));
      } else {
        Fluttertoast.showToast(
          msg: "Please wait for admin approval",
          backgroundColor: Colors.grey,
        );
      }
    }

    //  else {
    //   Fluttertoast.showToast(
    //     msg: body['message'].toString(),
    //     backgroundColor: Colors.grey,
    //   );
    }

    @override
    Widget build(BuildContext context) {
      return Scaffold(

          body: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("LOGIN", style: TextStyle(color: Colors.black,
                  fontSize: 20,
                  fontWeight: FontWeight.bold),

              ),
              SizedBox(height: 20.0,),
              Align(alignment: Alignment.center,
                child: Text('welcome back!',
                  style: TextStyle(color: Colors.black, fontSize: 17),
                  textAlign: TextAlign.center,),

              ),

              Padding(
                padding: const EdgeInsets.all(8),
                child: TextField(
                  controller: userController,
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.person),
                    labelText: "username",
                    hintText: "username",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30)),

                  ),


                ),
              ), SizedBox(height: 20),

              Padding(
                padding: const EdgeInsets.all(8),
                child: TextField(
                  controller: pwdController,
                  obscureText: true,
                  decoration: InputDecoration(

                      prefixIcon: Icon(Icons.lock),
                      labelText: "password",
                      hintText: "password",
                      suffixIcon: Icon(Icons.remove_red_eye),


                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30))
                  ),

                ),
              ),
              SizedBox(height: 30.0,),
              TextButton(onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => Fpassword()));
              },
                child: Text(
                  "Forget password?", style: TextStyle(fontSize: 14),),),
              SizedBox(height: 20,),
              ElevatedButton(
                child: Text("Login", style: TextStyle(color: Colors.white),),
                onPressed: () {
                  _pressLoginButton();
                },
                style: ElevatedButton.styleFrom(shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50.0)),
                    primary: Colors.blue,
                    fixedSize: Size(300, 50)),

              ),

              SizedBox(height: 30.0,),
              Row(
                children: [
                  const Text('Does not have an account?',
                    style: TextStyle(fontSize: 16),),
                  SizedBox(width: 10,),
                  TextButton(onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => choose()));
                  },
                    child: const Text(
                      'Register Here', style: TextStyle(fontSize: 16,color: Color.fromRGBO(
                        18, 16, 47, 1.0)),),),


                ],
                mainAxisAlignment: MainAxisAlignment.center,
              ),


            ],

          )

      );
    }
  }
