import 'package:flutter/material.dart';
import 'package:helloworld/artist/Aregister.dart';
import 'package:helloworld/customer/register.dart';
class choose extends StatefulWidget {
  const choose({Key? key}) : super(key: key);

  @override
  State<choose> createState() => _chooseState();
}

class _chooseState extends State<choose> {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        elevation: 0,
        brightness: Brightness.light,
        backgroundColor: Colors.white,
        leading:
        IconButton( onPressed: (){
          Navigator.pop(context);
        },icon:Icon(Icons.arrow_back_ios,size: 20,color: Colors.black,)),
      ),

        body: const MyStatefulWidget(),

    );
  }
}

class MyStatefulWidget extends StatefulWidget {
  const MyStatefulWidget({super.key});

  @override
  State<MyStatefulWidget> createState() => _MyStatefulWidgetState();
}

class _MyStatefulWidgetState extends State<MyStatefulWidget> {
  @override
  Widget build(BuildContext context) {


    return Center(
      child: Column(
        children: [
SizedBox(height: 70,),
          Container(
            height: 220,
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
   Navigator.push(context, MaterialPageRoute(builder: (context) =>register()));
          },
          child: Column(
          children: [
          new Image.asset('images/userm.png',
          height: 90,
          width: 150,
          alignment: Alignment.center,
          ),
          SizedBox(height: 50,),
          Text('USER',textAlign: TextAlign.center,style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),)

          ],
          ),
          ),
          ),
          ),
                SizedBox(height: 60,),
                Container(
                  height: 220,
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
                          Navigator.push(context, MaterialPageRoute(builder: (context) =>Aregister()));
                      },
                      child: Column(
                        children: [
                          new Image.asset('images/artistm.jpeg',
                            height: 90,
                            width: 150,
                            alignment: Alignment.center,
                          ),
                          SizedBox(height: 50,),
                          Text('ARTIST',textAlign: TextAlign.center,style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),)

                        ],
                      ),
                    ),
                  ),
                ),

        ],
      ),
    );
    }
}
