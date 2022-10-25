import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CouresPage extends StatefulWidget {
  const CouresPage({super.key});

  @override
  State<CouresPage> createState() => _CouresPageState();
}

class _CouresPageState extends State<CouresPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      //appbar
      appBar: AppBar(
        title: Text('หมวดหมู่'),
      ),
    );
  }
}