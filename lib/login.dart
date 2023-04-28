import 'package:flutter/material.dart';
import 'package:helloworld/forget.dart';
import 'package:helloworld/home.dart';

import 'register.dart';


class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

 // static const String _title = 'Sample App';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(

      home: Scaffold(

        body: const MyStatefulWidget(),
      ),
    );
  }
}

class MyStatefulWidget extends StatefulWidget {
  const MyStatefulWidget({Key? key}) : super(key: key);

  @override
  State<MyStatefulWidget> createState() => _MyStatefulWidgetState();
}

class _MyStatefulWidgetState extends State<MyStatefulWidget> {
  TextEditingController nameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(10),
        child: ListView(
          children: <Widget>[
            SizedBox(height: 160,),
            Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.all(10),
                child: const Text(
                  'Login',
                  style: TextStyle(fontSize: 40,fontWeight: FontWeight.bold,color: Colors.deepPurple),
                )),

            SizedBox(height: 50,),
            Container(
              padding: const EdgeInsets.all(10),
              child: TextField(
                controller: nameController,
                decoration: const InputDecoration(
                  prefixIcon: Icon(Icons.person),
                  border: OutlineInputBorder(),
                  labelText: 'Username',
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
              child: TextField(
                obscureText: true,
                controller: passwordController,
                decoration: const InputDecoration(
                  prefixIcon: Icon(Icons.lock),
                  border: OutlineInputBorder(),
                  labelText: 'Password',
                ),
              ),
            ),
            TextButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context)=>Fpassword()));
                //forgot password screen
              },
              child: const Text('Forgot Password',),
            ),
            Container(
                height: 50,
                padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                child: ElevatedButton(
                  child: const Text('Login'),
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>Homepage()));
                    print(nameController.text);
                    print(passwordController.text);
                  },
                )
            ),
            Row(
              children: <Widget>[
                const Text('Does not have account?'),
                TextButton(
                  child: const Text(
                    'Sign up',
                    style: TextStyle(fontSize: 20),
                  ),
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>SignupPage()));
                    //signup screen
                  },
                )
              ],
              mainAxisAlignment: MainAxisAlignment.center,
            ),
          ],
        ));

  }
}

class HPage {
}