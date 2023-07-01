
import 'package:flutter/material.dart';

class Fpassword extends StatefulWidget {
  const Fpassword({Key? key}) : super(key: key);

  @override
  State<Fpassword> createState() => _FpasswordState();
}

class _FpasswordState extends State<Fpassword> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(

        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Forgot Password",style: TextStyle(fontSize: 40,fontWeight: FontWeight.bold),),
            SizedBox(height: 40,),
            Align(
              alignment: Alignment.center,
              child: Text("we will send  a verification code to your email",style: TextStyle(fontSize: 20,color: Colors.indigo),textAlign: TextAlign.center,),
            ),
            SizedBox(height: 25,),

            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                  decoration: InputDecoration(
                      prefixIcon: Icon(Icons.email),
                      label: Text("Email"),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20)
                      ))

              ),
            ),
            ElevatedButton(onPressed: (){},
                style: ElevatedButton.styleFrom(shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(29.0)),primary: Colors.blueAccent,fixedSize: Size(350, 57)),
                child: Text("Forgot Password")),
          ],
        ),
      ),);
  }
}