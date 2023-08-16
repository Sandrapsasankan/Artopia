import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:helloworld/api_service/api.dart';
import 'package:helloworld/customer/home.dart';
import 'package:helloworld/customer/product2.dart';

void main() => runApp(product());

class product extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();

  void setState(Null Function() param0) {}
}

class _MyHomePageState extends State<MyHomePage>
    with SingleTickerProviderStateMixin {
  List _loaddata = [];

  _fetchData() async {
    var res = await Api().getData('/api/category_all_view');
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

  // late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _fetchData();
    // _tabController = TabController(length: _loaddata.length, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Categories"),
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
          Navigator.push(context, MaterialPageRoute(builder: (context)=>Homescreen()));
        },icon:Icon(Icons.arrow_back_ios,size: 20,color: Colors.black,)),
      ),
      body: GridView.builder(

          itemCount: _loaddata.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2),

          itemBuilder: (context, index) {
            int id = _loaddata[index]['id'];
            return GestureDetector(
              onTap: () => {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => category(id: id)))
              },
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(30.0),
                    child: CircleAvatar(
                      radius: 50,
                      backgroundImage:
                          NetworkImage(Api().url + _loaddata[index]['image']),
                    ),
                  ),
                  SizedBox(
                    width: 45,
                    height: 10,
                  ),
                  Text(_loaddata[index]['name'],
                      style: TextStyle(
                        fontFamily: 'Varela',
                        fontSize: 20.0,
                      )),
                ],
              ),
            );
          }),
    );
  }
}

