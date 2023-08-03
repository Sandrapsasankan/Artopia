import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:helloworld/api_service/api.dart';
import 'package:helloworld/artist/Aevent.dart';
import 'package:helloworld/login.dart';
import 'package:helloworld/customer/home.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http ;

class Aeventedit extends StatefulWidget {
  final int id;

  Aeventedit({required this.id});

  @override
  State<Aeventedit> createState() => _AeventeditState();
}

class _AeventeditState extends State<Aeventedit> {

  late int id;
  String name='';
  String description='';
  String place='';
  String date='';
  String time='';

  late SharedPreferences prefs;
  TextEditingController nameController=TextEditingController();
  TextEditingController descController=TextEditingController();
  TextEditingController placeController=TextEditingController();
  TextEditingController dateController=TextEditingController();
  TextEditingController timeController=TextEditingController();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _viewPro();
  }

  int currentTab = 2;

  DateTime selectedDate = DateTime.now();
  late String startDate;
  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime.now(),
        lastDate: DateTime(2101));
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
        startDate =
        '${selectedDate.year}-${selectedDate.month}-${selectedDate.day}';
      });
    }
  }


  Future<void> _viewPro() async {
    int id=widget.id;
    var res = await Api()
        .getData('/api/event_single_view/'+id.toString());
    var body = json.decode(res.body);
    print(body);
    setState(() {
      name = body['data']['name'];
      description = body['data']['description'];
      place = body['data']['place'];
      date = body['data']['date'];
      time = body['data']['time'];


      nameController.text = name;
      descController.text=description;
      placeController.text=place;
      dateController.text=date;
      timeController.text=time;

    });
  }


  Future<void> _update(String name,String description, String place,String date,String time) async {
    int id=widget.id;
    prefs = await SharedPreferences.getInstance();

    var uri = Uri.parse(Api().url+'/api/event_update_view/'+id.toString()); // Replace with your API endpoint

    // var http;
    var request = http.MultipartRequest('PUT', uri);
    request.fields['name'] = name;
    request.fields['description'] = description;
    request.fields['place'] = place;
    request.fields['date'] = startDate;
    request.fields['time'] = time;



    print(request.fields);


    final response = await request.send();


    if (response.statusCode == 200) {
      print('Event Updated successfully');
      Navigator.push(
          this.context, MaterialPageRoute(builder: (context) => Aevent()));
    } else {
      print('Error Updating event. Status code: ${response.statusCode}');
    }
  }

  _deleteData(int id) async {
    var res = await Api().deleteData('/api/delete_event/'+ id.toString());
    if (res.statusCode == 200) {
      setState(() {
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => Aevent()));
        Fluttertoast.showToast(
          msg: "Event Deleted Successfully",
          backgroundColor: Colors.grey,
        );
      });
    } else {
      setState(() {
        Fluttertoast.showToast(
          msg: "Currently there is no data available",
          backgroundColor: Colors.grey,
        );
      });
    }
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
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
        title:Text ('Edit Event'),
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
                    // Column(
                    //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    //   children: [
                    //     Text('Event Details'),
                    //   ],
                    // ),
SizedBox(height: 20,),
                    Container(
                      padding: const EdgeInsets.all(10),
                      child: TextField(
                        controller: nameController,
                        decoration: const InputDecoration(

                            border: OutlineInputBorder(),


                        ),
                      ),
                    ),

                    Container(
                      padding: const EdgeInsets.all(10),
                      child: TextField(
                        maxLines: 5,
                        controller: descController,
                        decoration: const InputDecoration(

                          border: OutlineInputBorder(),


                        ),
                      ),

                    ),
                    Container(
                      padding: const EdgeInsets.all(10),
                      child: TextField(
                        controller: placeController,
                        decoration: const InputDecoration(

                            border: OutlineInputBorder(),


                        ),
                      ),
                    ),
                    Container(
                      padding:  const EdgeInsets.all(20.0),
                      child: Row(
                        children: [
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              primary: Colors.deepPurple,
                            ),
                            onPressed: () => _selectDate(context),
                            child: const Text('Select date'),
                          ),SizedBox(width: 20,),
                          Container(
                            height: 45,
                            width: 150,
                            margin: const EdgeInsets.all(15.0),
                            padding: const EdgeInsets.all(3.0),
                            decoration: BoxDecoration(
                                border: Border.all(color: Colors.black26)),
                            child: Padding(
                              padding: const EdgeInsets.only(top: 8.0),
                              child: Text(
                                '${selectedDate.day}-${selectedDate.month}-${selectedDate.year}',
                                style: TextStyle(fontSize: 16, color: Colors.black38),
                              ),
                            ),
                          ),

                        ],
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.all(10),
                      child: TextField(
                        controller: timeController,
                        decoration: const InputDecoration(

                          border: OutlineInputBorder(),


                        ),
                      ),
                    ),
SizedBox(height: 60,),
Container(
  child: Row(
    mainAxisAlignment: MainAxisAlignment.spaceAround,
    children: [
      ElevatedButton(
        onPressed: (){
          _update(nameController.text,descController.text,placeController.text,timeController.text,dateController.text);
        },
        child: Text("EDIT",style: TextStyle(fontSize: 15, letterSpacing: 2, color: Colors.white),),
        style: ElevatedButton.styleFrom(
            primary: Colors.deepPurple,
            padding: EdgeInsets.symmetric(horizontal: 50,vertical: 25,),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20))
        ),
      ),

      ElevatedButton(
        onPressed: (){
          _deleteData(widget.id);
        },
        child: Text("Delete",style: TextStyle(fontSize: 15, letterSpacing: 2, color: Colors.white),),
        style: ElevatedButton.styleFrom(
            primary: Colors.deepPurple,
            padding: EdgeInsets.symmetric(horizontal: 50,vertical: 25,),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20))
        ),
      ),


    ],
  ),
)

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