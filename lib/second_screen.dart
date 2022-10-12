import 'package:flutter/material.dart';

class SecondScreen extends StatefulWidget {
  final String payload;
  const SecondScreen({Key? key, required this.payload}) : super(key: key);

  @override
  State<SecondScreen> createState() => _SecondScreenState();
}

class _SecondScreenState extends State<SecondScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Second screen"),
      ),
      body: Center(
        child: Text(
          widget.payload,
          style: const TextStyle(fontSize: 30),
        ),
      ),
    );
  }
}
