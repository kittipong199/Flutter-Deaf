// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class WidgetImageYoutube extends StatelessWidget {
  const WidgetImageYoutube({
    Key? key,
    required this.urlYoutube,
    this.width,
    this.height,
  }) : super(key: key);

  final String urlYoutube;

  final double? width;
  final double? height;

  @override
  Widget build(BuildContext context) {
    String? urlimage = YoutubePlayer.convertUrlToId(urlYoutube);

    urlimage = 'https://img.youtube.com/vi/$urlimage/0.jpg';

    return Image.network(urlimage ??
        'https://www.androidthai.in.th/fluttertraining/image/image.png',
        
        width: width,
        height: height,);
  }
}
