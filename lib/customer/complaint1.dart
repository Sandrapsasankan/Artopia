import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:helloworld/api_service/api.dart';
import 'package:helloworld/customer/home.dart';
import 'package:helloworld/customer/chat.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';



class Complaint_Details extends StatefulWidget {
  final int id;

  Complaint_Details({required this.id});
  @override
  State<Complaint_Details> createState() => _Complaint_DetailsState();
}

class _Complaint_DetailsState extends State<Complaint_Details> {
//   @override

  String complaint="";
  late int id;
  late int user_id;
  late int artist_id;
  late SharedPreferences localStorage;
  bool  _isLoading = false;

  String formattedDate = DateFormat('yyyy-MM-dd').format(DateTime.now());

  TextEditingController complaintController = TextEditingController();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
   // _viewPro();
  }

 /* Future<void> _viewPro() async {
    int id = widget.id;
    print("id${id}");

    var res = await Api().getData('/api/artist_single_view/' + id.toString());
    var body = json.decode(res.body);
    print(body);
    setState(() {
      user_id = body['data']['user_id'];
      artist_id = body['data']['artist_id'];
      complaint = body['data']['complaint'];

      complaintController.text=complaint;

    });
  }
 */ Future<void> chat() async {
    setState(() {
      _isLoading = true;
    });
    int id = widget.id;

    localStorage = await SharedPreferences.getInstance();
    user_id= (localStorage.getInt('user_id') ?? 0);
    var data = {
      "user": user_id.toString(),
      "artist":id.toString(),
       "date":formattedDate,
      "complaint":complaintController.text,

    };
    print(data);
    var res = await Api().authData(data,'/api/add_complaint');
    var body = json.decode(res.body);
    print(body);
    if(body['success']==true)
    {
      print(body);


      Navigator.push(context, MaterialPageRoute(builder: (context)=>Homescreen()));
      Fluttertoast.showToast(
        msg: body['message'].toString(),
        backgroundColor: Colors.grey,
      );
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
    var size=MediaQuery.of(context).size;
    return Scaffold(

      appBar: AppBar(
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
        },icon:Icon(Icons.arrow_back_ios,size: 20,color: Colors.black,)),

        title: Text('Messaging'),
      ),

      body:  SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 15),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                height: size.height*.35,
                child:
                Image.asset('images/complaint123.jpeg',
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Padding(
                padding: const EdgeInsets.only(left: 12,right: 12,top: 20),
                child: Container(
                    height: 300.0,
                    child: Stack(
                        children: [
                          TextField(
                            controller: complaintController,
                            maxLines: 10,
                            decoration: InputDecoration(
                              hintText: 'Please Message Here......',
                              hintStyle: TextStyle(
                                  fontSize: 15,
                                  color: Colors.grey
                              ),
                              border: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.grey),
                              ),

                            ),
                          ),
                        ]
                    )
                )
            ),

            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                child: ElevatedButton(
                  onPressed: (){
                    chat();
                  },
                  child: Text('Send',style: TextStyle(fontSize: 19),),
                  style: ElevatedButton.styleFrom(fixedSize: Size(230, 55),shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(29.0)),primary: Colors.deepPurple),
                ),
              ),

            )],
        ),

      ),
    );
  }
}