import 'package:flutter/material.dart';
import 'package:tiktok/controllers/upload_video_controller.dart';
import 'package:tiktok/view/widgets/text_input_field.dart';
import 'dart:io';
import 'package:get/get.dart';
import 'package:video_player/video_player.dart';

class ConfirmScreen extends StatefulWidget {
  final File videoFile;
  final String videoPath;
   ConfirmScreen({Key? key,required, required this.videoFile, required this.videoPath }) : super(key: key);

  @override
  State<ConfirmScreen> createState() => _ConfirmScreenState();
}

class _ConfirmScreenState extends State<ConfirmScreen> {
  late VideoPlayerController controller;
  TextEditingController songController = TextEditingController();
  TextEditingController captionController = TextEditingController();

  UploadVideoController uploadVideoController = Get.put(UploadVideoController());
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      controller = VideoPlayerController.file(widget.videoFile);
      controller.initialize();
      controller.play();
      controller.setVolume(1);
      controller.setLooping(true);
    });
  }
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    controller.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 30,),
            SizedBox(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height*0.66,
              child: VideoPlayer(controller),
            ),
            SizedBox(
              height: 30,
            ),
            SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 10),
                    width: MediaQuery.of(context).size.width-20,
                    child: TextInputField(controller: songController,isObscure: false,labelText: "Song Name",icon: Icons.music_note,),
                  ),
                  SizedBox(height: 10,),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 10),
                    width: MediaQuery.of(context).size.width-20,
                    child: TextInputField(controller: captionController,isObscure: false,labelText: "Caption Name",icon: Icons.closed_caption,),
                  ),
                  SizedBox(height: 10,),
                  ElevatedButton(onPressed: () => uploadVideoController.uploadVideo(songController.text, captionController.text, widget.videoPath).then((value) {
                    Get.snackbar(value, "Check out in the home page");
                    Navigator.of(context).pop();
                    Navigator.of(context).pop();

                  }), child: Text("Share",style: TextStyle(fontSize: 20,color: Colors.white),))
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
