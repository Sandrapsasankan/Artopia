import 'package:flutter/material.dart';
import 'package:helloworld/customer/cart.dart';
import 'package:helloworld/customer/chat.dart';
import 'package:helloworld/customer/chatscreen.dart';
import 'package:helloworld/customer/complaint.dart';
import 'package:helloworld/customer/complaint1.dart';
import 'package:helloworld/customer/event.dart';
import 'package:helloworld/customer/feedback.dart';
import 'package:helloworld/customer/addfeedback.dart';
import 'package:helloworld/customer/filepckprgm.dart';
import 'package:helloworld/customer/job.dart';
import 'package:helloworld/customer/learning1.dart';

import 'package:helloworld/login.dart';
import 'package:helloworld/customer/myorder.dart';
import 'package:helloworld/customer/payment.dart';
import 'package:helloworld/customer/product.dart';
import 'package:helloworld/customer/profile.dart';


class Homescreen extends StatefulWidget {
  const Homescreen({Key? key}) : super(key: key);

  @override
  State<Homescreen> createState() => _HomescreenState();
}

class _HomescreenState extends State<Homescreen> {
  TextEditingController searchController=TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          child:Padding(
            padding:const EdgeInsets.all(20),
            child:
            SingleChildScrollView(
              physics: ScrollPhysics(),
              child: Column(
                children: [
                  Container(
                    alignment: Alignment.center,
                    height: 60,
                    width: MediaQuery.of(context).size.width,
                    decoration:BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(30)),
                      color: Colors.grey[300],
                    ),

                    child: TextField(
                      controller: searchController,
                      decoration: InputDecoration(
                          prefixIcon: Icon(Icons.search),
                          hintText: "Search",
                          border: InputBorder.none
                      ),
                    ),
                  ),

                  GridView.count(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    crossAxisCount: 2,
                    childAspectRatio: .85,
                    crossAxisSpacing: 20,
                    mainAxisSpacing: 20,
                    children: [
                      Container(
                        padding: EdgeInsets.all(20),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(15),
                            boxShadow: [
                              BoxShadow(
                                  offset: Offset(0,17),
                                  blurRadius: 17,
                                  spreadRadius: -23
                              )
                            ]
                        ),
                        child: Material(
                          color: Colors.transparent,
                          child: InkWell(
                            onTap: () {
                              Navigator.push(context, MaterialPageRoute(builder: (context) =>event()));
                            },
                            child: Column(
                              children: [
                                new Image.asset('images/events.jpeg',
                                  height: 90,
                                  width: 150,
                                  alignment: Alignment.center,
                                ),
                                SizedBox(height: 10,),
                                Text('Event',textAlign: TextAlign.center,style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),)

                              ],
                            ),
                          ),
                        ),
                      ),


                      Container(
                        padding: EdgeInsets.all(20),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(15),
                            boxShadow: [
                              BoxShadow(
                                  offset: Offset(0,17),
                                  blurRadius: 17,
                                  spreadRadius: -23
                              )
                            ]
                        ),
                        child: Material(
                          color: Colors.transparent,
                          child: InkWell(
                            onTap: () {
                              Navigator.push(context, MaterialPageRoute(builder: (context) =>product()));
                            },
                            child: Column(
                              children: [

                                new Image.asset('images/products.png',
                                  height: 120,
                                  width: 120,
                                  alignment: Alignment.topCenter,fit: BoxFit.cover,
                                ),
                                Spacer(),
                                Text('Products',textAlign: TextAlign.center,style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),)

                              ],
                            ),
                          ),
                        ),
                      ),



