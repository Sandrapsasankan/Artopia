import 'dart:convert';
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:helloworld/api_service/api.dart';
import 'package:helloworld/artist/Ahome.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
void main() {
  runApp(const alearning());
}

class alearning extends StatefulWidget {

  const alearning({super.key});

  @override
  State<alearning> createState() => _alearningState();
}

class _alearningState extends State<alearning> {
  String? filePath;
  File? galleryFile;

  final picker = ImagePicker();
  late SharedPreferences prefs;
  late int artist_id;
  List _loaddata=[];



  Future<String?> pickVideo() async {


    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.video,
        allowMultiple: false,
      );

      if (result != null) {
        PlatformFile file = result.files.first;
        filePath = file.path;
        print(filePath);
      }
    } catch (e) {
      print('Error while picking video: $e');
    }

    return filePath;
  }









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

  final _formKey = GlobalKey<FormState>();

  var dropdownvalue ;


  File? imageFile;

  late  final _filename;
  late  final bytes;

  // Future<void> _showChoiceDialog(BuildContext context) {
  //   return showDialog(
  //       context: context,
  //       builder: (BuildContext context) {
  //         return AlertDialog(
  //           title: const Text("Choose from"),
  //           content: SingleChildScrollView(
  //             child: ListBody(
  //               children: <Widget>[
  //                 GestureDetector(
  //                   child: const Text("Gallery"),
  //                   onTap: () {
  //                     _getFromGallery();
  //                     Navigator.pop(context);
  //                     //  _openGallery(context);
  //                   },
  //                 ),
  //                 SizedBox(height: 10),
  //                 const Padding(padding: EdgeInsets.all(0.0)),
  //                 GestureDetector(
  //                   child: const Text("Camera"),
  //                   onTap: () {
  //                     _getFromCamera();
  //
  //                     Navigator.pop(context);
  //                     //   _openCamera(context);
  //                   },
  //                 ),
  //               ],
  //             ),
  //           ),
  //         );
  //       });
  // }
  // _getFromGallery() async {
  //   PickedFile? pickedFile = await ImagePicker().getImage(
  //     source: ImageSource.gallery,
  //     maxWidth: 1800,
  //     maxHeight: 1800,
  //   );
  //   if (pickedFile != null) {
  //     setState(()  {
  //
  //       imageFile = File(pickedFile.path);
  //       _filename = basename(imageFile!.path);
  //       final _nameWithoutExtension = basenameWithoutExtension(imageFile!.path);
  //       final _extenion = extension(imageFile!.path);
  //       print("imageFile:${imageFile}");
  //       print(_filename);
  //       print(_nameWithoutExtension);
  //       print(_extenion);
  //     });
  //   }
  // }
  //
  // /// Get from Camera
  // _getFromCamera() async {
  //   PickedFile? pickedFile = await ImagePicker().getImage(
  //     source: ImageSource.camera,
  //     maxWidth: 1800,
  //     maxHeight: 1800,
  //   );
  //   if (pickedFile != null) {
  //     setState(() {
  //       imageFile = File(pickedFile.path);
  //       //  _filename = basename(imageFile!.path).toString();
  //       final _nameWithoutExtension = basenameWithoutExtension(imageFile!.path);
  //       final _extenion = extension(imageFile!.path);
  //     });
  //   }
  // }
  Future<void> submitForm(String name, String description,String categ, String filepathvideo) async {
    var uri = Uri.parse(Api().url+'/api/add_video'); // Replace with your API endpoint

    prefs = await SharedPreferences.getInstance();
    artist_id = (prefs.getInt('user_id') ?? 0 );
    var request = http.MultipartRequest('POST', uri);


    request.fields['name'] = name;
    request.fields['description'] = description;

    request.fields['category'] = categ;

    request.fields['artist'] =artist_id.toString();

    print(request.fields);
    request.files.add(await http.MultipartFile.fromPath('video', filepathvideo));
    // final imageStream = http.ByteStream(imageFile!.openRead());
    // final imageLength = await imageFile!.length();
    //
    // final multipartFile = await http.MultipartFile(
    //   'image',imageStream,imageLength,
    //   filename: _filename ,
    //   // contentType: MediaType('image', 'jpeg'), // Replace with your desired image type
    // );
    // request.files.add(multipartFile);
    // print(_filename);
    //
     final response = await request.send();

    if (response.statusCode == 201) {
      print('Form submitted successfully');
      Navigator.push(
          this.context, MaterialPageRoute(builder: (context) => Ahome()));
    } else {
      print('Error submitting form. Status code: ${response.statusCode}');
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add video'),
        backgroundColor: Colors.green,

      ),
      body:  SingleChildScrollView(
        child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(height: 20,),
                  Container(
                    padding: const EdgeInsets.all(10),
                    child: TextField(
                      controller: nameController,
                      decoration: const InputDecoration(

                        border: OutlineInputBorder(),
                        labelText: 'Video Name',
                        hintText: 'Video Name',
                      ),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(10),
                    child: TextField(
                      controller: descController,
                      decoration: const InputDecoration(

                        border: OutlineInputBorder(),
                        labelText: 'Video Description',
                        hintText: 'Video Description',
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
                  ElevatedButton(
                    style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(Colors.green)),
                    child: const Text('Choose video'),
                    onPressed: () {
                      pickVideo();
                     // _showPicker(context: context);
                    },
                  ),
                  SizedBox(height: 30,),
                  Text(filePath== null?"":filePath.toString()),
                  SizedBox(height: 30,),
                  Container(
                      height: 50,
                      padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                      child: ElevatedButton(
                        child: const Text('Submit'),
                        onPressed: () {

                          submitForm(nameController.text,descController.text,dropdownvalue,filePath.toString());
                        },
                      )
                  ),

                ],
              ),
      ),


    );
  }

  // void _showPicker({
  //   required BuildContext context,
  // }) {
  //   showModalBottomSheet(
  //     context: context,
  //     builder: (BuildContext context) {
  //       return SafeArea(
  //         child: Wrap(
  //           children: <Widget>[
  //             ListTile(
  //               leading: const Icon(Icons.photo_library),
  //               title: const Text('Gallery'),
  //               onTap: () {
  //              //   getVideo(ImageSource.gallery);
  //                 Navigator.of(context).pop();
  //               },
  //             ),
  //             ListTile(
  //               leading: const Icon(Icons.photo_camera),
  //               title: const Text('Camera'),
  //               onTap: () {
  //             //    getVideo(ImageSource.camera);
  //                // Navigator.of(context).pop();
  //               },
  //             ),
  //           ],
  //         ),
  //       );
  //     },
  //   );
  // }

  /*Future getVideo(
      ImageSource img,
      ) async {
    final pickedFile = await picker.pickVideo(
        source: img,
        preferredCameraDevice: CameraDevice.front,
        maxDuration: const Duration(minutes: 10));
    XFile? xfilePick = pickedFile;
    setState(
          () {
        if (xfilePick != null) {
          galleryFile = File(pickedFile!.path);
        } else {
          ScaffoldMessenger.of(context).showSnackBar(// is this context <<<
              const SnackBar(content: Text('Nothing is selected')));
        }
      },*/
  //  );
  //}
}



























