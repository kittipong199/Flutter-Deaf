// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:app_deaf/utils/app_constarts.dart';
import 'package:flutter/material.dart';

import 'package:app_deaf/models/ContentModel.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class QuizPage extends StatefulWidget {
  const QuizPage({
    Key? key,
    required this.contentModel,
  }) : super(key: key);

  final ContentModel contentModel;

  @override
  State<QuizPage> createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  String? initiaVideoId;

   YoutubePlayerController? youtubePlayerController;
  bool haveError = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setUpyoutube();
  }

  @override
  void dispose() {
    youtubePlayerController!.dispose();
    super.dispose();
  }

  void setUpyoutube() {
    try {
      initiaVideoId = YoutubePlayer.convertUrlToId(widget.contentModel.video);

      youtubePlayerController = YoutubePlayerController(
          initialVideoId: initiaVideoId!,
          flags: YoutubePlayerFlags(autoPlay: true,));
    } catch (e) {
      // error
      setState(() {
        haveError = true;
      });
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(),

      body:  haveError
          ? Center(child: Text("Can not Player Video"))
          : YoutubePlayer(
              controller: youtubePlayerController!,
              showVideoProgressIndicator: true,
              progressColors: ProgressBarColors(
                  playedColor: AppConstart.bgColor,
                  handleColor: AppConstart.LightColor),
              onReady: () {
                youtubePlayerController!.addListener(() {});
              },
            ),
      
    );
  }
}