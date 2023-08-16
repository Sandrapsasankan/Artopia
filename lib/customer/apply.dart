import 'dart:io';

import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:helloworld/api_service/api.dart';
import 'package:helloworld/customer/home.dart';


import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class apply extends StatefulWidget {
  @override
  State<apply> createState() => _applyState();
}

class _applyState extends State<apply> {
  String? filePath;
  late SharedPreferences prefs;
  late int user_id;
  List _loaddata=[];



  bool _isLoading=false;
  TextEditingController nameController=TextEditingController();
  TextEditingController addressController=TextEditingController();
  TextEditingController emailController=TextEditingController();
  TextEditingController phn_noController=TextEditingController();
  TextEditingController qualificationController=TextEditingController();
  TextEditingController experienceController=TextEditingController();

  final _formKey = GlobalKey<FormState>();





  Future<void> submitForm(String name, String address, String email, String phn_no,String qualification,String experience,String filepathdocument) async {
    var uri = Uri.parse(Api().url+'/api/add_data'); // Replace with your API endpoint

    prefs = await SharedPreferences.getInstance();
    user_id = (prefs.getInt('user_id') ?? 0 );
    var request = http.MultipartRequest('POST', uri);


    request.fields['name'] = name;
    request.fields['address'] = address;
    request.fields['email'] = email;
    request.fields['phn_no'] = phn_no;
    request.fields['qualification'] = qualification;
    request.fields['experience'] = experience;
    request.fields['user'] =user_id.toString();

    print(request.fields);

    request.files.add(await http.MultipartFile.fromPath('image',filepathdocument));
    final response = await request.send();

    if (response.statusCode == 201) {
      print('Form submitted successfully');
      Navigator.push(
          this.context, MaterialPageRoute(builder: (context) => Homescreen()));
    } else {
      print('Error submitting form. Status code: ${response.statusCode}');
    }
  }
  Future<String?> openFilePicker() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();

    if (result != null) {
      PlatformFile file = result.files.first;
      setState(() {

        filePath = file.path;
        print(filePath);
      });
    } else {
      // User canceled the file picking
    }
    return filePath;
  }
  @override
  Widget build(BuildContext context) {
    var gender;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("Application"),
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [Colors.blue, Colors.purple],
            ),
          ),
        ),
        leading:
        IconButton( onPressed: (){
          Navigator.pop(context);
        },icon:Icon(Icons.arrow_back_ios,size: 20,color: Colors.white,)),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Form(
            key: _formKey,
            autovalidateMode: AutovalidateMode.always,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(height: 20,),

                Container(
                  padding: const EdgeInsets.all(10),
                  child: TextFormField(
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter some text';
                      }
                      return null;
                    },
                    controller: nameController,
                    decoration: const InputDecoration(

                      border: OutlineInputBorder( borderSide: BorderSide(width: 3, color: Colors.black), ),
                      labelText: 'Full Name',
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(10),
                  child: TextFormField(
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter some text';
                      }
                      return null;
                    },
                    controller: addressController,
                    decoration: const InputDecoration(

                      border: OutlineInputBorder( borderSide: BorderSide(width: 3, color: Colors.black),),
                      labelText: 'Address',
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

                      border: OutlineInputBorder( borderSide: BorderSide(width: 3, color: Colors.black),),
                      labelText: 'Email',
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
                    controller: phn_noController,
                    decoration: const InputDecoration(

                      border: OutlineInputBorder( borderSide: BorderSide(width: 3, color: Colors.black),),
                      labelText: 'Phone Number',
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(10),
                  child: TextFormField(
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter some text';
                      }
                      return null;
                    },
                    controller: qualificationController,
                    decoration: const InputDecoration(

                      border: OutlineInputBorder( borderSide: BorderSide(width: 3, color: Colors.pink),),
                      labelText: 'Qualification',
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(10),
                  child: TextFormField(
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter some text';
                      }
                      return null;
                    },
                    controller: experienceController,
                    decoration: const InputDecoration(

                      border:  OutlineInputBorder(borderSide:  BorderSide(color: Colors.black)
                      ),                    labelText: 'Experience',
                    ),
                  ),
                ),
                SizedBox(height: 20,width: 30,),
Container(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: Colors.deepPurple,
                  ),
    child: Text('Choose CV'),
            onPressed: openFilePicker,
        ),
  ),
                SizedBox(height: 30,),
                Text(filePath== null?"":filePath.toString()),
                SizedBox(height: 80,),
                SizedBox(
                  height: 60,
                  width: 600,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: Colors.deepPurple,
                    ),
                    child: const Text('Submit',style: TextStyle(fontSize: 20),),
                    onPressed: () {


                      submitForm(nameController.text,addressController.text,emailController.text,phn_noController.text,qualificationController.text,experienceController.text,filePath.toString());

                    },
                  ),
                ),

              ],
            ),
          ),
        ),
      ),
    );
  }
}
