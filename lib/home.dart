import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:helloworld/complaint.dart';
import 'package:helloworld/event.dart';
import 'package:helloworld/feedback.dart';

class Homepage extends StatefulWidget {
  const Homepage({Key? key}) : super(key: key);

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  get appBar => null;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(

       /* leading: IconButton(onPressed: () {

        }, icon: Icon(Icons.menu)),*/
        title: Text("HOME"),
      ),

      drawer: Drawer(

        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            UserAccountsDrawerHeader(
              accountName: Text("Sandra PS"),
              accountEmail: Text("sandrapsasankan@gmail.com"),
              currentAccountPicture: CircleAvatar(
                backgroundColor: Colors.purple,
                child: Text("A",
                  style: TextStyle(fontSize: 40.0),
                ),
              ),
            ),
            ListTile(
              leading: Icon(Icons.home,
              ),
              title: const Text('Profile'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: Icon(Icons.home,
              ),
              title: const Text('My Orders'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: Icon(Icons.feedback,
              ),
              title: const Text('Feedback'),
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) =>App()));
              },
            ),
            ListTile(
              leading: Icon(Icons.home,
              ),
              title: const Text('Complaints'),
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) =>complaint()));
              },
            )
          ],
        ),

      ),
      body: Container(child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: GridView(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2, mainAxisSpacing: 10, crossAxisSpacing: 10),

          children: [
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20), color: Colors.cyan,),
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.home, size: 50, color: Colors.white,),
                    TextButton(onPressed: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => const Eventpage()));
                    },
                      child: Text("Event",
                        style: TextStyle(color: Colors.white, fontSize: 30),),
                    )
                  ]
              ),
            ),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20), color: Colors.cyan,),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.home, size: 50, color: Colors.white,),
                  Text("Learning",
                    style: TextStyle(color: Colors.white, fontSize: 30),)
                ],),
            ),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20), color: Colors.cyan,),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.home, size: 50, color: Colors.white,),
                  Text("Product",
                    style: TextStyle(color: Colors.white, fontSize: 30),)
                ],),
            ),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20), color: Colors.cyan,),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.home, size: 50, color: Colors.white,),
                  Text("Chat",
                    style: TextStyle(color: Colors.white, fontSize: 30),)
                ],),
            ),
            Container(decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20), color: Colors.cyan,),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.home, size: 50, color: Colors.white,),
                  Text("Job Apply",
                    style: TextStyle(color: Colors.white, fontSize: 30),)
                ],),
            ),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20), color: Colors.cyan,),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.home, size: 50, color: Colors.white,),
                  Text("Payment ",
                    style: TextStyle(color: Colors.white, fontSize: 30),)
                ],),
            ),
          ],
        ),
      ),
      ),
    );
  }
}