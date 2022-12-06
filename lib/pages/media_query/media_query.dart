import 'package:flutter/material.dart';

class MediaQueryPate extends StatefulWidget {
  const MediaQueryPate({super.key});

  @override
  State<MediaQueryPate> createState() => _MediaQueryPateState();
}

class _MediaQueryPateState extends State<MediaQueryPate> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Media Query"),

      ),
      body: Center(child: Text("50000")),
    );
  }
}