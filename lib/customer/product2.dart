import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:helloworld/api_service/api.dart';
import 'package:helloworld/customer/paintingdetail.dart';
import 'package:shared_preferences/shared_preferences.dart';

class category extends StatefulWidget {
  var id;

  @override
  category({required this.id});
  State<category> createState() => _categoryState();
}

class _categoryState extends State<category> {
  late int productid,artist_id;
  late int id, cid;
  bool _isLoading = false;
  Future AddCart(int productid) async {
    var prefs = await SharedPreferences.getInstance();
    id = (prefs.getInt('user_id') ?? 0);
    print('id ${id}');
    setState(() {
      _isLoading = true;
    });

    var data = {
      "user": id.toString(),
      "product": productid.toString(),
      "quantity": "1",
      "artist": id.toString(),
    };
//   print(data);
    var res = await Api().authData(data, '/api/add_cart');
    var body = json.decode(res.body);
    print(body);
    if (body['success'] == true) {
      //   print(body);
      Fluttertoast.showToast(
        msg: body['message'].toString(),
        backgroundColor: Colors.grey,
      );

      //   Navigator.push(context as BuildContext, MaterialPageRoute(builder: (context)=>View_Comp()));
    } else {
      Fluttertoast.showToast(
        msg: body['message'].toString(),
        backgroundColor: Colors.grey,
      );
    }
  }

  List _loaddata = [];

  _fetchData() async {
    int id = widget.id;
    var res = await Api().getData('/api/allinone_product/' + id.toString());
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
      });
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
      backgroundColor: Color(0xFFFCFAF8),
      body: ListView(
        children: <Widget>[
          SizedBox(height: 15.0),
          Container(
            padding: EdgeInsets.only(right: 15.0),
            width: MediaQuery.of(context).size.width - 30.0,
            height: MediaQuery.of(context).size.height - 30.0,
            child: GridView.builder(
              itemCount: _loaddata.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 4.0,
                  mainAxisSpacing: 4.0),
              itemBuilder: (context, index) {
                productid=_loaddata[index]['id'];
                print("productid${_loaddata[index]['id']}");
                artist_id=_loaddata[index]['id'];
                print("artist_id${_loaddata[index]['id']}");

                return _buildCard(
                  _loaddata[index]['id'],
                  _loaddata[index]['name'],
                  _loaddata[index]['amount'],
                  _loaddata[index]['image'],
                );
              },
            ),
          ),
          SizedBox(height: 15.0)
        ],
      ),
    );
  }

  Widget _buildCard(
    int id,
    String name,
    String price,
    String imgPath,
    /*bool added,
      bool isFavorite, context*/
  ) {
    return Padding(
        padding: EdgeInsets.only(top: 5.0, bottom: 5.0, left: 5.0, right: 5.0),
        child: InkWell(
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => product3(id: id)));
            },
            child: Container(

                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15.0),
                    boxShadow: [
                      BoxShadow(
                          color: Colors.grey.withOpacity(0.2),
                          spreadRadius: 3.0,
                          blurRadius: 5.0)
                    ],
                    color: Colors.white),
                child: Column(children: [
                  Padding(
                      padding: EdgeInsets.all(5.0),
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            IconButton(
                                onPressed: () {

                                  AddCart(productid);
                                },
                                icon: Icon(Icons.shopping_cart))
                          ])),
                  Hero(
                      tag: imgPath,
                      child: Container(
                        height: 60.0,
                        width: 120.0,
                        child: Image.network(Api().url + imgPath),
                      )),
                  SizedBox(height: 6.0),
                  Text(price,
                      style: TextStyle(
                          color: Color(0xFFCC8053),
                          fontFamily: 'Varela',
                          fontSize: 14.0)),
                  Text(name,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                          color: Color(0xFF575E67),
                          fontFamily: 'Varela',
                          fontSize: 14.0)),
                ]))));
  }
}