//
//
//
//           // // scrollDirection: Axis.horizontal,
//           // // padding: EdgeInsets.only(left: 20.0),
//           // // children: <Widget>[
//           // //   SizedBox(height: 15.0),
//           // //   Text('Categories',
//           // //       style: TextStyle(
//           // //           fontFamily: 'Varela',
//           // //           fontSize: 42.0,
//           // //           fontWeight: FontWeight.bold)),
//           // //   SizedBox(height: 15.0),
//           //   Container(
//           //     height: 150,
//           //     child: TabBar(
//           //         controller: _tabController,
//           //         indicatorColor: Colors.transparent,
//           //         labelColor: Color(0xFFC88D67),
//           //         isScrollable: true,
//           //     //    labelPadding: EdgeInsets.only(right: 45.0),
//           //         unselectedLabelColor: Color(0xFFCDCDCD),
//           //         tabs: [
//           //           // Container(
//           //           //   height:150,
//           //           //   child: Tab(
//           //           //       child:
//           //           //       Column(
//           //           //         children: [
//           //           //           CircleAvatar(
//           //           //             //backgroundImage: NetworkImage(Api().url+_loaddata[index]['image']),
//           //           //           ),
//           //           //
//           //           //           SizedBox(height: 20,),
//           //           //           Text('Painting',
//           //           //               style: TextStyle(
//           //           //                 fontFamily: 'Varela',
//           //           //                 fontSize: 20.0,
//           //           //               )),
//           //           //         ],
//           //           //       )
//           //           //
//           //           //   ),
//           //           // ),
//           //
//           //
//           //           Container(
//           //             height:150,
//           //             child: Tab(
//           //                 child:
//           //                 Column(
//           //                   children: [
//           //                     CircleAvatar(
//           //                       backgroundImage: AssetImage("images/unnamed.jpg"),radius: 40,
//           //                       // child:Image.asset('images/unnamed.jpg', width: 18, height: 18,),
//           //                     ),
//           //
//           //                     SizedBox(height: 20,),
//           //                     Text('Sculpture',
//           //                         style: TextStyle(
//           //                           fontFamily: 'Varela',
//           //                           fontSize: 20.0,
//           //                         )),
//           //                   ],
//           //                 )
//           //
//           //             ),
//           //           ),
//           //           Container(
//           //             height:150,
//           //             child: Tab(
//           //                 child:
//           //                 Column(
//           //                   children: [
//           //                     CircleAvatar(
//           //                       backgroundImage: AssetImage("images/unnamed.jpg"),radius: 40,
//           //                       // child:Image.asset('images/unnamed.jpg', width: 18, height: 18,),
//           //                     ),
//           //
//           //                     SizedBox(height: 20,),
//           //                     Text('Handicraft',
//           //                         style: TextStyle(
//           //                           fontFamily: 'Varela',
//           //                           fontSize: 20.0,
//           //                         )),
//           //                   ],
//           //                 )
//           //
//           //             ),
//           //           ),
//           //
//           //           Container(
//           //             height:150,
//           //             child: Tab(
//           //                 child:
//           //                 Column(
//           //                   children: [
//           //                     CircleAvatar(
//           //                       backgroundImage: AssetImage("images/unnamed.jpg"),radius: 40,
//           //                       // child:Image.asset('images/unnamed.jpg', width: 18, height: 18,),
//           //                     ),
//           //
//           //                     SizedBox(height: 20,),
//           //                     Text('Metalwork',
//           //                         style: TextStyle(
//           //                           fontFamily: 'Varela',
//           //                           fontSize: 20.0,
//           //                         )),
//           //                   ],
//           //                 )
//           //
//           //             ),
//           //           ),
//           //
//           //           Container(
//           //             height:150,
//           //             child: Tab(
//           //                 child:
//           //                 Column(
//           //                   children: [
//           //                     CircleAvatar(
//           //                       backgroundImage: AssetImage("images/unnamed.jpg"),radius: 40,
//           //                       // child:Image.asset('images/unnamed.jpg', width: 18, height: 18,),
//           //                     ),
//           //
//           //                     SizedBox(height: 20,),
//           //                     Text('Woodworking',
//           //                         style: TextStyle(
//           //                           fontFamily: 'Varela',
//           //                           fontSize: 20.0,
//           //                         )),
//           //                   ],
//           //                 )
//           //
//           //             ),
//           //           ),
//           //
//           //           Container(
//           //             height:150,
//           //             child: Tab(
//           //                 child:
//           //                 Column(
//           //                   children: [
//           //                     CircleAvatar(
//           //                       backgroundImage: AssetImage("images/unnamed.jpg"),radius: 40,
//           //                       // child:Image.asset('images/unnamed.jpg', width: 18, height: 18,),
//           //                     ),
//           //
//           //                     SizedBox(height: 20,),
//           //                     Text('Printmaking',
//           //                         style: TextStyle(
//           //                           fontFamily: 'Varela',
//           //                           fontSize: 20.0,
//           //                         )),
//           //                   ],
//           //                 )
//           //
//           //             ),
//           //           ),
//           //
//           //           Container(
//           //             height:150,
//           //             child: Tab(
//           //                 child:
//           //                 Column(
//           //                   children: [
//           //                     CircleAvatar(
//           //                       backgroundImage: AssetImage("images/unnamed.jpg"),radius: 40,
//           //                       // child:Image.asset('images/unnamed.jpg', width: 18, height: 18,),
//           //                     ),
//           //
//           //                     SizedBox(height: 20,),
//           //                     Text('Ceramics',
//           //                         style: TextStyle(
//           //                           fontFamily: 'Varela',
//           //                           fontSize: 20.0,
//           //                         )),
//           //                   ],
//           //                 )
//           //
//           //             ),
//           //           ),
//           //
//           //                         ]),
//           //   ),
//           //   Container(
//           //       height: MediaQuery.of(context).size.height - 50.0,
//           //       width: double.infinity,
//           //       child: TabBarView(
//           //           controller: _tabController,
//           //           children: [
//           //             category(),
//           //             category(),
//           //             category(),
//           //             category(),
//           //             category(),
//           //             category(),
//           //             category(),
//           //           ]
//           //       )
//           //   )
//           ],
//           ),
//
//           // bottomNavigationBar: BottomBar(),
//           );
//           }
//
//
// }
