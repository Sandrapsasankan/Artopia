import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:helloworld/api_service/api.dart';
import 'package:helloworld/customer/apply.dart';
import 'package:shared_preferences/shared_preferences.dart';


class jobapply extends StatefulWidget {
  final int id;

  jobapply({required this.id});

  @override
  State<jobapply> createState() => _jobapplyState();
}

class _jobapplyState extends State<jobapply> {
  bool   _isLoading = false;
  late SharedPreferences localStorage;
  TextEditingController nameController=TextEditingController();
  TextEditingController placeController=TextEditingController();
  TextEditingController salaryController=TextEditingController();
  TextEditingController experienceController=TextEditingController();
  TextEditingController qlfController=TextEditingController();
  TextEditingController descController=TextEditingController();

  var jobname,location,experience,qualification,salary,description;

  Future<void> _viewPro() async {
    int id = widget.id;
    var res = await Api()
        .getData('/api/job_single_view/' + id.toString());
    var body = json.decode(res.body);
    print(body);
    setState(() {
      jobname = body['data']['jobname'];
      location = body['data']['location'];
      experience = body['data']['experience'];
      qualification = body['data']['qualification'];
      salary = body['data']['salary'];
      description = body['data']['description'];



      nameController.text = jobname;
      placeController.text=location;
      salaryController.text=salary;
      experienceController.text = experience;
      qlfController.text = qualification;
      descController.text = description;

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
    var style;
    return Scaffold(
        backgroundColor: Colors.grey[200],
        appBar: AppBar(
          leading:
          IconButton(onPressed: () {
            Navigator.pop(context);
          }, icon: Icon(Icons.arrow_back_ios, size: 20, color: Colors.black,)),

          title: Text(
            'Job Details',

            style: TextStyle(
              color: Colors.white,
            ),
          ),
          flexibleSpace: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [Colors.blue, Colors.purple],
              ),
            ),
          ),
        ),
        body: Container(
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(50),
                topRight: Radius.circular(50),
              )
          ),
          child: Padding(
            padding: EdgeInsets.all(40),
            child: SingleChildScrollView(
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [


                    SizedBox(
                      height: 32,
                    ),

                    Center(
                      child: Text(
                        jobname,
                        style: TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),

                    SizedBox(height: 16,),

                    Center(
                      child:

                      Text(
                        location,
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.grey,
                        ),
                      ),
                    ),

                    SizedBox(
                      height: 32,
                    ),

                    Container(
                      height: 45,
                      decoration: BoxDecoration(
                        color: Colors.grey,
                        borderRadius: BorderRadius.all(
                          Radius.circular(10),
                        ),
                      ),
                      child: Center(
                        child: Text(
                          salary,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 20,),
                    Text(
                      "Experience :",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),

                    Text(experience
                    ),

                    SizedBox(height: 19,),
                    Text(
                      "Qualification :",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),

                    Text(qualification
                    ),


                    SizedBox(
                      height: 19,
                    ),
                    Text(
                      "Job Description :",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),

                    Text(
                        description,
                      textAlign: TextAlign.justify,
                    ),

                    SizedBox(height: 130,),
                    SizedBox(
                      width: 800.0,
                      height: 50.0,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          primary: Colors.deepPurple,
                        ),
                        onPressed: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => apply()));
                        },
                        child: const Text('Apply Now',style: TextStyle(fontSize: 20),),

                      ),
                    ),

                  ]
              ),
            ),
          ),
        )

    );
  }
}



