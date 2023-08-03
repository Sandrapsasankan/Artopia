import 'package:flutter/material.dart';
import 'dart:convert';

import 'package:fluttertoast/fluttertoast.dart';
import 'package:helloworld/api_service/api.dart';
import 'package:helloworld/customer/product2.dart';


class TabLayoutPage extends StatefulWidget {
  const TabLayoutPage({Key? key}) : super(key: key);

  @override
  State<TabLayoutPage> createState() => _TabLayoutPageState();
}

class _TabLayoutPageState extends State<TabLayoutPage>
    with TickerProviderStateMixin {
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
    _tabController = TabController(length: _loaddata.length, vsync: this);

    _tabController.animateTo(2);
    // _tabController = TabController(length: _loaddata.length, vsync: this);
  }






  late TabController _tabController;



   List<Tab> _tabs = [
    Tab(icon: Icon(Icons.looks_one), child: Text('Tap One')),

  ];

   List<Widget> _views = [
    Center(child: Text('Content of Tab One')),

    // Can use any kind of widgets. like image, button, input, etc...
  ];

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: _loaddata.length,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('TabBar & TabBarView'),
          backgroundColor: Colors.green,
          bottom: TabBar(
            labelColor: Colors.white,
            unselectedLabelColor: Colors.grey,
            labelStyle: const TextStyle(fontWeight: FontWeight.bold),
            unselectedLabelStyle: const TextStyle(fontStyle: FontStyle.italic),
            overlayColor:
            MaterialStateColor.resolveWith((Set<MaterialState> state) {
              if (state.contains(MaterialState.pressed)) {
                return Colors.blueAccent;
              }

              if (state.contains(MaterialState.focused)) {
                return Colors.orange;
              } else if (state.contains(MaterialState.hovered)) {
                return Colors.blueAccent;
              }

              return Colors.transparent;
            }),
            indicatorWeight: 5,
            indicatorColor: Colors.amberAccent,
            indicatorSize: TabBarIndicatorSize.tab,
            indicatorPadding: const EdgeInsets.all(5),
            indicator: BoxDecoration(
                border: Border.all(color: Colors.amberAccent),
                borderRadius: BorderRadius.circular(10),
                color: Colors.blueAccent),
            isScrollable: true,
            physics: const BouncingScrollPhysics(),
            onTap: (int index) {
              print('Tab $index you Tapped');
            },
            enableFeedback: true,
            tabs: _tabs,
          ),
        ),
        body:
        ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: _loaddata.length,
            shrinkWrap: true,
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
                      height: 17,
                    ),
                    Text(_loaddata[index]['name'],
                        style: TextStyle(
                          fontFamily: 'Varela',
                          fontSize: 20.0,
                        )),
                  ],
                ),
              );
            }),/*TabBarView(
          children: _views,
          physics: BouncingScrollPhysics(),
        ),*/
      ),
    );
  }
}