import 'package:flutter/material.dart';
import 'package:helloworld/feedback.dart';
class jobapply extends StatefulWidget {
  const jobapply({Key? key}) : super(key: key);

  @override
  State<jobapply> createState() => _jobapplyState();
}

class _jobapplyState extends State<jobapply> {
  final List<Map<String, dynamic>> allUsers = [
    {
      "id":1,
      "name":"Field coordinator craft",
       "des":"All India Artisans and Craftworkers Welfare ,Uttar Pradesh",
    },
    {
      "id": 2,
      "name": "Project Manager - Crafts",
      "des": "All India Artisans and Craftworkers Welfare ,Uttar Pradesh",
    },
    {
      "id": 3,
      "name": "2D Storyboard Artist",
      "des":"Fine art jobs Dehradun",
    },
    {
      "id": 4,
      "name": "Art and Craft Teacher",
      "des":"vatsalya community school,haridwar"
    }
  ],

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Job'),
        leading:
        IconButton( onPressed: (){
          Navigator.pop(context);
        },icon:Icon(Icons.arrow_back_ios,size: 20,color: Colors.black,)),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            TextField(
              decoration: InputDecoration(
                contentPadding:
                  const EdgeInsets.symmetric(vertical: 10.0, horizontal: 15),
                hintText: "Search",
                suffixIcon: const Icon(Icons.search),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20.0),
                borderSide: const BorderSide(),
              )
              ),
            ),
            SizedBox(
              height: 20,
            ),
          ],
        ),
      ),

    );
  }
}
