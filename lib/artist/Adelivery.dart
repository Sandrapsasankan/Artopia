import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../api_service/api.dart';

class Adelivery extends StatefulWidget {
  const Adelivery({Key? key}) : super(key: key);

  @override
  State<Adelivery> createState() => _AdeliveryState();
}

class _AdeliveryState extends State<Adelivery> {
//
  List _loaddata = [];
  late String Statusdata = "not delivered";
  late String orderstts = "";

  int id = 6;
  fetchData() async {
    var res = await Api().getData('/api/order_all_view');
    if (res.statusCode == 200) {
      var items = json.decode(res.body)['data'];

      print('itemsvfetchata$items');
      setState(() {
        _loaddata = items;
      });
    }

/*
  List _loaddata=[];
  fetchData() async {
    // int id=widget.id;

    var res = await Api()
        .getData('/api/order_all_view/');
    if (res.statusCode == 200) {
      var items = json.decode(res.body)['data'];
      print(items);
      setState(() {
        _loaddata = items;

      });*/
    else {
      setState(() {
        _loaddata = [];
        /*  Fluttertoast.showToast(
          msg:"Currently there is no data available",
          backgroundColor: Colors.grey,
        );*/
      });
    }
  }

  _approveData(int id, String orderstts) async {
    print("items${id}");
    var res = await Api().postData('/api/order_status/' + id.toString());

    print("resssssss${json.decode(res.body)}");

    if (res.statusCode == 200) {
      //var items = json.decode(res.body);
      //print("resssssss${items.data}");

      // Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => cartitemsample()));
      Fluttertoast.showToast(
        msg: "status updated succesfully",
        backgroundColor: Colors.grey,
      );
    } else {
      // cart = [];
      Fluttertoast.showToast(
        msg: "Currently there is no data available",
        backgroundColor: Colors.grey,
      );
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchData();
  }

  String extractFirstThreeWords(String sentence) {
    RegExp regex = RegExp(r'^(\w+\s){0,2}\w+');
    Match match = regex.firstMatch(sentence) as Match;
    return match?.group(0) ?? '';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: Text(
          'Orders',
          style: TextStyle(fontSize: 15),
        ),
      ),
      body: Column(children: [
        Expanded(
          child: ListView.builder(
              itemCount: _loaddata.length,

              // itemCount: name.length,
              itemBuilder: (context, int index) {
                final String sentence =
                    _loaddata[index]['product_name'].toString();

                return Container(
                  height: 180,
                  child: Card(
                      color: Colors.white,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(30),
                            child: Row(
                              children: [
                                Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(_loaddata[index]['product_name']
                                          .toString()),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      Text("price : " +
                                          _loaddata[index]['total_price']
                                              .toString()),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                        children: [
                                          // Text("Date : " +
                                          //     _loaddata[index]['date']),
                                          SizedBox(width: 50,),
                                          ElevatedButton(
                                            onPressed: () async {
                                              await _approveData(
                                                  _loaddata[index]['id'],
                                                  orderstts);
                                              print('completed');
                                              fetchData();
                                              setState(() {});
                                            },
                                            style: ElevatedButton.styleFrom(
                                              primary: Colors.white,
                                            ),
                                            child: _loaddata[index]
                                                        ['order_status'] ==
                                                    "0"
                                                ? Text("Not delivered",
                                                    style: TextStyle(
                                                        fontSize: 10,
                                                        color: Colors.red))
                                                : Text("Delivered",
                                                    style: TextStyle(
                                                        fontSize: 10,
                                                        color: Colors.green)),
                                          )
                                        ],
                                      ),
                                    ]),
                                SizedBox(
                                  width: 60,
                                ),
                              ],
                            ),
                          ),
                        ],
                      )),
                );
              }),
        ),
      ]),
    );
  }
}

//
//             SizedBox(width: 50,),
//      Column(
//      children:[
//        Text("Status: " +
//            _loaddata[index]['order_status'],
//          textAlign: TextAlign.right,
//          style: TextStyle(fontSize: 11,
//              color: Colors.red),)
// ]
//      )
