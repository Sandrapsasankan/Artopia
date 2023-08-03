import 'dart:convert';
import 'dart:io';

import 'package:helloworld/api_service/api.dart';
import 'package:helloworld/artist/Ahome.dart';
import 'package:helloworld/customer/home.dart';
import 'package:helloworld/login.dart';
import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Aprofile extends StatefulWidget {
  const Aprofile({Key? key}) : super(key: key);

  @override
  State<Aprofile> createState() => _AprofileState();
}

class _AprofileState extends State<Aprofile> {

  bool isObscurePassword=true;
  late int artist_id;
  String name='';
  String place='';
  String contact='';

  late SharedPreferences prefs;
  TextEditingController nameController=TextEditingController();
  TextEditingController addressController=TextEditingController();
  TextEditingController placeController=TextEditingController();
  TextEditingController phnController=TextEditingController();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _viewPro();
  }

  int currentTab = 2;


  Future<void> _viewPro() async {
    prefs = await SharedPreferences.getInstance();
    artist_id = (prefs.getInt('user_id') ?? 0 );
    print('login_idupdate ${artist_id}');
    var res = await Api()
        .getData('/api/artist_singleprofile_view/'+artist_id.toString());
    var body = json.decode(res.body);
    print(body);
    setState(() {
      name = body['data']['name'];
      place = body['data']['place'];
      contact = body['data']['phone_number'];


      nameController.text = name;
      placeController.text=place;
      phnController.text=contact;

    });
  }


  Future<void> _update(String name,String place,String contact) async {

    prefs = await SharedPreferences.getInstance();
    artist_id = (prefs.getInt('user_id') ?? 0 );
  print(artist_id);
    var uri = Uri.parse(Api().url+'/api/artist_update_view/'+artist_id.toString()); // Replace with your API endpoint

    var request = http.MultipartRequest('PUT', uri);
    request.fields['name'] = name;
    request.fields['place'] = place;
    request.fields['phone_number'] = contact;


    print(request.fields);


    final response = await request.send();
    print(response);

    if (response.statusCode == 200) {
      print('Profile Updated successfully');
      Navigator.push(
          this.context, MaterialPageRoute(builder: (context) => Ahome()));
    } else {
      print('Error Updating profile. Status code: ${response.statusCode}');
    }
  }



  Widget currentScreen = Aprofile();
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        title: Text("Profile"),
        leading: IconButton(
          onPressed: (){
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back),
        ),
        actions: [
          IconButton(
            tooltip: "Logout",
            onPressed: (){
              Navigator.push(context, MaterialPageRoute(builder: (context)=>login()));
            },
            icon: Icon(
              Icons.logout,
              size: 28,
            ),
          )
        ],
      ),

      body: Container(
        padding: EdgeInsets.only(left: 15, top: 20, right: 15),
        child: GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
          },
          child: ListView(
            children: [

              Center(
                child: Stack(
                  children: [
                    Container(
                      width: 130,
                      height: 130,
                      decoration: BoxDecoration(
                          border: Border.all(width: 4, color: Colors.white),
                          boxShadow: [
                            BoxShadow(
                                spreadRadius: 2,
                                blurRadius: 10,
                                color: Colors.black.withOpacity(0.1)
                            )
                          ],
                          shape: BoxShape.circle,
                          image: DecorationImage(
                            fit: BoxFit.cover,
                            image: AssetImage("images/admin.png"),
                          )
                      ),
                    ),



                  ],
                ),
              ),
              SizedBox(height: 60,),

              buildTextField("Full name",nameController),
              buildTextField("Place",placeController),
              buildTextField("Contact number", phnController),

              SizedBox(height: 70,),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  OutlinedButton(
                    onPressed: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>Aprofile()));
                    },
                    child: Text("CANCEL",style: TextStyle(
                        fontSize: 15,
                        letterSpacing: 2,
                        color: Colors.black
                    )),
                    style: OutlinedButton.styleFrom(
                        padding: EdgeInsets.symmetric(horizontal: 50),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20))
                    ),
                  ),

                  ElevatedButton(
                    onPressed: (){
                      _update(nameController.text,placeController.text,phnController.text);
                    },
                    child: Text("EDIT",style: TextStyle(fontSize: 15, letterSpacing: 2, color: Colors.white),),
                    style: ElevatedButton.styleFrom(
                        primary: Colors.blue,
                        padding: EdgeInsets.symmetric(horizontal: 50),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20))
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),

    );
  }

  Widget buildTextField(String labelText,TextEditingController controller){
    return Padding(
      padding: EdgeInsets.only(bottom: 30),
      child: TextFormField(
        controller: controller,
        //obscureText: isPasswordTextField ? isObscurePassword: false,
        decoration: InputDecoration(
          // suffixIcon: isPasswordTextField ?
          //     IconButton(
          //         onPressed: () {
          //           setState(() {
          //             isObscurePassword=!isObscurePassword;
          //           });
          //         },
          //         icon: Icon(Icons.remove_red_eye,color: Colors.grey,),
          //     ):null,
          contentPadding: EdgeInsets.only(bottom: 5),
          labelText: labelText,
          labelStyle: TextStyle(fontSize: 18,color: Colors.blue),
          floatingLabelBehavior: FloatingLabelBehavior.always,

          // hintText: controller,
          // hintStyle: TextStyle(
          //   fontSize: 16,
          //   fontWeight: FontWeight.bold,
          //   color: Colors.grey
          // )

        ),
      ),
    );
  }

  static ClassNotify() {}
}