// import 'dart:io';
//
// import 'package:file_picker/file_picker.dart';
// import 'package:flutter/material.dart';
// import 'package:fluttertoast/fluttertoast.dart';
// import 'package:http/http.dart' as http;
// import 'package:image_picker/image_picker.dart';
// class alearning extends StatefulWidget {
//   const alearning({Key? key}) : super(key: key);
//
//   @override
//   State<alearning> createState() => _alearningState();
// }
//
// class _alearningState extends State<alearning> {
//   File? videoFile;
//   File? galleryFile;
//   final picker = ImagePicker();
//   String dropdownvalue = 'Categories';
//
//   // List of items in our dropdown menu
//   var items = [
//     'Categories',
//     'Painting',
//     'Brush',
//     'Crafts',
//     'Paints',
//   ];
//
//   Future<void> uploadVideo() async {
//     // Select a video file
//     FilePickerResult? result = await FilePicker.platform.pickFiles(
//       type: FileType.custom,
//       allowedExtensions: ['mp4', 'avi', 'mov'],
//     );
//
//     if (result != null) {
//       File videoFile = File(result.files.single.path!);
//
//       // Get the MIME type of the video file
//       String? mimeType = mime(videoFile.path);
//       if (mimeType == null) {
//         Fluttertoast.showToast(
//           msg: 'Unsupported file format',
//           backgroundColor: Colors.grey,
//         );
//         return;
//       }
//
//       // Prepare the API endpoint URL
//       Uri apiUrl = Uri.parse('your_api_endpoint');
//
//       // Create a multipart request
//       var request = http.MultipartRequest('POST', apiUrl);
//
//       // Attach the video file to the request
//       request.files.add(
//         await http.MultipartFile.fromPath('video', videoFile.path, contentType: MediaType.parse(mimeType)),
//       );
//
//       // Send the request
//       var response = await request.send();
//
//       if (response.statusCode == 200) {
//         Fluttertoast.showToast(
//           msg: 'Video uploaded successfully',
//           backgroundColor: Colors.grey,
//         );
//       } else {
//         Fluttertoast.showToast(
//           msg: 'Failed to upload video',
//           backgroundColor: Colors.grey,
//         );
//       }
//     } else {
//       // User canceled video selection
//       Fluttertoast.showToast(
//         msg: 'Video selection canceled',
//         backgroundColor: Colors.grey,
//       );
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Add video'),
//         backgroundColor: Colors.green,
//         actions: const [],
//       ),
//       body: Builder(
//         builder: (BuildContext context) {
//           return Column(
//
//             mainAxisAlignment: MainAxisAlignment.start,
//             children: [
//               SizedBox(height: 30, width: 50,),
//               Text("Paper craft",
//                   style: TextStyle(
//                       color: Color(0xFF575E67),
//                       fontFamily: 'Varela',
//                       fontSize: 24.0)),
//               SizedBox(height: 30, width: 30,),
//               Text('Video Description',
//                   textAlign: TextAlign.center,
//                   style: TextStyle(
//                       fontFamily: 'Varela',
//                       fontSize: 16.0,
//                       color: Color(0xFFB4B8B9))
//               ),
//               SizedBox(height: 20, width: 30,),
//               Padding(
//                 padding: const EdgeInsets.all(10.0),
//                 child: DropdownButtonFormField(
//                   decoration: InputDecoration(
//                     disabledBorder: OutlineInputBorder(
//                         borderRadius: BorderRadius.circular(3)),
//                     enabledBorder: OutlineInputBorder(
//                         borderRadius: BorderRadius.circular(3)),
//                   ),
//                   // Initial Value
//                   value: dropdownvalue,
//
//                   // Down Arrow Icon
//                   icon: const Icon(Icons.keyboard_arrow_down),
//
//                   // Array list of items
//                   items: items.map((String items) {
//                     return DropdownMenuItem(
//                       value: items,
//                       child: Text(items),
//                     );
//                   }).toList(),
//                   // After selecting the desired option,it will
//                   // change button value to selected value
//                   onChanged: (String? newValue) {
//                     setState(() {
//                       dropdownvalue = newValue!;
//                     });
//                   },
//                 ),
//               ),
//               SizedBox(height: 20, width: 30,),
//               Padding(
//                 padding: const EdgeInsets.all(8.0),
//                 child: ElevatedButton(
//                   style: ButtonStyle(
//                       backgroundColor: MaterialStateProperty.all(Colors.green)),
//                   child: const Text('Choose video'),
//                   onPressed: () {
//                     _showPicker(context: context);
//                   },
//                 ),
//               ),
//               const SizedBox(
//                 height: 20,
//               ),
//
//
//             ],
//           );
//
//         }
//     ),
//     );
//         }
//   }
//
// void _showPicker({
//     required BuildContext context,
//   }) {
//     showModalBottomSheet(
//       context: context,
//       builder: (BuildContext context) {
//         return SafeArea(
//           child: Wrap(
//             children: <Widget>[
//               ListTile(
//                 leading: const Icon(Icons.photo_library),
//                 title: const Text('Gallery'),
//                 onTap: () {
//                   getVideo(ImageSource.gallery);
//                   Navigator.of(context).pop();
//                 },
//               ),
//               ListTile(
//                 leading: const Icon(Icons.photo_camera),
//                 title: const Text('Camera'),
//                 onTap: () {
//                   getVideo(ImageSource.camera);
//                   Navigator.of(context).pop();
//                 },
//               ),
//             ],
//           ),
//         );
//       },
//     );
//   }
//
// void getVideo(ImageSource gallery) {
// }
//
//
//
// // Future getVideo(
// //       ImageSource img,
// //       ) async {
// //     final pickedFile = await picker.pickVideo(
// //         source: img,
// //         preferredCameraDevice: CameraDevice.front,
// //         maxDuration: const Duration(minutes: 10));
// //     XFile? xfilePick = pickedFile;
// //     setState(
// //           () {
// //         if (xfilePick != null) {
// //           galleryFile = File(pickedFile!.path);
// //         } else {
// //           ScaffoldMessenger.of(context).showSnackBar(// is this context <<<
// //               const SnackBar(content: Text('Nothing is selected')));
// //         }
// //       },
// //     );
// //   }
// // }
//