                      Container(
                        padding: EdgeInsets.all(20),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(15),
                            boxShadow: [
                              BoxShadow(
                                  offset: Offset(0,17),
                                  blurRadius: 17,
                                  spreadRadius: -23
                              )
                            ]
                        ),
                        child: Material(
                          color: Colors.transparent,
                          child: InkWell(
                            onTap: () {
                              Navigator.push(context, MaterialPageRoute(builder: (context) =>Cart()));
                            },
                            child: Column(
                              children: [

                                new Image.asset('images/carts.png',
                                  height: 90,
                                  width: 150,
                                  alignment: Alignment.center,
                                ),
                                SizedBox(height: 10,),
                                Text('Cart',textAlign: TextAlign.center,style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),)

                              ],
                            ),
                          ),
                        ),
                      ),

                      Container(
                        padding: EdgeInsets.all(20),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(15),
                            boxShadow: [
                              BoxShadow(
                                  offset: Offset(0,17),
                                  blurRadius: 17,
                                  spreadRadius: -23
                              )
                            ]
                        ),
                        child: Material(
                          color: Colors.transparent,
                          child: InkWell(
                            onTap: () {
                              Navigator.push(context, MaterialPageRoute(builder: (context)=>chat()));
                            },
                            child: Column(
                              children: [

                                new Image.asset('images/chats.png',
                                  height: 90,
                                  width: 150,
                                  alignment: Alignment.center,
                                ),
                                SizedBox(height: 10,),
                                Text('Chat',textAlign: TextAlign.center,style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),)

                              ],
                            ),
                          ),
                        ),
                      ),

                      Container(
                        padding: EdgeInsets.all(20),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(15),
                            boxShadow: [
                              BoxShadow(
                                  offset: Offset(0,17),
                                  blurRadius: 17,
                                  spreadRadius: -23
                              )
                            ]
                        ),
                        child: Material(
                          color: Colors.transparent,
                          child: InkWell(
                            onTap: () {
                              Navigator.push(context, MaterialPageRoute(builder: (context) =>job()));
                            },
                            child: Column(
                              children: [

                                new Image.asset('images/jobs.png',
                                  height: 90,
                                  width: 150,
                                  alignment: Alignment.center,
                                ),
                                SizedBox(height: 10,),
                                Text('Jobs',textAlign: TextAlign.center,style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold),)

                              ],
                            ),
                          ),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.all(20),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(15),
                            boxShadow: [
                              BoxShadow(
                                  offset: Offset(0,17),
                                  blurRadius: 17,
                                  spreadRadius: -23
                              )
                            ]
                        ),
                        child: Material(
                          color: Colors.transparent,
                          child: InkWell(
                            onTap: () {
                              Navigator.push(context, MaterialPageRoute(builder: (context) =>learning1()));
                            },
                            child: Column(
                              children: [

                                new Image.asset('images/video.png',
                                  height: 90,
                                  width: 150,
                                  alignment: Alignment.center,
                                ),
                                SizedBox(height: 10,),
                                Text('Learning',textAlign: TextAlign.center,style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold),)

                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          )







      ),
      appBar: AppBar(
        /*leading: IconButton(onPressed: () {

          }, icon: Icon(Icons.menu)),*/
        title: Text("Home"),
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [Colors.blue, Colors.purple],
            ),
          ),
        ),
        actions: [
          IconButton(
            tooltip: "Logout",
            onPressed: (){
              Navigator.push(context, MaterialPageRoute(builder: (context)=>login()));
            },
            icon: Icon(
              Icons.logout,
              size: 28,
            ),
          )
        ],
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            UserAccountsDrawerHeader(
              accountName: Text("Sandra PS"),
              accountEmail: Text("Sandraps@gmail.com"),
              currentAccountPicture: CircleAvatar(
                backgroundColor: Colors.white,
                child: Text(
                  "S",
                  style: TextStyle(fontSize: 40.0),
                ),
              ),
            ),

            ListTile(
              leading: Icon(
                Icons.home,
              ),
              title: const Text('Home'),
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context)=>Homescreen()));
              },
            ),
            ListTile(
              leading: Icon(
                Icons.person,
              ),
              title: const Text('Profile'),
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context)=>profile()));
              },
            ),
            ListTile(
              leading: Icon(
                Icons.logout,
              ),
              title: const Text('MyOrder'),
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context)=>orders()));
              },
            ),
            ListTile(
              leading: Icon(
                Icons.task,
              ),
              title: const Text('Complaint'),
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context)=>Complaint()));
              },
            ),
            ListTile(
              leading: Icon(
                Icons.feedback,
              ),
              title: const Text('Feedback'),
              onTap: () {
                 Navigator.push(context, MaterialPageRoute(builder: (context)=>feedback()));
              },
            ),

          ],
        ),
      ),


    );
  }
}