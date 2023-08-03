import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:helloworld/api_service/api.dart';
import 'package:helloworld/customer/complaintmsg.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class addfeedback extends StatefulWidget {
  const addfeedback({Key? key}) : super(key: key);

  @override
  State<addfeedback> createState() => _addfeedbackState();
}

class _addfeedbackState extends State<addfeedback> {
  TextEditingController feedbackController=TextEditingController();
  DateTime datetime = DateTime.now();
  String datetime1='';
  late SharedPreferences prefs;
  late int user_id;
  bool _isLoading=false;
  void Addfeedback()

  async {
    datetime1 = DateFormat("yyyy-MM-dd").format(datetime);
    prefs = await SharedPreferences.getInstance();
    user_id = (prefs.getInt('user_id')?? 0);
    setState(() {
      _isLoading = true;
    });

    var data = {
      "feedback": feedbackController.text.trim(),
      "date": datetime1,
      "user":user_id.toString(),
    };

    print(" data${data}");
    var res = await Api().authData(data,'/api/add_feedback');
    var body = json.decode(res.body);
    print(body);
    if(body['success']==true)
    {

      Navigator.push(context, MaterialPageRoute(builder: (context)=>compmsg()));
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
  TextEditingController dateInput = TextEditingController();

  @override
  void initState() {
    dateInput.text = ""; //set the initial value of text field
    super.initState();
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
        title: Text('Add feedback'),
      ),

      body:  SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: size.height*.35,
              child:
              Image.asset('images/feedback.jpg',
                fit: BoxFit.cover,
              ),
            ),
            Padding(
                padding: const EdgeInsets.only(left: 12,right: 12,top: 20),
                child: Container(
                    height: 350.0,
                    child: Stack(
                        children: [
                          TextField(
                            controller: feedbackController,
                            maxLines: 10,
                            decoration: InputDecoration(
                              hintText: 'Please Explain breifly about your issue',
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

            //
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                child: ElevatedButton(
                  onPressed: (){
                    Addfeedback();
                  },
                  child: Text('Submit',style: TextStyle(fontSize: 19),),
                  style: ElevatedButton.styleFrom(fixedSize: Size(230, 55),shape: RoundedRectangleBorder
                    (borderRadius: BorderRadius.circular(29.0)),primary: Colors.deepPurple),
                ),
              ),

            )],
        ),

      ),
    );
  }
}