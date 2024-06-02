import 'package:flutter/material.dart';

class WirdScreen extends StatelessWidget {
  static String routename = 'wirdscreen';

  const WirdScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(title: Text('data'),),
    );
  }
}