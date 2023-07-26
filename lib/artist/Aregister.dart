import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:helloworld/api_service/api.dart';
import 'package:helloworld/artist/Adddrop.dart';
import 'package:helloworld/login.dart';
import 'package:helloworld/customer/home.dart';

class Aregister extends StatefulWidget {
  @override
  State<Aregister> createState() => _AregisterState();
}

class _AregisterState extends State<Aregister> {

  bool _isLoading=false;
  TextEditingController userController=TextEditingController();
  TextEditingController pwdController=TextEditingController();
  TextEditingController nameController=TextEditingController();
  TextEditingController addressController=TextEditingController();
  TextEditingController placeController=TextEditingController();
  TextEditingController phnController=TextEditingController();
  TextEditingController emailController=TextEditingController();
  final _formKey = GlobalKey<FormState>();
  void registerArtist()async {
    setState(() {
      _isLoading = true;
    });


    var data = {
      "username": userController.text.trim(),
      "password": pwdController.text.trim(),
      "name": nameController.text.trim(),
      "address": addressController.text.trim(),
      "place": placeController.text.trim(),
      "phone_number":  phnController.text,
      "email":emailController.text.trim(),
    };
    print("Artist data${data}");
    var res = await Api().authData(data,'/api/artist_register');
    var body = json.decode(res.body);
    print('res${res}');
    if(body['success']==true)
    {
      Fluttertoast.showToast(
        msg: body['message'].toString(),
        backgroundColor: Colors.grey,
      );

      Navigator.push(context, MaterialPageRoute(builder: (context)=>login()));

    }
    else
    {
      Fluttertoast.showToast(
        msg: body['message'].toString(),
        backgroundColor: Colors.grey,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
  //  var _obscureText;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("Register"),

        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: <Color>[ Color(0xFFe0e0e0), Color(0xFFe0e0e0), ]),
          ),
        ),
        leading:
        IconButton( onPressed: (){
          Navigator.pop(context);
        },icon:Icon(Icons.arrow_back_ios,size: 20,color: Colors.white,)),
      ),
      body: SingleChildScrollView(
        child: DecoratedBox(
          decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage("images/bg.png"), fit: BoxFit.cover),
          ),
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Form(
              key: _formKey,
              autovalidateMode: AutovalidateMode.always,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text ("Sign up", style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,color: Colors.pink,
                  ),),
                  SizedBox(height: 20,),
                  Text("Create an Account,Its free",style: TextStyle(
                    fontSize: 15,
                    color: Colors.grey[700],
                  ),),
                  SizedBox(height: 30,),


                  Container(
                    padding: const EdgeInsets.all(10),
                    child: TextFormField(
                      // The validator receives the text that the user has entered.
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter some text';
                        }
                        return null;
                      },
                      controller: userController,
                      decoration: const InputDecoration(
                        prefixIcon: Icon(Icons.person),
                        border: OutlineInputBorder(),
                        labelText: 'Username',
                      ),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(10),
                    child: TextFormField(
                        validator: (valuePass) {
                          if (valuePass!.isEmpty) {
                            return 'Please enter your Password';
                          }else if(valuePass.length<6){
                            return 'Password too short';
                          } else {
                            return null;
                          }
                        },

                        //     obscureText: _obscureText,
                        controller: pwdController,
                        decoration: InputDecoration(
                          labelText: "Password",
                          hintText: "Password",
                          hintStyle: TextStyle(color: Colors.red),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.only(
                              )),
                          /*  suffixIcon: GestureDetector(
                            onTap: () {
                              setState(() {
                                _obscureText = !_obscureText;
                              });
                            },
                            child: Icon(
                              _obscureText ? Icons.visibility_off : Icons.visibility,
                            ),
                          ),*/
                        )
                    ),

                  ),


                  Container(
                    padding: const EdgeInsets.all(10),
                    child:TextFormField(
                        validator: (valueConPass) {
                          if (valueConPass!.isEmpty) {
                            return 'Please confirm your Password';
                          } else if (valueConPass.length<6) {
                            return 'Please check your Password';
                          }else if (valueConPass == pwdController){
                            return null;
                          }
                        },// obscureText: _obscureText,
                        decoration: InputDecoration(
                          labelText: "ConfirmPassword",
                          hintText: "ConfirmPassword",
                          hintStyle: TextStyle(color: Colors.red),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.only(
                              )),
                          /*   suffixIcon: GestureDetector(
                            onTap: () {
                              setState(() {
                                _obscureText = !_obscureText;
                              });
                            },
                            child: Icon(
                              _obscureText ? Icons.visibility_off : Icons.visibility,
                            ),
                          ),*/
                        )
                    ),

                  ),
                  Container(
                    padding: const EdgeInsets.all(10),
                    child: TextFormField(
                      // The validator receives the text that the user has entered.
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter some text';
                        }
                        return null;
                      },
                      controller: nameController,
                      decoration: const InputDecoration(
                        prefixIcon: Icon(Icons.person),
                        border: OutlineInputBorder(),
                        labelText: 'Customername',
                      ),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(10),
                    child: TextFormField(
                      // The validator receives the text that the user has entered.
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter some text';
                        }
                        return null;
                      },
                      controller: addressController,
                      decoration: const InputDecoration(
                        prefixIcon: Icon(Icons.home),
                        border: OutlineInputBorder(),
                        labelText: 'Address',
                      ),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(10),
                    child:TextFormField(
                      // The validator receives the text that the user has entered.
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter some text';
                        }
                        return null;
                      },
                      controller: placeController,
                      decoration: const InputDecoration(
                        prefixIcon: Icon(Icons.place),
                        border: OutlineInputBorder(),
                        labelText: 'Place',
                      ),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(10),
                    child: TextFormField(
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter Mobile Number';
                        }
                        RegExp number = new RegExp(r'(^(?:[+0]9)?[0-9]{10,12}$)');
                        if (number.hasMatch(value)) {
                          return null;
                        } else {
                          return 'Invalid Mobile Number';
                        }
                      },
                      keyboardType: TextInputType.number,
                      controller: phnController,
                      decoration: const InputDecoration(
                        prefixIcon: Icon(Icons.phone),
                        border: OutlineInputBorder(),
                        labelText: 'Phone number',
                      ),
                    ),
                  ),

                  Container(
                    padding: const EdgeInsets.all(10),
                    child: TextFormField(
                      validator: (valueMail) {
                        if (valueMail!.isEmpty) {
                          return 'Please enter Email Id';
                        }
                        RegExp email = new RegExp(
                            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
                        if (email.hasMatch(valueMail)) {
                          return null;
                        } else {
                          return 'Invalid Email Id';
                        }
                      },
                      keyboardType: TextInputType.emailAddress,
                      controller: emailController,
                      decoration: const InputDecoration(
                        prefixIcon: Icon(Icons.mail),
                        border: OutlineInputBorder(),
                        labelText: 'Email',
                      ),
                    ),
                  ),
                  SizedBox(height: 20,),
                  Container(
                      height: 50,
                      padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                      child: ElevatedButton(
                        style:  ElevatedButton.styleFrom(
                          backgroundColor: Colors.pink, // background (button) color
                          // foreground (text) color
                        ),
                        child: const Text('Sign Up',),
                        onPressed: () {
                          registerArtist();
                          // Navigator.push(context, MaterialPageRoute(builder: (context)=>login()));

                          print(nameController.text);
                          var passwordController;
                          print(passwordController.text);
                        },
                      )
                  ),
                  SizedBox(height: 20,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Already have an account? "),TextButton(onPressed: (){
                        // Navigator.push(context, MaterialPageRoute(builder: (context)=>login()));
                      }, child: Text("Login",style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 18,color: Colors.pink
                      ),),

                      ),
                    ],

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

class Fluttertoast {
  static void showToast({required String msg, required MaterialColor backgroundColor}) {}
}
