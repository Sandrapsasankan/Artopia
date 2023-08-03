
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:helloworld/api_service/api.dart';
import 'package:shared_preferences/shared_preferences.dart';
class Showevent extends StatefulWidget {

  final int id;
  Showevent({required this.id});


  @override
  State<Showevent> createState() => _ShoweventState();
}

class _ShoweventState extends State<Showevent> {
  bool   _isLoading = false;
  late SharedPreferences localStorage;
  TextEditingController nameController=TextEditingController();
  TextEditingController descController=TextEditingController();
  TextEditingController placeController=TextEditingController();
  TextEditingController dateController=TextEditingController();
  TextEditingController timeController=TextEditingController();


  String name='',place='',description='',date='',time='',image='';

  Future<void> _viewPro() async {
    int id = widget.id;
    var res = await Api()
        .getData('/api/event_single_view/' + id.toString());
    var body = json.decode(res.body);
    print(body);
    setState(() {
      name = body['data']['name'];
      place = body['data']['place'];
      description = body['data']['description'];
      date = body['data']['date']==null?"":body['data']['date'];
      time = body['data']['time'];
      image = body['data']['image'];




      nameController.text = name;
      descController.text=description;
      placeController.text=place;
      dateController.text=date;
      timeController.text=time;

    });
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _viewPro();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Event Details"),
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
      ),


        body: ListView(
            children: [
              SizedBox(height: 25.0),
              Padding(
                padding: EdgeInsets.only(left: 20.0),
                child: Text(
                    name,
                    style: TextStyle(
                        fontFamily: 'Varela',
                        fontSize: 28.0,
                        fontWeight: FontWeight.bold,
                        color:Colors.deepPurple)
                ),
              ),
             // SizedBox(height: 5.0),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Text(place,
                    style: TextStyle(
                        fontFamily: 'Varela',
                        fontSize: 22.0,
                        color: Colors.grey)),
              ),

             // SizedBox(height: 7,),
              Container(
                height: 200,
                width: 250,
                child: Image(image: NetworkImage(Api().url+image)),
              ),
              //
            //  SizedBox(height: 5.0),
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Text("Date :", style: TextStyle(
                      fontFamily: 'Varela',
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,)),
                  ),
                  SizedBox(width: 10.0),
                  Text(date,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontFamily: 'Varela',
                        fontSize: 16.0,
                        color: Colors.black,)
                  ),
                ],
              ),
             // SizedBox(height: 5.0),
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Text("Time :", style: TextStyle(
                      fontFamily: 'Varela',
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,)),
                  ),
                  SizedBox(width: 10.0),
                  Text(time,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontFamily: 'Varela',
                        fontSize: 16.0,
                        color: Colors.black,)
                  ),
                ],
              ),
             // SizedBox(height: 3.0),
              Padding(
                padding: const EdgeInsets.only(left:20,right: 20,top: 4),
                child: Text("Description :", style: TextStyle(
                  fontFamily: 'Varela',
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,)),
              ),
             // SizedBox(height: 10.0),
              Padding(
                padding: const EdgeInsets.only(left:20,right: 20,top: 10),
                child: Text(description,
                    textAlign: TextAlign.justify,
                    style: TextStyle(
                      fontFamily: 'Varela',
                      fontSize: 16.0,
                      color: Colors.black,)
                ),
              ),


            ]
        ),


    );
  }
}
