import 'package:app_deaf/models/ContentModel.dart';
import 'package:app_deaf/service/contentApi.dart';
import 'package:flutter/material.dart';

import 'package:video_player/video_player.dart';


class VideoContentPage extends StatefulWidget {
  const VideoContentPage({super.key});

  @override
  State<VideoContentPage> createState() => _VideoContentPageState();
}

class _VideoContentPageState extends State<VideoContentPage> {
  late VideoPlayerController controller;
    Future<List<ContentModel>>? futureContent;
  @override
  void initState() {
    super.initState();
    futureContent = ContentsApi.futureContentApi();
    loadVideoPlayer();
  }


  loadVideoPlayer(){
     controller = VideoPlayerController.network('https://github.com/stephangopaul/video_samples/blob/master/gb.mp4');
      // controller = VideoPlayerController.asset('');
     controller.addListener(() {
        setState(() {});
     });
    controller.initialize().then((value){
        setState(() {});
    });

  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
          appBar: AppBar( 
              title: Text("Video Player in Flutter"),
              backgroundColor: Color(0xFFFFB200),
          ),
          body: FutureBuilder<List<ContentModel>>(
            future: futureContent,
            builder: (context, snapshot) {
              return Container( 
                child: Column(
                  children:[
                      AspectRatio( 
                        aspectRatio: controller.value.aspectRatio,
                         child: VideoPlayer(controller),
                      ),
                      Container(
                          child: VideoProgressIndicator(
                            controller, 
                            allowScrubbing: true,
                            // colors:VideoProgressColors(
                            //     backgroundColor: Colors.redAccent,
                            //     playedColor: Colors.green,
                            //     bufferedColor: Colors.purple,
                            // )
                          )
                      ),
                      // icon player and stop
                      Container(
                         child: Center(
                           child: Row(
                               children: [
                                  IconButton(
                                      onPressed: (){
                                        if(controller.value.isPlaying){
                                          controller.pause();
                                        }else{
                                          controller.play();
                                        }

                                        setState(() {
                                          
                                        });
                                      }, 
                                      icon:Icon(controller.value.isPlaying?Icons.pause:Icons.play_arrow)
                                 ),

                                 IconButton(
                                      onPressed: (){
                                        controller.seekTo(Duration(seconds: 0));

                                        setState(() {
                                          
                                        });
                                      }, 
                                      icon:Icon(Icons.stop)
                                 )
                               ],
                           ),
                         ),
                      ),
                        
                       Container( //duration of video
                         child: Center(
                           child: Text("Total Duration " ,style: TextStyle(
                                  fontSize: 35, color: Color.fromARGB(255, 0, 0, 0)),),
                         ),
                      ),
                       SizedBox(height: 40,),
                      Container(
                        child: Row(
                         mainAxisSize:MainAxisSize.min,
                children: [
                 

                  SizedBox(height: 20,),
                  //  btn ย้อนกลับ
                  ElevatedButton(
                     style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFF277BC0) ,
                    shape: const StadiumBorder(),
                    
                    
                    minimumSize: Size(120,50), // background
                    
                    // foreground
                      ),
                    onPressed: () {},
                    
                   child: Text('ย้อนกลับ',style: TextStyle(fontSize: 20.0,fontWeight: FontWeight.bold),
                   )
                   ),
                   
                      SizedBox(width: 30,),
                   // btn ทันไป
                    ElevatedButton(
                     style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFF277BC0) ,
                    shape: const StadiumBorder(),
                    
                    
                    minimumSize: Size(120,50), // background
                    
                    // foreground
                      ),
                    onPressed: () {},
                    
                   child: Text('ทันไป',style: TextStyle(fontSize: 20.0,fontWeight: FontWeight.bold),))
                ],
               
                        ),
                      )
                  ]
                )
              );
            }
          ),
       );
  }
}