import 'dart:convert';

import 'package:helloworld/api_service/api.dart';
import 'package:helloworld/customer/cart2.dart';
import 'package:helloworld/customer/cartmodel.dart';
import 'package:helloworld/customer/placeorder.dart';
import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';

import 'package:shared_preferences/shared_preferences.dart';

class Cart extends StatefulWidget {
  const Cart({Key? key}) : super(key: key);

  @override
  State<Cart> createState() => _CartState();
}

DateTime currentDate = DateTime.now();
String formattedDate = DateFormat('yyyy-MM-dd').format(currentDate);

class _CartState extends State<Cart> {
  bool _isLoading = false;
  var product;
  late SharedPreferences prefs;
  List<CartModel> cart = [];
  bool isLoading = false;
  late int user_id, id, artist_id;
  late int qty;

  @override
  void initState() {
// TODO: implement initState
    super.initState();
    fetchCart();
  }

  Future<void> fetchCart() async {
    prefs = await SharedPreferences.getInstance();
    user_id = (prefs.getInt('user_id') ?? 0);

    var response =
        await Api().getData('/api/cart_single_view/' + user_id.toString());
    if (response.statusCode == 200) {
      var items = json.decode(response.body);
      print(("cart items${items}"));
//  var parsedData = json.decode(items);
      List<dynamic> cartData = items['data'];
      cart = cartData
          .where((item) => item['cart_status'] == '0')
          .map((item) => CartModel.fromJson(item))
          .toList();
      setState(() {
        cart;
      });
    } else {
      setState(() {
        cart = [];
        Fluttertoast.showToast(
          msg: "Currently there is no data available",
          backgroundColor: Colors.grey,
        );
      });
    }
  }

  _deleteData(int id) async {
    var res = await Api().deleteData('/api/delete_cart/' + id.toString());
    if (res.statusCode == 200) {
      setState(() {
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => Cart()));
        Fluttertoast.showToast(
          msg: "Removed from cart",
          backgroundColor: Colors.grey,
        );
      });
    } else {
      setState(() {
        cart = [];
        Fluttertoast.showToast(
          msg: "Currently there is no data available",
          backgroundColor: Colors.grey,
        );
      });
    }
  }

  _increment(int id) async {
    setState(() {
      var _isLoading = true;
    });

    var res = await Api().putsData('/api/cart_increment/' + id.toString());
    var body = json.decode(res.body);
    print(body);
    if (body['success'] == true) {
      print(body);
      setState(() {
// qty++;
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => Cart()));
      });
/*   Fluttertoast.showToast(
        msg: body['message'].toString(),
        backgroundColor: Colors.grey,
      );*/
    } else {
      Fluttertoast.showToast(
        msg: body['message'].toString(),
        backgroundColor: Colors.grey,
      );
    }
  }

  _decrement(int id) async {
    setState(() {
      var _isLoading = true;
    });

    var res = await Api().putsData('/api/cart_decrement/' + id.toString());
    var body = json.decode(res.body);
    print(body);
    if (body['success'] == true) {
      print(body);
      setState(() {
//  qty--;
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => Cart()));
      });
