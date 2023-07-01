import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:helloworld/api_service/api.dart';
import 'package:helloworld/artist/Aproduct.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;


class Aaddproducts extends StatefulWidget {
  const Aaddproducts({Key? key}) : super(key: key);

  @override
  _AaddproductsState createState() => _AaddproductsState();
}

class _AaddproductsState extends State<Aaddproducts> {
  late SharedPreferences prefs;
  late int artist_id;
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
  }
  bool _isLoading=false;
  TextEditingController nameController=TextEditingController();
  TextEditingController descController=TextEditingController();
  TextEditingController amountController=TextEditingController();
  TextEditingController dimensionController=TextEditingController();

  TextEditingController colourController=TextEditingController();
  final _formKey = GlobalKey<FormState>();
  // void Addproduct()async {
  //   setState(() {
  //     _isLoading = true;
  //   });
  //
  //
  //   var data = {
  //     "name": nameController.text.trim(),
  //     "description": descController.text.trim(),
  //     "amount": amountController.text.trim(),
  //     "dimension": dimensionController.text.trim(),
  //     "colour": colourController.text.trim(),
  //     // "category": dropdownvalue,
  //     "image":imageFile,
  //   };
  //   print("Product data${data}");
  //   var res = await Api().authData(data, '/api/add_product');
  //   var body = json.decode(res.body);
  //   print('res${res}');
  //   if (body['success'] == true) {
  //     Fluttertoast.showToast(
  //       msg: body['message'].toString(),
  //       backgroundColor: Colors.grey,
  //     );
  //
  //     Navigator.push(
  //         context as BuildContext, MaterialPageRoute(builder: (context) => Aproduct()));
  //   }
  //   else {
  //     Fluttertoast.showToast(
  //       msg: body['message'].toString(),
  //       backgroundColor: Colors.grey,
  //     );
  //   }
  // }

  // Initial Selected Value
  var dropdownvalue ;


  File? imageFile;

  late  final _filename;
  late  final bytes;

  Future<void> _showChoiceDialog(BuildContext context) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text("Choose from"),
            content: SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                  GestureDetector(
                    child: const Text("Gallery"),
                    onTap: () {
                      _getFromGallery();
                      Navigator.pop(context);
                      //  _openGallery(context);
                    },
                  ),
                  SizedBox(height: 10),
                  const Padding(padding: EdgeInsets.all(0.0)),
                  GestureDetector(
                    child: const Text("Camera"),
                    onTap: () {
                      _getFromCamera();

                      Navigator.pop(context);
                      //   _openCamera(context);
                    },
                  ),
                ],
              ),
            ),
          );
        });
  }
  _getFromGallery() async {
    PickedFile? pickedFile = await ImagePicker().getImage(
      source: ImageSource.gallery,
      maxWidth: 1800,
      maxHeight: 1800,
    );
    if (pickedFile != null) {
      setState(()  {

        imageFile = File(pickedFile.path);
        _filename = basename(imageFile!.path);
        final _nameWithoutExtension = basenameWithoutExtension(imageFile!.path);
        final _extenion = extension(imageFile!.path);
        print("imageFile:${imageFile}");
        print(_filename);
        print(_nameWithoutExtension);
        print(_extenion);
      });
    }
  }

  /// Get from Camera
  _getFromCamera() async {
    PickedFile? pickedFile = await ImagePicker().getImage(
      source: ImageSource.camera,
      maxWidth: 1800,
      maxHeight: 1800,
    );
    if (pickedFile != null) {
      setState(() {
        imageFile = File(pickedFile.path);
        //  _filename = basename(imageFile!.path).toString();
        final _nameWithoutExtension = basenameWithoutExtension(imageFile!.path);
        final _extenion = extension(imageFile!.path);
      });
    }
  }
  Future<void> submitForm(String name, String description, String amount, String dimension,String colour,String categ) async {
    var uri = Uri.parse(Api().url+'/api/add_product'); // Replace with your API endpoint

    prefs = await SharedPreferences.getInstance();
    artist_id = (prefs.getInt('user_id') ?? 0 );
    var request = http.MultipartRequest('POST', uri);


    request.fields['name'] = name;
    request.fields['description'] = description;
    request.fields['amount'] = amount;
    request.fields['colour'] = colour;
    request.fields['category'] = categ;
    request.fields['dimension'] = dimension;
    request.fields['artist'] =artist_id.toString();

    print(request.fields);
    final imageStream = http.ByteStream(imageFile!.openRead());
    final imageLength = await imageFile!.length();

    final multipartFile = await http.MultipartFile(
      'image',imageStream,imageLength,
      filename: _filename ,
      // contentType: MediaType('image', 'jpeg'), // Replace with your desired image type
    );
    request.files.add(multipartFile);
    print(_filename);

    final response = await request.send();

    if (response.statusCode == 201) {
      print('Form submitted successfully');
      Navigator.push(
          this.context, MaterialPageRoute(builder: (context) => Aproduct()));
    } else {
      print('Error submitting form. Status code: ${response.statusCode}');
    }
  }

  @override
  Widget build(BuildContext context) {

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
                  labelText: 'Product Name',
                  hintText: 'Product Name',
                ),
              ),
            ),

            Container(
              padding: const EdgeInsets.all(10),
              child: TextField(
                controller: amountController,
                decoration: const InputDecoration(

                  border: OutlineInputBorder(),
                  labelText: 'Product Price',
                  hintText: 'Product Price',
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.all(10),
              child: TextField(
                controller: descController,
                decoration: const InputDecoration(

                  border: OutlineInputBorder(),
                  labelText: 'Product Description',
                  hintText: 'Product Description',
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.all(10),
              child: TextField(
                controller: dimensionController,
                decoration: const InputDecoration(

                  border: OutlineInputBorder(),
                  labelText: 'Product Dimension',
                  hintText: 'Product Dimension',
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.all(10),
              child: TextField(
                controller: colourController,
                decoration: const InputDecoration(

                  border: OutlineInputBorder(),
                  labelText: 'Product Colour',
                  hintText: 'Product Colour',
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
            SizedBox(height: 20,),
            Container(

              child: imageFile == null
                  ? Container(
                child: Column(
                  children: <Widget>[
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: Colors.deepPurple,
                      ),
                      onPressed: () {
                        //    _getFromGallery();
                        _showChoiceDialog(context);
                      },
                      child: Text("Upload Image"),
                    ),
                    Container(
                      height: 40.0,
                    ),

                  ],
                ),
              ): Row(
                children: [
                  Container(
                    alignment: Alignment.centerLeft,
                    child: Image.file(
                      imageFile!,
                      width: 100,
                      height: 100,
                      //  fit: BoxFit.cover,
                    ),
                  ), ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: Colors.deepPurple,
                    ),
                    onPressed: () {
                      //    _getFromGallery();
                      _showChoiceDialog(context);
                    },
                    child: Text("Upload Image"),
                  ),
                ],
              ),
            ),
            SizedBox(height: 88,),
            SizedBox(
              height: 60,
              width: 350,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: Colors.deepPurple,
                ),
                child: const Text('Submit',style: TextStyle(fontSize: 25),),
                onPressed: () {
                  submitForm(nameController.text,descController.text,amountController.text,dimensionController.text,colourController.text,dropdownvalue);
                },
              ),
            ),

          ],
        ),
      ),

    );
  }

}



