// import 'package:flutter/material.dart';
// import 'package:flutter/src/foundation/key.dart';
// import 'package:flutter/src/widgets/framework.dart';
// import 'package:flutter/src/widgets/placeholder.dart';
// import 'package:helloworld/customer/payment.dart';
//
// class success extends StatefulWidget {
//   const success({Key? key}) : super(key: key);
//
//   @override
//   State<success> createState() => _successState();
// }
//
// class _successState extends State<success> {
//   @override
//   Widget build(BuildContext context) {
//
//     return Scaffold(
//       backgroundColor: Colors.white,
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Image.asset("images/tick.png",height: 50,width: 100,alignment: Alignment.topCenter,),
//             Padding(padding: EdgeInsets.symmetric(horizontal: 10,vertical: 10),
//               child: Text("Your payment was done successfully",textAlign: TextAlign.center,selectionColor: Colors.pinkAccent,),
//
//             ),
//             ElevatedButton(onPressed: (){
//               Navigator.push(context, MaterialPageRoute(builder: (context)=>payment(),));
//             },
//               style:ElevatedButton.styleFrom(shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50.0)),primary: Colors.pink,fixedSize: Size(200, 50)),
//               child: Text("OK",style: TextStyle(color: Colors.white),),
//             ),
//           ],
//         ),
//       ),
//
//     );
//   }
// }