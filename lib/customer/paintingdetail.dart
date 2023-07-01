import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:helloworld/api_service/api.dart';
import 'package:shared_preferences/shared_preferences.dart';


class product3 extends StatefulWidget {
  final int id;

  product3({required this.id});
  @override
  State<product3> createState() => _product3State();
}

class _product3State extends State<product3> {
  bool   _isLoading = false;
  late SharedPreferences localStorage;
  TextEditingController nameController=TextEditingController();
  TextEditingController descController=TextEditingController();
  TextEditingController dimensionController=TextEditingController();
  TextEditingController amountController=TextEditingController();
  TextEditingController colourController=TextEditingController();


  String name='',amount='',description='',dimension='',colour='',image='';

  Future<void> _viewPro() async {
    int id = widget.id;
    var res = await Api()
        .getData('/api/product_single_view/' + id.toString());
    var body = json.decode(res.body);
    print(body);
    setState(() {
      name = body['data']['name'];
      amount = body['data']['amount'];
      description = body['data']['description'];
      dimension = body['data']['dimension'];
      colour = body['data']['colour'];
      image = body['data']['image'];




      nameController.text = name;
      descController.text=description;
      amountController.text=amount;
      dimensionController.text=dimension;
      colourController.text=colour;

    });
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _viewPro();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Product Details"),
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [Colors.blue, Colors.purple],
            ),
          ),
        ),

        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Color(0xFF545D68)),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),

        // actions: <Widget>[
        //
        // ],
      ),

      body: ListView(
          children: [
            SizedBox(height: 25.0),
            Padding(
              padding: EdgeInsets.only(left: 20.0),
              child: Text(
                  name,
                  style: TextStyle(
                      fontFamily: 'Varela',
                      fontSize: 28.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.deepPurple)
              ),
            ),
           // SizedBox(height: 16,),
            Container(
              height: 170,
              width: 200,
              child: Image(image: NetworkImage(Api().url+image)),
            ),

           // SizedBox(height: 20.0),
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Text("Amount :     Rs.", style: TextStyle(
                    fontFamily: 'Varela',
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,)),
                ),

                Text(amount,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontFamily: 'Varela',
                      fontSize: 16.0,
                      color: Colors.black,)
                ),
              ],
            ),

           // SizedBox(height: 20.0),
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Text("Dimension :", style: TextStyle(
                    fontFamily: 'Varela',
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,)),
                ),
                SizedBox(width: 10.0),
                Text(dimension,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontFamily: 'Varela',
                      fontSize: 16.0,
                      color: Colors.black,)
                ),
              ],
            ),
            SizedBox(height: 20.0),
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Text("Colour :", style: TextStyle(
                    fontFamily: 'Varela',
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,)),
                ),
                SizedBox(width: 10.0),
                Text(colour,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontFamily: 'Varela',
                      fontSize: 16.0,
                      color: Colors.black,)
                ),
              ],
            ),
            SizedBox(height: 20.0),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Text("Description :", style: TextStyle(
                fontFamily: 'Varela',
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
                color: Colors.black,)),
            ),
            SizedBox(height: 10.0),
            Text(description,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: 'Varela',
                  fontSize: 16.0,
                  color: Colors.black,)
            ),
            SizedBox(height: 50.0),
            Center(
                child: Container(
                    width: MediaQuery.of(context).size.width - 50.0,
                    height: 50.0,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(25.0),
                        color: Colors.deepPurple
                    ),
                    child: Center(
                        child: Text('Add to cart',
                          style: TextStyle(
                              fontFamily: 'Varela',
                              fontSize: 14.0,
                              fontWeight: FontWeight.bold,
                              color: Colors.white
                          ),
                        )
                    )
                )
            )
          ]
      ),

      // floatingActionButton: FloatingActionButton(onPressed: () {},
      //   backgroundColor: Color(0xFFF17532),
      //   child: Icon(Icons.fastfood),
      // ),
      // floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      // bottomNavigationBar: BottomBar(),
    );
  }
}