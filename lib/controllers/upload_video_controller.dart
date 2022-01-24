import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';
import 'package:tiktok/constants.dart';
import 'dart:io';

import 'package:video_compress/video_compress.dart';

class UploadVideoController extends GetxController{

  _compressVideo(String videoPath)async{
    final compressedVideo =  await VideoCompress.compressVideo(videoPath,quality: VideoQuality.MediumQuality);
    return compressedVideo!.file;
  }

  _getThumbnail(String videoPath) async{
    final thumbnail = await VideoCompress.getFileThumbnail(videoPath);
    return thumbnail;
  }

  //upload video function
  Future<String> _uploadVideotoStorage(String id, String videoPath)async{
    Reference ref = firebaseStorage.ref().child('videos').child(id);
    UploadTask uploadTask = ref.putFile(await _compressVideo(videoPath));
    TaskSnapshot snap = await uploadTask;
    String downloadUrl = await snap.ref.getDownloadURL();
    return downloadUrl;
  }


  Future<String> _uploadImagetoStorage(String id, String videoPath)async{
    Reference ref = firebaseStorage.ref().child('thumbnails').child(id);
    UploadTask uploadTask = ref.putFile(await _getThumbnail(videoPath));
    TaskSnapshot snap = await uploadTask;
    String downloadUrl = await snap.ref.getDownloadURL();
    return downloadUrl;
  }

  uploadVideo(String songName,String caption , String videoPath)async{

    try{

      String uid = firebaseAuth.currentUser!.uid;
      DocumentSnapshot userDoc = await firebaseFirestore.collection('users').doc(uid).get();

      var allDocs = await  firebaseFirestore.collection('videos').get();
      int len = allDocs.docs.length;
      String videoUrl = await  _uploadVideotoStorage("Video $len",videoPath);
      String thumbnailUrl = await _uploadImagetoStorage("Video $len",videoPath);

    }catch(e){

    }

  }
}