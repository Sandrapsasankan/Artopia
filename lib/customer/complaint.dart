import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:helloworld/api_service/api.dart';
import 'package:helloworld/customer/chatscreen.dart';
import 'package:helloworld/customer/complaint1.dart';
import 'package:helloworld/customer/reply.dart';
import 'package:helloworld/customer/replycomp.dart';
class Complaint extends StatefulWidget {
  const Complaint({Key? key}) : super(key: key);

  @override
  State<Complaint> createState() => _ComplaintState();
}

class _ComplaintState extends State<Complaint> {
  List _loaddata=[];
  // late int id;
  _fetchData() async {


    var res = await Api().getData('/api/artist_all_view');
    if (res.statusCode == 200) {
      var items = json.decode(res.body)['data'];
      print(items);
      setState(() {
        _loaddata = items;
      });
    } else {
      setState(() {
        _loaddata = [];
        Fluttertoast.showToast(
          msg: "Currently there is no data available",
          backgroundColor: Colors.grey,
        );
      }
      );
    }
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _fetchData();
  }

  @override
  Widget build(BuildContext context) {


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
          title: Text("Artists"),

          leading:
          IconButton( onPressed: (){
            Navigator.pop(context);
          },icon:Icon(Icons.arrow_back_ios,size: 20,color: Colors.black,)),
        ),


        body: ListView.builder(

            itemCount: _loaddata.length,
            shrinkWrap: true,
            itemBuilder: (context, index) {
              int id = _loaddata[index]['id'];
              return Card(
                margin: const EdgeInsets.all(10),
                child: SizedBox(
                    width: 250,
                    height: 100,
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [

                          Padding(
                            padding: const EdgeInsets.only(top:16,right: 12,left: 12),
                            child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [

                                  Text(_loaddata[index]['name'],style: TextStyle(fontSize: 20),textAlign: TextAlign.justify,),
                                ]
                            ),
                          ),


                          Row(
                            children: [
                              Row(
                                children:[

                                  ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      primary: Colors.deepPurple,
                                    ),
                                    onPressed: () {
                                      Navigator.push(context, MaterialPageRoute(
                                          builder: (context) => Complaint_Details(id:id)));
                                    },
                                    child: const Text('Complaint'),
                                  ),


                                  SizedBox(width: 5,),
                                  ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      primary: Colors.deepPurple,
                                    ),
                                    onPressed: () {


                                      Navigator.push(context, MaterialPageRoute(
                                          builder: (context) => replycomp(id:id)));
                                    },
                                    child: const Text('Reply'),
                                  ),
                                ],

                              ),
                            ],

                          )
                        ]
                    )
                ),
              );
            }
        )

    );
  }
}