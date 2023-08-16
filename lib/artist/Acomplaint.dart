import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:helloworld/api_service/api.dart';
import 'package:helloworld/artist/Acomplaint1.dart';

import 'package:shared_preferences/shared_preferences.dart';


class Acomplaint extends StatefulWidget {
  const Acomplaint({Key? key}) : super(key: key);

  @override
  State<Acomplaint> createState() => _AcomplaintState();
}

class _AcomplaintState extends State<Acomplaint> {

  bool isObscurePassword=true;
  late int user_id;
  String u_name="";
  String complaint="";
  late SharedPreferences prefs;
  TextEditingController u_nameController=TextEditingController();
  TextEditingController complaintController=TextEditingController();
  List _loaddata=[];


  @override

  void initState() {
    // TODO: implement initState
    super.initState();
    // _viewPro();
    _fetchData();
  }
  int currentTab = 2;
  // Future<void> _viewPro() async {
  //   prefs = await SharedPreferences.getInstance();
  //   user_id = (prefs.getInt('user_id') ?? 0 );
  //   print('${user_id }');
  //   var res = await Api().getData('/api/chat_single_view/'+user_id.toString());
  //
  //   var body = json.decode(res.body);
  //   // var body = json.decode(res.body);
  //   print(body);
  //
  //
  //   setState(() {
  //     u_name = body['data']['u_name'];
  //     message = body['data']['message'];
  //
  //     u_nameController.text = u_name;
  //     messageController.text=message;
  //
  //   });
  // }
  _fetchData() async {
    prefs = await SharedPreferences.getInstance();
    user_id = prefs.getInt('user_id')!;
    print(user_id);
    var res = await Api()
        .getData('/api/complaint_single_view/' +user_id.toString());
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
        leading:
        IconButton( onPressed: (){
          Navigator.pop(context);
        },icon:Icon(Icons.arrow_back_ios,size: 20,color: Colors.black,)),
        title: Text("Customer Complaint"),
      ),

      body: SingleChildScrollView(
        physics: ScrollPhysics(),
        child: Column(
          children: [
            ListView.builder(

                physics: NeverScrollableScrollPhysics(),
                itemCount:_loaddata.length,
                shrinkWrap: true,
                itemBuilder: (context, index)
                {
                  int id= _loaddata[index]['id'];
                  return Container(
                    height: 100,
                    child: Card(

                      child: GestureDetector(
                        onTap: () => {

                        },
                        //
                        child: ListTile(

                          // subtitle: Text("24/06/23"),
                            leading: Icon(Icons.message,color: Colors.deepPurple,),
                            title:  Padding(
                              padding: const EdgeInsets.only(top: 8.0),
                              child: Text(
                                _loaddata[index]['u_name'],
                                style: TextStyle(fontWeight: FontWeight.bold,fontSize: 27),
                              ),
                            ),
                            subtitle: Align(
                              alignment: Alignment.centerLeft,
                              child: Column(

                                children: [

                                  Text(_loaddata[index]['complaint']),
                                  Text(_loaddata[index]['date']),
                                ],
                              ),
                            ),
                            trailing: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                primary: Colors.deepPurple,
                              ),
                              onPressed: (){
                                Navigator.push(context, MaterialPageRoute(builder: (context) => Achat2(id:id) ));
                              },
                              child:const Text('Reply'),
                            )
                        ),
                      ),
                    ),
                  );

                }
            ),

          ],
        ),
      ),
    );
  }
}

