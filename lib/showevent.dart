import 'package:flutter/material.dart';
class Showdetails extends StatelessWidget {
  final int index;
  const Showdetails({Key? key,required this.index}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Event Details"),
        leading: IconButton(icon: Icon(Icons.arrow_back),
        onPressed: () {},),
      ),
      body: Center(
        child: Column(
          children: [
            Image.asset("images/event1.jpg", width: 300,height: 300,),
            SizedBox(height: 40,),
            Expanded(
                child:
            Column(
              children: [
                Expanded(child: Text(
                  'Art gallary and exhibition',
                      style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,),
                )),
                Container(
                  child: Text('The purpose of each art gallery or exhibition is unique and driven by our artists ideas, the context of space, season and the vibes of the region. You can join a group exhibition or book a free private view in the fields of abstract painting, fine arts photography and sculpture. Meet the artists in person by joining an artist talk or an open late free art gallery event and get yourself inspired.'
                ),
            ),

          ],
        ),

    ),
    ]
    ),
    ),
    );
  }
}
