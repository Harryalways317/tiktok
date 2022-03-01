import 'package:flutter/material.dart';
import 'package:tiktok/constants.dart';
import 'package:tiktok/controllers/video_controller.dart';
import 'package:tiktok/view/screens/comment_screen.dart';
import 'package:tiktok/view/widgets/circle_animation.dart';
import 'package:tiktok/view/widgets/video_player_item.dart';
import 'package:video_player/video_player.dart';
import 'package:get/get.dart';

class VideoScreen extends StatelessWidget {
   VideoScreen({Key? key}) : super(key: key);
  final VideoController videoController =  Get.put(VideoController());

  _buiildProfile(String profilePhoto){
    return SizedBox(
      width: 60,
      height: 60,
        child: Stack(
          children: [
            Positioned(
              left: 5,
              child: Container(
              height: 50,
                width: 50,
                padding: EdgeInsets.all(1),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(25),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(25),
                  child: Image(
                    image: NetworkImage(profilePhoto),
                    fit: BoxFit.cover,
                  ),
                ),
               ),
            ),
          ],
        ),
    );
  }

  buildMusicAlbum(String profilePhoto){
    return SizedBox(
      width: 60,
      height: 60,
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.all(11),
            height: 50,
            width: 50,
            decoration: BoxDecoration(
              gradient: const LinearGradient(colors: [Colors.grey,Colors.white]),
              borderRadius: BorderRadius.circular(25)
            ),
            child: ClipRRect(borderRadius: BorderRadius.circular(25),child: Image(image: NetworkImage(profilePhoto),fit: BoxFit.cover,),),
          )
        ],
      ),
    );
  }



  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: Obx(
              () {
          return PageView.builder(


            scrollDirection: Axis.vertical,
            itemCount: videoController.videoList.length,
            controller: PageController(initialPage: 0,viewportFraction: 1),
            itemBuilder: (context,index){
              final data = videoController.videoList[index];
              return Stack(
                children: [
                  VideoPlayerItem(videoUrl: data.videoUrl  ),
                  Positioned(
                    width: size.width,
                    height: size.height,
                    bottom: 15,
                    child: Column(
                      children: [
                        const SizedBox(height: 100,),
                        Expanded(
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Expanded(
                                  child: Container(
                                    padding: EdgeInsets.only(left: 20),
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                      mainAxisSize: MainAxisSize.min,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(data.username,style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color: Colors.white),),
                                        Text(data.caption,style: TextStyle(fontSize: 15,color: Colors.white),),
                                        Row(
                                          children: [
                                            Icon(Icons.music_note,size: 20,),
                                            Text(data.songName,style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold,color: Colors.white),),
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                                Container(
                                  width: 100,
                                  margin: EdgeInsets.only(top: size.height/4 ),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                    children: [
                                      _buiildProfile(data.profilePhoto),
                                      Column(
                                        children: [
                                          InkWell(
                                            onTap: () => videoController.likeVideo(data.id),
                                            child: Icon(Icons.favorite,size: 40,color:data.likes.contains(authController.user.uid)? Colors.red:Colors.white),

                                          ),
                                          SizedBox(height: 10,),
                                          Text("${data.likes.length.toString()} likes",style: TextStyle(fontSize: 15,color: Colors.white),),
                                          InkWell(
                                            onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => CommentScreen(id: data.id,))),
                                            child: Icon(Icons.comment,size: 40,color: Colors.white,),

                                          ),
                                          SizedBox(height: 15,),
                                          Text(data.commentCount.toString(),style: TextStyle(fontSize: 20,color: Colors.white),),
                                          InkWell(
                                            onTap: null,
                                            child: Icon(Icons.reply,size: 40,color:Colors.white,),

                                          ),
                                          SizedBox(height: 10,),
                                          Text(data.shareCount.toString(),style: TextStyle(fontSize: 20,color: Colors.white),),
                                        ],
                                      ),

                                      CircleAnimation(child : buildMusicAlbum(data.profilePhoto)),


                                    ],
                                  ),
                                )
                              ],
                            ),
                        )
                      ],
                    ),
                  )
                ],
              );
            });
        }
      ),
    );
  }
}
