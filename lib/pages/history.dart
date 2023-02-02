// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:app_deaf/models/ContentModel.dart';

class HistoryPage extends StatefulWidget {

 
  const HistoryPage({
    Key? key,
    
    required this.id,
  }) : super(key: key);
  final String id;
  @override
  State<HistoryPage> createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:  AppBar(),

      body: Container(),
    );
  }
}