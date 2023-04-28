import 'package:flutter/material.dart';
class complaint extends StatefulWidget {
  const complaint({Key? key}) : super(key: key);

  @override
  State<complaint> createState() => _complaintState();
}

class _complaintState extends State<complaint> {

  @override
  Widget build(BuildContext context) {
    var size;
    return   Scaffold(

      appBar: AppBar(
        title: Text('FeedBack'),
      ),

      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: size.height*.35,
              child:
              Image.asset('image/feedback.jpg',
                fit: BoxFit.cover,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 12,right: 12,top: 20),
              child: Container(
                height: 350.0,
                child: Stack(
                  children: [
                    TextField(
                      maxLines: 10,
                      decoration: InputDecoration(
                        hintText: 'Please briefly describe the issue',
                        hintStyle: TextStyle(
                            fontSize: 15,
                            color: Colors.grey
                        ),
                        border: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey),
                        ),

                      ),
                    ),



                    Align(
                      alignment: Alignment.bottomCenter,
                      child: Container(
                        child: ElevatedButton(
                          onPressed: (){

                          },
                          child: Text('Submit',style: TextStyle(fontSize: 19),),
                          style: ElevatedButton.styleFrom(fixedSize: Size(230, 55),shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(29.0))),
                        ),
                      ),
                    )
                  ],
                ),

              ),


            ),
          ],
        ),
      ),

    );
  }
}


