import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:helloworld/api_service/api.dart';
import 'package:shared_preferences/shared_preferences.dart';


class reply extends StatefulWidget {
  final int id;
  const reply({required this.id});

  @override
  State<reply> createState() => _replyState();
}

class _replyState extends State<reply> {


  bool isObscurePassword = true;
  late int user_id;
  //late int agency_id;
  String a_name = "";
  String reply = "";
  late SharedPreferences prefs;
  TextEditingController a_nameController = TextEditingController();
  TextEditingController replyController = TextEditingController();
  List _loaddata = [];


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _viewPro();
    _fetchData();
  }

  int currentTab = 2;

  Future<void> _viewPro() async {
    int id = widget.id;
    print("id${id}");
    prefs = await SharedPreferences.getInstance();
    user_id = (prefs.getInt('user_id') ?? 0);

    print('${user_id }');

    var res = await Api().getData('/api/reply/' + user_id.toString() + '/' + id.toString());

    var body = json.decode(res.body);
    print(body);


    setState(() {
      a_name = body['data']['a_name'];
      reply = body['data']['reply'];


      a_nameController.text = a_name;

      replyController.text = reply;


    });
  }

  _fetchData() async {
    int id = widget.id;
    prefs = await SharedPreferences.getInstance();
    int? userid = prefs.getInt('user_id');

    print(userid);

    var res = await Api()
        .getData('/api/reply/' + userid.toString() + '/' + id.toString ());
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
        backgroundColor: Colors.blue,
        centerTitle: true,
        title: Text("Artist Reply"),
      ),
      body: SingleChildScrollView(
        physics: ScrollPhysics(),
        child: Column(
          children: [
            ListView.builder(
              physics: NeverScrollableScrollPhysics(),
              itemCount: _loaddata.length,
              shrinkWrap: true,
              itemBuilder: (context, index) {
                return ListTile(
                  leading: Icon(Icons.message, color: Colors.red),
                  title: Text(
                    _loaddata[index]['a_name'],
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  subtitle: Text(_loaddata[index]['reply']),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

