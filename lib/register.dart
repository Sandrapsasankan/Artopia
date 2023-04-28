import 'package:flutter/material.dart';
import 'package:helloworld/login.dart';
import 'package:helloworld/home.dart';

class SignupPage extends StatelessWidget {
  get nameController => null;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        brightness: Brightness.light,
        backgroundColor: Colors.white,
        leading:
        IconButton( onPressed: (){
          Navigator.pop(context);
        },icon:Icon(Icons.arrow_back_ios,size: 20,color: Colors.black,)),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            height: MediaQuery.of(context).size.height,
            width: double.infinity,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text ("Sign up", style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                        ),),
                        SizedBox(height: 20,),
                        Text("Create an Account,Its free",style: TextStyle(
                          fontSize: 15,
                          color: Colors.grey[700],
                        ),),
                        SizedBox(height: 30,)
                      ],
                    ),

                    Container(
                      padding: const EdgeInsets.all(10),
                      child: TextField(
                        controller: nameController,
                        decoration: const InputDecoration(
                          prefixIcon: Icon(Icons.mail),
                          border: OutlineInputBorder(),
                          labelText: 'Email',
                        ),
                      ),
                    ),
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
                      padding: const EdgeInsets.all(10),
                      child: TextField(
                        controller: nameController,
                        decoration: const InputDecoration(
                          prefixIcon: Icon(Icons.lock),
                          border: OutlineInputBorder(),
                          labelText: 'Password',
                        ),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.all(10),
                      child: TextField(
                        controller: nameController,
                        decoration: const InputDecoration(
                          prefixIcon: Icon(Icons.lock),
                          border: OutlineInputBorder(),
                          labelText: 'Confirm Password',
                        ),
                      ),
                    ),
                    SizedBox(height: 20,),
                    Container(
                        height: 50,
                        padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                        child: ElevatedButton(
                          child: const Text('Sign Up'),
                          onPressed: () {
                            Navigator.push(context, MaterialPageRoute(builder: (context)=>Homepage()));

                            print(nameController.text);
                            var passwordController;
                            print(passwordController.text);
                          },
                        )
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("Already have an account? "),TextButton(onPressed: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context)=>LoginPage()));
                        }, child: Text("Login",style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 18
                        ),),

                    )
                  ],

                ),
              ],
            ),
    ],
    ),
    ),
    ),
    ),);
  }
}

Widget makeInput({label,obsureText = false}){
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(label,style:TextStyle(
          fontSize: 15,
          fontWeight: FontWeight.w400,
          color: Colors.black87
      ),),
      SizedBox(height: 5,),
      TextField(
        obscureText: obsureText,
        decoration: InputDecoration(
          contentPadding: EdgeInsets.symmetric(vertical: 0,horizontal: 10),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.grey,
            ),
          ),
          border: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.grey)
          ),
        ),
      ),
      SizedBox(height: 30,)

    ],
  );
}