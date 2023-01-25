// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:app_deaf/utils/app_constarts.dart';
import 'package:flutter/material.dart';

import 'package:app_deaf/models/answerModel.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class VideoAnswerPage extends StatefulWidget {
  const VideoAnswerPage({
    Key? key,
    required this.listAnswerModel,
  }) : super(key: key);

  final AnswerModel listAnswerModel;
  @override
  State<VideoAnswerPage> createState() => _VideoAnswerPageState();
}

class _VideoAnswerPageState extends State<VideoAnswerPage> {
  String? inintAnswerVideo;
  YoutubePlayerController? youtubePlayerController;

  bool haveError = false;

  @override
  void initState() {
    super.initState();
    print('${widget.listAnswerModel.toString()}');
     setUpYoutube();
  }

  @override
  void dispose() {
    youtubePlayerController!.dispose();
    super.dispose();
  }

  void setUpYoutube() {
    try {
      inintAnswerVideo =
          YoutubePlayer.convertUrlToId(widget.listAnswerModel.answerVideo);

      youtubePlayerController = YoutubePlayerController(
          initialVideoId: inintAnswerVideo!,
          flags: YoutubePlayerFlags(autoPlay: true));
    } catch (e) {
      setState(() {
        haveError = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //
      appBar: AppBar(),

      // body
      body: Center(
        
        child: Column(
          
          children: [
            haveError
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
          ],
          
        ),
        
      ),

      
            
    );
  }
}