/*  Fluttertoast.showToast(
        msg: body['message'].toString(),
        backgroundColor: Colors.grey,
      );*/
    } else {
      Fluttertoast.showToast(
        msg: body['message'].toString(),
        backgroundColor: Colors.grey,
      );
    }
  }

  Future PlaceOrders() async {
    prefs = await SharedPreferences.getInstance();
    user_id = (prefs.getInt('user_id') ?? 0);
    print('login_id_complaint ${user_id}');
    setState(() {
      _isLoading = true;
    });

    var data = {
      "user": user_id.toString(),
      "artist": artist_id.toString(),
      "date":formattedDate
    };
    print(data);
    var res = await Api().authData(data,'/api/order');
    var body = json.decode(res.body);
    print(body);
    if (body['success'] == true) {
      cart.clear();

      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => PlaceOrder()));
      print(body);
      Fluttertoast.showToast(
        msg: body['message'].toString(),
        backgroundColor: Colors.grey,
      );
    } else {
      Fluttertoast.showToast(
        msg: body['message'].toString(),
        backgroundColor: Colors.grey,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('My Cart'),
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [Colors.blue, Colors.purple],
            ),
          ),
        ),

      ),
      body: cart.isEmpty
          ? EmptyCartImage() // Show empty cart image
          : ListView.builder(
              shrinkWrap: true,
              itemCount: cart.length,
              itemBuilder: (context, index) {
                product = cart[index];

                final firstWord = cart[index].name.split(' ').first;
                id = cart[index].id;
                qty = cart[index].quantity;
                 artist_id = cart[index].artist_id;
                return Card(
                    child: Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        height: 150,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            color: Colors.grey[200]),
                        child: Column(
                          children: [
                            Container(
                              height: 100,
                              width: 120,
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: NetworkImage(
                                      Api().url + cart[index].imageUrl),
                                  fit: BoxFit.fill,
                                ),
                              ),
                            ),
                            SizedBox(height: 5),
                            Text(
                              firstWord,
                            ),
                            SizedBox(height: 5),
                            Text(
                              "₹" + cart[index].price.toString(),
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 15),
                            ),
                          ],
                        ),
                      ),
                      Column(
                        children: [
                          IconButton(
                            icon: Icon(
                              Icons.delete,
                            ),
                            onPressed: () {
                              setState(() {
                                _deleteData(cart[index].id);
                              });
                            },
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Container(
                                width: 30,
                                height: 30,
                                child: FloatingActionButton(
                                  onPressed: () {
                                    setState(() {
                                      _decrement(cart[index].id);
                                    });
                                  },
                                  backgroundColor: Colors.grey,
                                  child:
                                      Icon(Icons.remove, color: Colors.black),
                                ),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Text(
                                '${qty}'.toString(),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Container(
                                width: 30,
                                height: 30,
                                child: FloatingActionButton(
                                  onPressed: () {
                                    setState(() {
                                      _increment(cart[index].id);
                                    });
                                  },
                                  backgroundColor: Colors.grey,
                                  child: Icon(Icons.add, color: Colors.black),
                                ),
                              ),
                            ],
                          ),
                        ],
                      )
                    ],
                  ),
                ));
              },
            ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Material(
          color: Colors.deepPurple,
          child: InkWell(
            onTap: () {
              PlaceOrders();
            },
            child: const SizedBox(
              height: kToolbarHeight,
              width: double.infinity,
              child: Center(
                child: Text(
                  'Place Order',
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
    );
  }
}

// import 'package:flutter/cupertino.dart';

// import 'package:flutter/material.dart';
// import 'package:flutter/src/foundation/key.dart';
// import 'package:flutter/src/widgets/framework.dart';
// import 'package:flutter/src/widgets/placeholder.dart';
//
// import 'package:helloworld/payment.dart';
//
// class cart extends StatefulWidget {
//   const cart({Key? key}) : super(key: key);
//
//   @override
//   State<cart> createState() => _cartState();
// }
//
// class _cartState extends State<cart> {
//   ApiService client = ApiService();
//   bool _isLoading = false;
//   var product;
//   late SharedPreferences prefs;
//   List<CartModel> cart=[];
//   bool isLoading = false;
//   late int user_id, cart_id;
//   late int qty;
//
//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     fetchCart();
//   }
//
//
//   Future<void> fetchCart() async {
//     prefs = await SharedPreferences.getInstance();
//     user_id = (prefs.getInt('user_id') ?? 0);
//
//     var response = await Api().getData(
//         '/api/SingleCart/' + user_id.toString());
//     if (response.statusCode == 200) {
//       var items =json.decode(response.body);
//       print(("cat items${items}"));
//       //  var parsedData = json.decode(items);
//       List<dynamic> cartData = items['data'];
//       cart = cartData
//           .where((item) => item['cart_status'] == '0')
//           .map((item) => CartModel.fromJson(item))
//           .toList();
//       setState(() {
//         cart;
//       });
//
//     }
//     else {
//       setState(() {
//         cart = [];
//         Fluttertoast.showToast(
//           msg: "Currently there is no data available",
//           backgroundColor: Colors.grey,
//         );
//       });
//     }
//   }
//   List images=['images/img_1.png','images/img_1.png','images/img_1.png','images/img_1.png','images/img_1.png'];
//   List name=["Product 1","Product 2","Product 3","Product 4","Product 5"];
//   List price=["200","300","510","700","450","600"];
//
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//
//       appBar: AppBar(
//         toolbarHeight: 40,
//         backgroundColor: Colors.pink,
//
//         title: Text("CART"),
//       ),
//       body:
//       Column(
//         children: [
//           Expanded(
//             child: ListView.builder(
//
//                 itemCount: name.length,
//                 itemBuilder: (context, index) {
//
//                   return Card(
//                       child: Row(
//                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                           children: [
//                             Row(
//                               children: [
//
//                                 CircleAvatar(
//                                   radius: 60,
//
//                                   backgroundImage: AssetImage(images[index]),
//                                 ),
//                                 SizedBox(width: 30,),
//                                 Column(
//                                   children: [
//
//                                     Text(name[index],style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),),
//                                     Text("Rs: "+price[index])
//
//                                   ],
//                                 ),
//
//
//
//
//                               ],
//                             ),
//                             Row(
//                               children: [
//                                 Column(
//                                   children: [
//                                     Container(
//                                       height: 35,
//                                       width: 100,
//                                       decoration: BoxDecoration(
//                                           color: Colors.green,
//                                           borderRadius: BorderRadius.circular(5)
//                                       ),
//
//                                       child: Padding(padding:
//                                       EdgeInsets.all(4.0),
//                                         child: Row(
//                                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                                           children: [
//                                             Icon(Icons.remove,color: Colors.white,),
//
//                                             Text("0"),
//                                             Icon(Icons.add,color: Colors.white,)
//
//                                           ],
//                                         ),
//
//                                       ),
//
//                                     ),
//                                   ],
//                                 ),
//
//                                 IconButton(onPressed: (){}, icon: Icon(Icons.delete,
//                                   color: Colors.red,)),
//                               ],
//
//                             )
//                           ]
//
//                       )
//
//
//
//                   );
//
//
//                 }
//             ),
//
//
//
//           ),
//
//           ElevatedButton(onPressed: (){
//             Navigator.push(context, MaterialPageRoute(builder: (context)=>payment()));
//
//           }, child: Text("Buy Now"))
//         ],
//       ),
//
//
//
//     );
//   }
// }
