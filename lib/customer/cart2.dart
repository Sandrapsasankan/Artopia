import 'package:flutter/material.dart';

class EmptyCartImage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Image.asset(
        'images/empty (1).jpg',
        width: 600, // adjust the size to fit your design
        height: 600,
      ),
    );
  }
}