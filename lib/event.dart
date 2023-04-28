import 'package:flutter/material.dart';
import 'package:helloworld/showevent.dart';
class Eventpage extends StatefulWidget {
  const Eventpage({Key? key}) : super(key: key);

  @override
  State<Eventpage> createState() => _EventpageState();
}

class _EventpageState extends State<Eventpage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Event")),
      body: ListView.builder(
          itemCount: 10,
          itemBuilder: (context, index)
          {
            index += 1;
            return GestureDetector(
             onTap: () => {
              Navigator.push(context, MaterialPageRoute(builder: (context) =>Showdetails(index: index)))
            },
              child: Container(
                margin: EdgeInsets.all(8),
                padding: EdgeInsets.all(4),
                decoration: BoxDecoration(color: Colors.grey),
                child: ListTile(
                  title: Text(
                    "Event $index",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  subtitle: Text("24/06/23"),
                  leading: Icon(Icons.event,color: Colors.red,),
                  trailing: Icon(Icons.forward,color: Colors.red,
                  ),

                ),
              ),
            );
          }),
    );
  }
}
