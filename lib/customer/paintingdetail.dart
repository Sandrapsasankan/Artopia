import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:helloworld/api_service/api.dart';
import 'package:shared_preferences/shared_preferences.dart';


class product3 extends StatefulWidget {
  final int id;

  product3({required this.id});
  @override
  State<product3> createState() => _product3State();
}

class _product3State extends State<product3> {
  late int id,productid;
  bool   _isLoading = false;
  late SharedPreferences localStorage;
  TextEditingController nameController=TextEditingController();
  TextEditingController descController=TextEditingController();
  TextEditingController dimensionController=TextEditingController();
  TextEditingController amountController=TextEditingController();
  TextEditingController colourController=TextEditingController();


  String name='',amount='',description='',dimension='',colour='',image='';
  Future AddCart(int productid) async {
    var prefs = await SharedPreferences.getInstance();
    id = (prefs.getInt('user_id') ?? 0);
    print('id ${id}');
    setState(() {
      _isLoading = true;
    });

    var data = {
      "user": id.toString(),
      "product": productid.toString(),
      "quantity": "1",
      "artist": id.toString(),
    };
//   print(data);
    var res = await Api().authData(data, '/api/add_cart');
    var body = json.decode(res.body);
    print(body);
    if (body['success'] == true) {
      //   print(body);
      Fluttertoast.showToast(
        msg: body['message'].toString(),
        backgroundColor: Colors.grey,
      );

      //   Navigator.push(context as BuildContext, MaterialPageRoute(builder: (context)=>View_Comp()));
    } else {
      Fluttertoast.showToast(
        msg: body['message'].toString(),
        backgroundColor: Colors.grey,
      );
    }
  }

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
              height: 200,
              width: 250,
              child: Image(image: NetworkImage(Api().url+image)),
            ),

           // SizedBox(height: 20.0),
            Padding(
              padding: const EdgeInsets.only(left: 18.0,right: 8.0,top: 20.0),
              child: Row(
                children: [
                  Text("Amount :     Rs.", style: TextStyle(
                    fontFamily: 'Varela',
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,)),

                  Text(amount,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontFamily: 'Varela',
                        fontSize: 16.0,
                        color: Colors.black,)
                  ),
                ],
              ),
            ),

           // SizedBox(height: 20.0),
            Padding(
              padding: const EdgeInsets.only(left: 18.0,right: 8.0,top: 20.0),
              child: Row(
                children: [
                  Text("Dimension :", style: TextStyle(
                    fontFamily: 'Varela',
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,)),
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
            ),
            SizedBox(height: 20.0),
            Padding(
              padding: const EdgeInsets.only(left: 18.0,right: 8.0,top: 8.0),
              child: Row(
                children: [
                  Text("Colour :", style: TextStyle(
                    fontFamily: 'Varela',
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,)),
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
            ),

            Padding(
              padding: const EdgeInsets.only(left: 18.0,right: 8.0,top: 20.0),
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
            SizedBox(height: 100.0),
           Padding(
             padding: const EdgeInsets.all(8.0),
             child: Material(
               color: Colors.deepPurple,
               child: InkWell(
                 onTap: () {
                   AddCart(productid);
                 },
                 child: const SizedBox(
                   height: kToolbarHeight,
                   width: double.infinity,
                   child: Center(
                     child: Text(
                       ' Add to Cart',
                       style: TextStyle(fontSize: 18,
                         color: Colors.white,
                         fontWeight: FontWeight.bold,
                       ),
                     ),
                   ),
                 ),
               ),
             ),
           ),
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