import 'package:flutter/material.dart';
import 'package:helloworld/artist/Aregister.dart';
import 'package:helloworld/login.dart';
import 'package:helloworld/register.dart';

void main() {
  runApp(welcome());
}

class welcome extends StatelessWidget {
  const welcome({super.key});

  @override
  Widget build(BuildContext context) {
    var style;
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.green),

      home: Scaffold(
        body: DecoratedBox(
          decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage(""), fit: BoxFit.cover),
          ),
          child: Padding(
            padding: const EdgeInsets.all(40.0),
            child: Center(
              child: Column(
                children: [
                  Text("ARTISTA",style: TextStyle(
                    fontSize: 40,
                    color: Colors.pink,fontWeight: FontWeight.bold,fontStyle: FontStyle.italic,
                  ),),
                  SizedBox(height: 20),
                  Container(
                      child: Image.asset("images/paint.jpeg" ,height: 450,width: 350,)),
                  SizedBox(height: 20),
                    Container(
                      child: ElevatedButton(
                        style:  ElevatedButton.styleFrom(
                          backgroundColor: Colors.pink, // background (button) color
                          // foreground (text) color
                        ),
                        onPressed: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => login()));
                        },
                        child: const Text('Login'),
                      ),
                    ),
              SizedBox(height: 20),
                    ElevatedButton(
                      style:  ElevatedButton.styleFrom(
                        backgroundColor: Colors.pink, // background (button) color
                        // foreground (text) color
                      ),
                      onPressed: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => Aregister()));
                      },
                      child: const Text('Signup'),
                    ),
                 ] ),
            ),
          ),

          ),
        ),
      );

  }
}

