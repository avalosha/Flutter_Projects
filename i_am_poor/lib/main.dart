import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    home: Scaffold(
      backgroundColor: Colors.teal,
      body: const Center(
        child: Image(image: AssetImage('images/sad_piggy_bank.jpg')),
      ),
      appBar: AppBar(
        title: const Text('I am poor'),
        backgroundColor: Colors.white60,
      ),
    ),
  ));
}
