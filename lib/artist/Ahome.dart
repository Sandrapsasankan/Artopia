
import 'package:flutter/material.dart';
import 'package:helloworld/artist/Achat.dart';
import 'package:helloworld/artist/Acomplaint.dart';
import 'package:helloworld/artist/Aevent.dart';

import 'package:helloworld/artist/Ajob.dart';
import 'package:helloworld/artist/Alearning1.dart';
import 'package:helloworld/artist/Alearning3.dart';
import 'package:helloworld/artist/Aorder.dart';
import 'package:helloworld/artist/Apayment.dart';
import 'package:helloworld/artist/Aproduct.dart';
import 'package:helloworld/artist/Aprofile.dart';
import 'package:helloworld/customer/chatscreen.dart';
import 'package:helloworld/customer/complaint.dart';
import 'package:helloworld/customer/event.dart';
import 'package:helloworld/customer/feedback.dart';
import 'package:helloworld/customer/job.dart';

import 'package:helloworld/customer/myorder.dart';
import 'package:helloworld/customer/payment.dart';
import 'package:helloworld/customer/product.dart';
import 'package:helloworld/customer/profile.dart';

import 'Adelivery.dart';


class Ahome extends StatefulWidget {
  const Ahome({Key? key}) : super(key: key);

  @override
  State<Ahome> createState() => _AhomeState();
}

class _AhomeState extends State<Ahome> {
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
                              Navigator.push(context, MaterialPageRoute(builder: (context) => Aproduct()));
                            },
                            child: Column(
                              children: [
                                new Image.asset('images/products.png',
                                  height: 90,
                                  width: 150,
                                  alignment: Alignment.center,
                                ),
                                SizedBox(height: 10,),
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
Navigator.push(context, MaterialPageRoute(builder: (context) => Apayment()));
                            },
                            child: Column(
                              children: [
                                new Image.asset('images/payments.png',
                                  height: 90,
                                  width: 150,
                                  alignment: Alignment.center,
                                ),
                                SizedBox(height: 10,),
                                Text('Payment',textAlign: TextAlign.center,style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),)

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
                              Navigator.push(context, MaterialPageRoute(builder: (context) =>Ajob()));
                            },
                            child: Column(
                              children: [

                                new Image.asset('images/jobs.png',
                                  height: 120,
                                  width: 120,
                                  alignment: Alignment.topCenter,fit: BoxFit.cover,
                                ),
                                Spacer(),
                                Text('Jobs',textAlign: TextAlign.center,style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),)

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
Navigator.push(context, MaterialPageRoute(builder: (context) => Achat()));
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
Navigator.push(context, MaterialPageRoute(builder: (context) => Aevent()));
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
                              Navigator.push(context, MaterialPageRoute(builder: (context) => Aorder()));
                            },
                            child: Column(
                              children: [

                                new Image.asset('images/orders.png',
                                  height: 90,
                                  width: 150,
                                  alignment: Alignment.center,
                                ),
                                SizedBox(height: 10,),
                                Text('Orders',textAlign: TextAlign.center,style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold),)

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
                              Navigator.push(context, MaterialPageRoute(builder: (context) => Alearning1()));
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

                      // Container(
                      //   padding: EdgeInsets.all(20),
                      //   decoration: BoxDecoration(
                      //       color: Colors.white,
                      //       borderRadius: BorderRadius.circular(15),
                      //       boxShadow: [
                      //         BoxShadow(
                      //             offset: Offset(0,17),
                      //             blurRadius: 17,
                      //             spreadRadius: -23
                      //         )
                      //       ]
                      //   ),
                      //   child: Material(
                      //     color: Colors.transparent,
                      //     child: InkWell(
                      //       onTap: () {
                      //           Navigator.push(context, MaterialPageRoute(builder: (context) => Adelivery()));
                      //       },
                      //       child: Column(
                      //         children: [
                      //
                      //           new Image.asset('images/video.png',
                      //             height: 90,
                      //             width: 150,
                      //             alignment: Alignment.center,
                      //           ),
                      //           SizedBox(height: 10,),
                      //           Text('Delivery',textAlign: TextAlign.center,style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold),)
                      //
                      //         ],
                      //       ),
                      //     ),
                      //   ),
                      // ),

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
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            UserAccountsDrawerHeader(
              accountName: Text("Artist PS"),
              accountEmail: Text("Artistps@gmail.com"),
              currentAccountPicture: CircleAvatar(
                backgroundColor: Colors.white,
                child: Text(
                  "A",
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
                Navigator.push(context, MaterialPageRoute(builder: (context)=>Ahome()));
              },
            ),
            ListTile(
              leading: Icon(
                Icons.person,
              ),
              title: const Text('Profile'),
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context)=>Aprofile()));
              },
            ),

            ListTile(
              leading: Icon(
                Icons.task,
              ),
              title: const Text('Complaint'),
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context)=>Acomplaint()));
              },
            ),

          ],
        ),
      ),


    );
  }
}