import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:helloworld/api_service/api.dart';
import 'package:helloworld/customer/learning2.dart';
import 'package:helloworld/customer/video.dart';


class learning1 extends StatefulWidget {
  learning1({Key? key}) : super(key: key);
  @override
  State<learning1> createState() => _learning1State();
}

class _learning1State extends State<learning1> {
  late int id = 0;

  List _loaddata = [];

  _fetchData() async {
    var res = await Api().getData('/api/video_all_view');
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
          backgroundColor: Colors.black,
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
    var size = MediaQuery.of(context).size;
    final double itemHeight = (size.height - kToolbarHeight - 400) / 2;
    final double itemWidth = size.width / 2;

    return SafeArea(
        child: Scaffold(
      appBar: AppBar(

        title: Text(
          'Videos',
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
      body:   ListView(
        children: <Widget>[
          SizedBox(height: 15.0),
          Container(
            padding: EdgeInsets.only(right: 8.0,left: 8.0),
            width: MediaQuery.of(context).size.width - 20.0,
            height: MediaQuery.of(context).size.height - 30.0,
          child: GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: (itemWidth / itemHeight),
                  mainAxisSpacing: 4.0),
                                itemCount: _loaddata.length,
                                itemBuilder: (BuildContext ctx, index) {
                                  id = _loaddata[index]['id'];
                                  print("learn id${id}");
                                  return Container(
                                    padding: EdgeInsets.all(20),
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(15),
                                        boxShadow: [
                                          BoxShadow(
                                              offset: Offset(0, 17),
                                              blurRadius: 14,
                                              spreadRadius: -23)
                                        ]),
                                    child: Material(
                                      color: Colors.transparent,
                                      child: InkWell(
                                        onTap: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      VideoPlayerScreens(id:id)));
                                        },
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceAround,
                                          children: [
                                            Image.asset(
                                              "images/videoooooos.png",
                                              width: 90,
                                              height: 90,
                                            ),
                                            Spacer(),
                                            Text(
                                              _loaddata[index]['name'],
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.bold),
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  );
                                }),
        ),],
      ),

                    )

    );
  }
}
