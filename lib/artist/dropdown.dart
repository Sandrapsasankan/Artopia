import 'package:flutter/material.dart';
class dropdown extends StatefulWidget {
  const dropdown({Key? key}) : super(key: key);

  @override
  State<dropdown> createState() => _dropdownState();
}

class _dropdownState extends State<dropdown> {
  @override
  Widget build(BuildContext context) {
    var dropDownvalue;
    var Categories;
    return Scaffold(
      body: SizedBox(
          width: double.maxFinite,
          child: DropdownButtonFormField<String>(
              decoration: InputDecoration(
                disabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5)) ,
                enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5)),
              ),
              hint: Text('Categories'),
              value: dropDownvalue,
              items: Categories
                  .map((type) => DropdownMenuItem<String>(
                value: type['artist_id'].toString(),
                child: Text(
                  type['category'].toString(),
                  style: TextStyle(color: Colors.black),
                ),
              ))
                  .toList(),
              onChanged: (type) {
                setState(() {
                  //    int types = int.parse(type['patient'].toString());
                  //     var types=type['patient'].toString();
                  dropDownvalue = type;
                });
              }),
        ),

    );
  }
}
