import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tiktok/constants.dart';
import 'package:tiktok/view/screens/confirm_screen.dart';
import 'dart:io';

class AddVideoScreen extends StatelessWidget {
  const AddVideoScreen({Key? key}) : super(key: key);


  pickVideo(ImageSource src,BuildContext context) async {
    final video = await ImagePicker().pickVideo(source: src);
    if(video != null){
      Navigator.of(context).push(MaterialPageRoute(builder: (context) => ConfirmScreen(videoFile: File(video.path), videoPath: video.path,)));

    }
  }

  showOptionsDialog(BuildContext context){
    return showDialog(context: context, builder: (context) => SimpleDialog(
      children: [
        SimpleDialogOption(
          onPressed: () => pickVideo(ImageSource.camera, context),
          child: Row(
            children: [
              Icon(Icons.camera),

              Padding(
                padding: const EdgeInsets.all(7),
                child: Text("Camera",style: TextStyle(fontSize: 20),),
              )
            ],
          ),
        ),
        SimpleDialogOption(
          onPressed: ()  => pickVideo(ImageSource.gallery, context),
          child: Row(
            children: [
              Icon(Icons.image),

              Padding(
                padding: const EdgeInsets.all(7),
                child: Text("Gallery",style: TextStyle(fontSize: 20),),
              )
            ],
          ),
        ),
        SimpleDialogOption(
          onPressed: (){
            Navigator.of(context).pop();

          },
          child: Row(
            children: [
              Icon(Icons.close),

              Padding(
                padding: const EdgeInsets.all(7),
                child: Text("Cancel",style: TextStyle(fontSize: 20),),
              )
            ],
          ),
        ),
      ],
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: InkWell(
          onTap: () => showOptionsDialog(context),
          child: Container(
            width: 190,
              height: 50,
            decoration: BoxDecoration(color: buttonColor),
            child: Center(child: Text("Add Video",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20,color: Colors.black),),),
          ),
        ),
      ),
    );
  }
}
