import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:tiktok/constants.dart';
import 'package:tiktok/model/video.dart';
import 'dart:io';

import 'package:video_compress/video_compress.dart';

class UploadVideoController extends GetxController{

  _compressVideo(String videoPath)async{
   // var  _subscription =
   //      VideoCompress.compressProgress$.subscribe((progress) {
   //        debugPrint('progress: $progress');
   //      });
    final compressedVideo =  await VideoCompress.compressVideo(videoPath,quality: VideoQuality.MediumQuality);
   // _subscription.unsubscribe;

    return compressedVideo!.file;
  }

  _getThumbnail(String videoPath) async{
    final thumbnail = await VideoCompress.getFileThumbnail(videoPath);
    return thumbnail;
  }

  //upload video function
  Future<String> _uploadVideotoStorage(String id, String videoPath)async{
    print("Uploading video");
    Reference ref = firebaseStorage.ref().child('videos').child(id);
    UploadTask uploadTask = ref.putFile(await _compressVideo(videoPath));
    TaskSnapshot snap = await uploadTask;
    String downloadUrl = await snap.ref.getDownloadURL();
    return downloadUrl;
  }


  Future<String> _uploadImagetoStorage(String id, String videoPath)async{
    print("Uploading thumbnail");
    Reference ref = firebaseStorage.ref().child('thumbnails').child(id);
    UploadTask uploadTask = ref.putFile(await _getThumbnail(videoPath));
    TaskSnapshot snap = await uploadTask;
    String downloadUrl = await snap.ref.getDownloadURL();
    return downloadUrl;
  }

  Future uploadVideo(String songName,String caption , String videoPath)async{

    try{
      print("Uploading");

      String uid = firebaseAuth.currentUser!.uid;
      DocumentSnapshot userDoc = await firebaseFirestore.collection('users').doc(uid).get();

      var allDocs = await  firebaseFirestore.collection('videos').get();
      int len = allDocs.docs.length;
      String videoUrl = await  _uploadVideotoStorage("Video $len",videoPath);
      print("video");
      String thumbnailUrl = await _uploadImagetoStorage("Video $len",videoPath);
      print("thumbnail");
      Video video = Video(thumbnail: thumbnailUrl, id: "Video $len", profilePhoto: (userDoc.data()! as Map<String,dynamic>)['profileImage'], videoUrl: videoUrl, caption: caption, commentCount: 0, likes: [], shareCount: 0, songName: songName, uid: uid, username: (userDoc.data()! as Map<String,dynamic>)['name'] );
      await firebaseFirestore.collection('videos').doc("Video $len").set(video.toJson());
      // print("Video Uploaded");
      //Get.snackbar("Video Uploaded", "");
      // print("get backed1");
      //
      // Get.back();
      // print("get backed2");
      return "Uploaded Successfully";



    }catch(e){
      //Get.snackbar("Error Uploading Video", e.toString());
      return e;

    }

  }
}