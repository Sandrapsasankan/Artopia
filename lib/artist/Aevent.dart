import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:helloworld/api_service/api.dart';
import 'package:helloworld/artist/Aeventedit.dart';
import 'package:helloworld/artist/Aeventpage.dart';
class Aevent extends StatefulWidget {
  const Aevent({Key? key}) : super(key: key);

  @override
  State<Aevent> createState() => _AeventState();
}

class _AeventState extends State<Aevent> {
  List _loaddata=[];

  _fetchData() async {
    var res = await Api()
        .getData('/api/event_all_view');
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
          msg:"Currently there is no data available",
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
          title: Text("Events"),
        // actions:[
        //   IconButton(icon: Icon(Icons.add), onPressed: () {
        //     Navigator.push(context, MaterialPageRoute(builder: (context) => Aeventpage())); },)
        // ],),),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [

            ListView.builder(
                itemCount:_loaddata.length,
                shrinkWrap: true,
                itemBuilder: (context, index)
                {
                  int id=_loaddata[index]['id'];
                  return GestureDetector(
                    onTap: () => {

                    },
                    child: Container(
                      margin: EdgeInsets.all(8),
                      padding: EdgeInsets.all(4),
                      decoration: BoxDecoration(),
                      child: ListTile(
                        leading: CircleAvatar(

                          backgroundColor: Colors.green,
                          backgroundImage:
                         NetworkImage(Api().url+_loaddata[index]['image']),

                        ) ,
                        title: Text(
                            _loaddata[index]['name'],
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        subtitle: Text(_loaddata[index]['place']),

                        trailing:
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: Colors.deepPurple,
                  ),
                onPressed: () {


                Navigator.push(context, MaterialPageRoute(builder: (context) => Aeventedit(id:id) ));
                },
                child: const Text('Update'),
                  ),
                        )
                      ),
                    );

                }),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
      floatingActionButton: FloatingActionButton(
        child:  Icon(Icons.add),
        backgroundColor: Colors.deepPurple,
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) => Aeventpage()));

        },
      ),
    );
  }
}
