import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class VideoPlayerItem extends StatefulWidget {
  final videoUrl;
  VideoPlayerItem({Key? key, required this.videoUrl}) : super(key: key);

  @override
  _VideoPlayerItemState createState() => _VideoPlayerItemState();
}

class _VideoPlayerItemState extends State<VideoPlayerItem> {
  late VideoPlayerController videoPlayerController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    videoPlayerController = VideoPlayerController.network(widget.videoUrl)
      ..initialize().then((value) {
        videoPlayerController.play();
        videoPlayerController.setVolume(1);
        //videoPlayerController.setLooping(true);
        //TODO ADD CALLBACK TO GO TO NEXT VIDEO
      });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    videoPlayerController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return GestureDetector(
      onLongPressDown: (LongPressDownDetails value) =>
          videoPlayerController.pause(),
      onLongPressUp: () => videoPlayerController.play(),
      child: Container(
        height: size.height,
        width: size.width,
        decoration: BoxDecoration(color: Colors.black),
        child: Stack(
          children: [
            Positioned(
              width: size.width,
               //top: 0,
              bottom: 0,
              child: VideoProgressIndicator(
                videoPlayerController,
                allowScrubbing: true,
                colors: VideoProgressColors(
                    backgroundColor: Colors.red,
                    bufferedColor: Colors.black,
                    playedColor: Colors.blueAccent),
              ),
            ),
            AspectRatio(
                aspectRatio: videoPlayerController.value.aspectRatio,
                child: VideoPlayer(videoPlayerController)),
          ],
        ),
      ),
    );
  }
}
