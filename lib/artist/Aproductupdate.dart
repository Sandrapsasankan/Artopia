
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http ;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:helloworld/api_service/api.dart';
import 'package:helloworld/artist/Adddrop.dart';
import 'package:helloworld/artist/Aproduct.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';
import 'package:shared_preferences/shared_preferences.dart';


class Aproductupdate extends StatefulWidget {
  final int id;

  Aproductupdate({required this.id});

  @override
  State<Aproductupdate> createState() => _AproductupdateState();
}

class _AproductupdateState extends State<Aproductupdate> {
  List _loaddata=[];

  _fetchData() async {
    var res = await Api()
        .getData('/api/category_all_view');
    if (res.statusCode == 200) {
      var items = json.decode(res.body)['data'];
      print(items);
      setState(() {
        _loaddata = items;

      });
    } else {
      setState(() {
        _loaddata = [];
        Fluttertoast.showToast(
          msg:"Currently there is no data available",
          backgroundColor: Colors.grey,
        );
      });
    }
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _fetchData();
    _viewPro();
  }
  late int id;
  String name='';
  String description='';
  String dimension='';
  String amount='';
  String colour='';
  String category='';

  late SharedPreferences prefs;
  TextEditingController nameController=TextEditingController();
  TextEditingController descController=TextEditingController();
  TextEditingController dimensionController=TextEditingController();
  TextEditingController amountController=TextEditingController();
  TextEditingController colourController=TextEditingController();


  int currentTab = 2;
  Future<void> _viewPro() async {
    int id=widget.id;
    var res = await Api()
        .getData('/api/product_single_view/'+id.toString());
    var body = json.decode(res.body);
    print(body);
    setState(() {
      name = body['data']['name'];
      description = body['data']['description'];
      amount = body['data']['amount'];
      dimension = body['data']['dimension'];
      colour = body['data']['colour'];


      nameController.text = name;
      descController.text=description;
      amountController.text=amount;
      dimensionController.text=dimension;
      colourController.text=colour;

    });
  }




  // Initial Selected Value
  Future<void> _update(String name,String description, String amount,String colour,String dimension,String category) async {
    int id=widget.id;
    prefs = await SharedPreferences.getInstance();

    var uri = Uri.parse(Api().url+'/api/product_update_view/'+id.toString()); // Replace with your API endpoint

    // var http;
    var request = http.MultipartRequest('PUT', uri);
    request.fields['name'] = name;
    request.fields['description'] = description;
    request.fields['amount'] = amount;
    request.fields['colour'] = colour;
    request.fields['category'] = category;
    request.fields['dimension'] = dimension;



    print(request.fields);


    final response = await request.send();


    if (response.statusCode == 200) {
      print('Product Updated successfully');
      Navigator.push(
          this.context, MaterialPageRoute(builder: (context) => Aproduct()));
    } else {
      print('Error Updating event. Status code: ${response.statusCode}');
    }
  }

  _deleteData(int id) async {
    var res = await Api().deleteData('/api/delete_product/'+ id.toString());
    if (res.statusCode == 200) {
      setState(() {
        Navigator.pushReplacement(
            context as BuildContext, MaterialPageRoute(builder: (context) => Aproduct()));
        Fluttertoast.showToast(
          msg: "Event Deleted Successfully",
          backgroundColor: Colors.grey,
        );
      });
    } else {
      setState(() {
        Fluttertoast.showToast(
          msg: "Currently there is no data available",
          backgroundColor: Colors.grey,
        );
      });
    }
  }



  @override
  Widget build(BuildContext context) {

    var dropdownvalue;
    return Scaffold(
      appBar: AppBar(
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [Colors.blue, Colors.purple],
            ),
          ),
        ),
        leading:
        IconButton(onPressed: () {
          Navigator.pop(context);
        }, icon: Icon(Icons.arrow_back_ios, size: 20, color: Colors.black,)),
        title: Text('Add product'),
      ),
      body: SingleChildScrollView(
        child: Column(

          children: [
            SizedBox(height: 20,),
            Container(
              padding: const EdgeInsets.all(10),
              child: TextField(
                controller: nameController,
                decoration: const InputDecoration(

                  border: OutlineInputBorder(),


                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.all(10),
              child: TextField(
controller: amountController,
                decoration: const InputDecoration(

                  border: OutlineInputBorder(),

                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.all(10),
              child: TextField(
controller: descController,
                decoration: const InputDecoration(

                  border: OutlineInputBorder(),


                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.all(10),
              child: TextField(
controller: dimensionController,
                decoration: const InputDecoration(

                  border: OutlineInputBorder(),


                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.all(10),
              child: TextField(
controller: colourController,
                decoration: const InputDecoration(

                  border: OutlineInputBorder(),


                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: SizedBox(
                width: double.maxFinite,
                child: DropdownButtonFormField<String>(
                    decoration: InputDecoration(
                      disabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5)) ,
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5)),
                    ),
                    hint: Text('Categories'),
                    value: dropdownvalue,
                    items: _loaddata
                        .map((type) => DropdownMenuItem<String>(
                      value: type['id'].toString(),
                      child: Text(
                        type['name'].toString(),
                        style: TextStyle(color: Colors.black),
                      ),
                    ))
                        .toList(),
                    onChanged: (type) {
                      setState(() {
                        dropdownvalue = type!;
                      });
                    }),
              ),
            ),

            SizedBox(height: 70,),
            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  ElevatedButton(
                    onPressed: (){
                      _update(nameController.text,descController.text,amountController.text,colourController.text,dimensionController.text,dropdownvalue);
                    },
                    child: Text("Edit",style: TextStyle(fontSize: 15, letterSpacing: 2, color: Colors.white),),
                    style: ElevatedButton.styleFrom(
                        primary: Colors.deepPurple,
                        padding: EdgeInsets.symmetric(horizontal: 50,vertical: 25,),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20))
                    ),
                  ),

                  ElevatedButton(
                    onPressed: (){
                      _deleteData(widget.id);
                    },
                    child: Text("Delete",style: TextStyle(fontSize: 15, letterSpacing: 2, color: Colors.white),),
                    style: ElevatedButton.styleFrom(
                        primary: Colors.deepPurple,
                        padding: EdgeInsets.symmetric(horizontal: 50,vertical: 25,),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20))
                    ),
                  ),


                ],
              ),
            )


          ],
        ),
      ),

    );
  }

}


