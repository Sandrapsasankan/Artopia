import 'package:flutter/material.dart';
class learning extends StatefulWidget {
  const learning({Key? key}) : super(key: key);

  @override
  State<learning> createState() => _learningState();
}

class _learningState extends State<learning> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Learning Space'),
          leading:
          IconButton( onPressed: (){
            Navigator.pop(context);
          },icon:Icon(Icons.arrow_back_ios,size: 20,color: Colors.black,)),),
      body: Center(
        child:
        Column(

          children: [
            Align(
              alignment: Alignment.topLeft,
            ),
            Image.asset("images/paint.jpeg"),
            Text('artistic'),
          ],
        ),
      ),

    );
  }
}
