import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:helloworld/api_service/api.dart';
import 'package:helloworld/artist/Aevent.dart';
import 'package:helloworld/login.dart';
import 'package:helloworld/customer/home.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../register.dart';

class Aeventpage extends StatefulWidget {
  @override
  State<Aeventpage> createState() => _AeventpageState();
}

class _AeventpageState extends State<Aeventpage> {
  DateTime selectedDate = DateTime.now();
  late SharedPreferences prefs;
  late String startDate;
  late int artist_id;
  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime.now(),
        lastDate: DateTime(2101));
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
        startDate =
        '${selectedDate.year}-${selectedDate.month}-${selectedDate.day}';
      });
    }
  }
  bool _isLoading=false;
  TextEditingController nameController=TextEditingController();
  TextEditingController descController=TextEditingController();
  TextEditingController placeController=TextEditingController();
  TextEditingController dateController=TextEditingController();
  TextEditingController timeController=TextEditingController();
  final _formKey = GlobalKey<FormState>();
  // void AddEvent()async {
  //   setState(() {
  //     _isLoading = true;
  //   });
  //
  //
  //   var data = {
  //     "name": nameController.text.trim(),
  //     "description": descController.text.trim(),
  //     "place": placeController.text.trim(),
  //     "date": startDate,
  //     "time": timeController.text.trim(),
  //   };
  //   print("Event data${data}");
  //   var res = await Api().authData(data, '/api/add_event');
  //   var body = json.decode(res.body);
  //   print('res${body}');
  //   if (body['success'] == true) {
  //     Fluttertoast.showToast(
  //       msg: body['message'].toString(),
  //       backgroundColor: Colors.grey,
  //     );
  //
  //     Navigator.push(
  //         context as BuildContext, MaterialPageRoute(builder: (context) => Aevent()));
  //   }
  //   else {
  //     Fluttertoast.showToast(
  //       msg: body['message'].toString(),
  //       backgroundColor: Colors.grey,
  //     );
  //   }
  // }
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
  Future<void> submitForm(String name, String description, String place,
      String time) async {
   var uri = Uri.parse(Api().url+'/api/add_event'); // Replace with your API endpoint

   prefs = await SharedPreferences.getInstance();
   artist_id = (prefs.getInt('user_id') ?? 0 );
    var request = http.MultipartRequest('POST', uri);


    request.fields['name'] = name;
    request.fields['description'] = description;
    request.fields['place'] = place;
    request.fields['date'] = startDate;
   request.fields['time'] = time;
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
          this.context, MaterialPageRoute(builder: (context) => Aevent()));
    } else {
      print('Error submitting form. Status code: ${response.statusCode}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
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
        title:Text ('Add Event'),
        leading:
        IconButton( onPressed: (){
          Navigator.pop(context);
        },icon:Icon(Icons.arrow_back_ios,size: 20,color: Colors.black,)),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            height: MediaQuery.of(context).size.height,
            width: double.infinity,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    // Column(
                    //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    //   children: [
                    //   Text('Event Details'),
                    //   ],
                    // ),

                    Container(
                      padding: const EdgeInsets.all(10),
                      child: TextField(
                        controller: nameController,
                        decoration: const InputDecoration(

                          border: OutlineInputBorder(),
                          labelText: 'Event Name',
                          hintText: 'Event Name'
                        ),
                      ),
                    ),

                      Container(
                        padding: const EdgeInsets.all(10),
                        child: TextField(
                          maxLines: 5,
                          controller: descController,
                          decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: 'Event Description',
                              hintText: 'Event Description',
                          ),
                        ),

                    ),
                    Container(
                      padding: const EdgeInsets.all(10),
                      child: TextField(
                        controller: placeController,
                        decoration: const InputDecoration(

                            border: OutlineInputBorder(),
                            labelText: 'Event Place',
                            hintText: 'Event Place'
                        ),
                      ),
                    ),
                    Container(
                      padding:  const EdgeInsets.all(20.0),
                      child: Row(
                        children: [
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              primary: Colors.deepPurple,
                            ),
                            onPressed: () => _selectDate(context),
                            child: const Text('Select date'),
                          ),SizedBox(width: 20,),
                          Container(
                            height: 45,
                            width: 150,
                            margin: const EdgeInsets.all(15.0),
                            padding: const EdgeInsets.all(3.0),
                            decoration: BoxDecoration(
                                border: Border.all(color: Colors.black26)),
                            child: Padding(
                              padding: const EdgeInsets.only(top: 8.0),
                              child: Text(
                                '${selectedDate.day}-${selectedDate.month}-${selectedDate.year}',
                                style: TextStyle(fontSize: 16, color: Colors.black38),
                              ),
                            ),
                          ),

                        ],
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.all(10),
                      child: TextField(
                        controller: timeController,
                        decoration: const InputDecoration(

                          border: OutlineInputBorder(),
                          labelText: 'Event Time',
                          hintText: 'Event Time',
                        ),
                      ),
                    ),
                    SizedBox(height: 30,),
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
                            onPressed: () {
                              //    _getFromGallery();
                              _showChoiceDialog(context);
                            },
                            child: Text("Upload Image"),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 90,),
                    SizedBox(
                      height: 50,
                      width: 350,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          primary: Colors.deepPurple,
                        ),
                        child: const Text('Submit',style: TextStyle(fontSize: 20),),
                        onPressed: () {
                          submitForm(nameController.text,descController.text,placeController.text,timeController.text);
                        },
                      ),
                    ),


                  ],
                ),
              ],
            ),
          ),
        ),
      ),);
  }



Widget makeInput({label,obsureText = false}){
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(label,style:TextStyle(
          fontSize: 15,
          fontWeight: FontWeight.w400,
          color: Colors.black87
      ),),
      SizedBox(height: 5,),
      TextField(
        obscureText: obsureText,
        decoration: InputDecoration(
          contentPadding: EdgeInsets.symmetric(vertical: 0,horizontal: 10),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.grey,
            ),
          ),
          border: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.grey)
          ),
        ),
      ),
      SizedBox(height: 30,)

    ],
  );
}



}
