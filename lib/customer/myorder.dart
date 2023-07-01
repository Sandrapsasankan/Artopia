import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:helloworld/api_service/api.dart';
import 'package:shared_preferences/shared_preferences.dart';



class orders extends StatefulWidget {
  const orders({Key? key}) : super(key: key);

  @override
  State<orders> createState() => _ordersState();
}

class _ordersState extends State<orders> {

  List _loaddata = [];
  late SharedPreferences prefs;
  bool isLoading = false;







  _fetchOrder() async {

    prefs = await SharedPreferences.getInstance();
    int? user = prefs.getInt('user_id');
    print(user);

    var res = await Api()
        .getData('/api/order_single_view/'+user.toString());
    if (res.statusCode == 200) {
      var body = json.decode(res.body);

      var items = json.decode(res.body)['data'];
      print("order Items${items}");
      setState(() {
        _loaddata = items;
      });
    } else {
      _loaddata = [];
      Fluttertoast.showToast(
        msg:"Currently there is no data available",
        backgroundColor: Colors.grey,
      );
    }
    /*prefs = await SharedPreferences.getInstance();
    int? userid = prefs.getInt('user_id');
    print(userid);
    // print('c_id ${Category}');
    var res = await Api().getData('api/order_all_view/');
    print(json.decode(res.body));
    print('success');

    // late int id = widget.id;



    if (res.statusCode == 200) {
      var body = json.decode(res.body);

      var items = json.decode(res.body)['data'];
      print("order Items${items}");
      setState(() {
        print('hello');
        order = items;


      });
    } else {
      order = [];
      Fluttertoast.showToast(
        msg:"Currently there is no data available",
        backgroundColor: Colors.grey,
      );
    }*/
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();


    _fetchOrder();
  }




  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          toolbarHeight: 60,
          backgroundColor: Colors.greenAccent,

          title: Text("My orders"),
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
        body:

        Padding(
          padding: const EdgeInsets.all(20.0),
          child: ListView.builder(

              shrinkWrap: true,
              itemCount:_loaddata.length,
              itemBuilder: (BuildContext context, int index){
                int id=_loaddata[index]['id'];

                return Card(
                    margin: const EdgeInsets.all(20),
                child: SizedBox(
width: 250,
                height: 100,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [

                          CircleAvatar(
                            backgroundColor: Colors.white,
                            radius: 40,

                            child: Image(image: NetworkImage(Api().url+ _loaddata[index]['image'])),
                          ),
                          SizedBox(width: 20,),
                          Column(
                            children: [
                              SizedBox(height: 20,),
                              Text(_loaddata[index]['product_name'].toString(),),
                              SizedBox(height: 8,),

                              Text("delivered on: "+_loaddata[index]['date'].toString(),style: TextStyle(fontSize: 10)),
                              SizedBox(height: 8,),
                            ],
                          ),
                        ],
                      ),




                    ],
                  ),
                )
                );

              }
          ),
        )
    );
  }
}