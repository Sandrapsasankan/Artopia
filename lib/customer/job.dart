import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:helloworld/api_service/api.dart';
import 'package:helloworld/customer/jobapply.dart';

class job extends StatefulWidget {
  const job({Key? key}) : super(key: key);

  @override
  State<job> createState() => _jobState();
}

class _jobState extends State<job> {
  List _loaddata=[];

  _fetchData() async {
    var res = await Api()
        .getData('/api/job_all_view');
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
        title: const Text('Jobs'),
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
        },icon:Icon(Icons.arrow_back_ios,size: 20,color: Colors.white,)),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            children: [
              // TextField(
              //   keyboardType: TextInputType.text,
              //   // onChanged: (value) => _runFilter(value),
              //   decoration: InputDecoration(
              //     contentPadding:
              //     const EdgeInsets.symmetric(vertical: 10.0, horizontal: 15),
              //     hintText: "Search",
              //     suffixIcon: const Icon(Icons.search),
              //     // prefix: Icon(Icons.search),
              //     border: OutlineInputBorder(
              //       borderRadius: BorderRadius.circular(20.0),
              //       borderSide: const BorderSide(),
              //     ),
              //   ),
              // ),
              // const SizedBox(
              //   height: 15,
              // ),
              Container(
                child:  Column(
                  children: [

                    ListView.builder(
                        physics: NeverScrollableScrollPhysics(),
                        itemCount:_loaddata.length,
                        shrinkWrap: true,
                        itemBuilder: (context, index)
                        {
                          int id= _loaddata[index]['id'];
                          return GestureDetector(
                            onTap: () => {
                            Navigator.push(context, MaterialPageRoute(builder: (context) =>jobapply(id:id)))
                            },
                            child: Container(
                                margin: EdgeInsets.all(8),
                                padding: EdgeInsets.all(4),
                                decoration: BoxDecoration(),
                                child: ListTile(

                                  title: Text(
                                    _loaddata[index]['jobname'],
                                    style: TextStyle(fontWeight: FontWeight.bold,fontSize: 21),
                                  ),
                                  subtitle: Text(_loaddata[index]['description']),

                                  // trailing:
                                  // ElevatedButton(
                                  //   onPressed: () {
                                  //     //
                                  //   },
                                  //   child: const Text('View'),
                                  // ),
                                )
                            ),
                          );

                        }),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }


}
