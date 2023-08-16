import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:helloworld/api_service/api.dart';
import 'package:helloworld/customer/home.dart';
import 'package:helloworld/customer/payment.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PlaceOrder extends StatefulWidget {
  const PlaceOrder({Key? key}) : super(key: key);

  @override
  State<PlaceOrder> createState() => _PlaceOrderState();
}

class _PlaceOrderState extends State<PlaceOrder> {
  List order = [];

  bool isLoading = false;
  late SharedPreferences localStorage;
  late int user_id,artist;
  String price='';
  bool _isLoading=false;

  _fetchOrder() async {
    localStorage = await SharedPreferences.getInstance();
    user_id = (localStorage.getInt('user_id') ?? 0);
    print("id${user_id}");
    var res = await Api()
        .getData('/api/order_single_view/'+user_id.toString());
    if (res.statusCode == 200) {
      var body = json.decode(res.body);

      var items = json.decode(res.body)['data'];
      print("order Items${items}");
      setState(() {
        order = items;
      });
    } else {
      order = [];
      Fluttertoast.showToast(
        msg:"Currently there is no data available",
        backgroundColor: Colors.grey,
      );
    }
  }
  Future totalId() async {
    localStorage = await SharedPreferences.getInstance();
    user_id = (localStorage.getInt('user_id') ?? 0);
    print('login_id_complaint ${user_id}');
    setState(() {
      _isLoading = true;
    });

    var res = await Api().getData('/api/AllPrice/'+user_id.toString());
    var body = json.decode(res.body);
    print({user_id});
    if (body['success'] == true) {
      price= body['data']['total_price'];
      print('price ${price}');
      Fluttertoast.showToast(
        msg: body['message'].toString(),
        backgroundColor: Colors.grey,
      );
    }
    else{
      Fluttertoast.showToast(
        msg: body['message'].toString(),
        backgroundColor: Colors.grey,
      );
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    totalId();
    _fetchOrder();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Orders'),
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
          onPressed: (){
            Navigator.push(context, MaterialPageRoute(builder: (context)=>Homescreen()));
          },icon: Icon(Icons.arrow_back),
        ),
      ),
      body:/* FutureBuilder<List<OrderModel>>(
      future: client.fetchOrder(),
    builder: (BuildContext context,
    AsyncSnapshot<List<OrderModel>> snapshot) {
        print(snapshot);
    if (snapshot.hasData) {
    return */ ListView.builder(
          shrinkWrap: true,
          itemCount:order.length,
          itemBuilder: (BuildContext context, int index){
            int id=order[index]['id'];
            final firstWord = order[index]['name'];
            artist= order[index]['artist_id'];
            return Card(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Container(
                            height: 90,
                            child: Image(image: NetworkImage(Api().url+ order[index]['image'])),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 10.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(order[index]['product_name'].toString()),
                                Text("Quantity : "+order[index]['quantity'].toString()),
                                Text("Rs : "+order[index]['total_price'].toString()),
                                // Text("Qty : "+order[index].quantity),
                              ],
                            ),
                          ),
                        ],
                      ),


                      /*  GestureDetector(
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>Payment()));
                  },
                )*/
                    ]
                ),
              ),
            );
          }),
      /*  }
    return Center(child: CircularProgressIndicator());
    }),*/

      bottomNavigationBar: Row(
        children: [
          Material(
            color:  Colors.deepPurple[100],
            child:  SizedBox(
              height: kToolbarHeight,
              width: 100,
              child: Center(
                child: Text(price,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            child: Material(
              color: Colors.deepPurple[400],
              child: InkWell(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>Payment(price: price,artist_id:artist)));
                },
                child: const SizedBox(
                  height: kToolbarHeight,
                  width: double.infinity,
                  child: Center(
                    child: Text(
                      'Buy Now',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),


    );
  }
}
