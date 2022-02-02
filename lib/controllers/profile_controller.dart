import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:tiktok/constants.dart';

class ProfileController extends GetxController{
  final Rx<Map<String,dynamic>> _user = Rx<Map<String,dynamic>>({});
  Map<String,dynamic> get user => _user.value;

  Rx<String> _uid = "".obs;
  bool isFollowing = false;

  updateserId(String uid){
    _uid.value = uid;
    getUserData();
  }
  getUserData()async {
    List<String> thumbnails = [];
    var myVideos = await firebaseFirestore.collection('videos').where('uid',isEqualTo: _uid.value).get();
    myVideos.docs.forEach((element) { 
      thumbnails.add((element.data() as dynamic)['thumbnail']);
    });
    DocumentSnapshot userDoc = await firebaseFirestore.collection('users').doc(_uid.value).get();
    final userData = userDoc.data()! as Map<String,dynamic>;
    String name = userData['name'];
    String profileImage = userData['profileImage'];
    int likes = 0;
    int followers = 0;
    int following = 0;


    myVideos.docs.forEach((element) {
      likes += (element.data()['likes'] as List).length;
    });

    var followerDoc = await firebaseFirestore.collection('users').doc(_uid.value).collection('followers').get();
    var followingDoc = await firebaseFirestore.collection('users').doc(_uid.value).collection('following').get();
    followers = followerDoc.docs.length;
    following = followingDoc.docs.length;

    firebaseFirestore.collection('users').doc(_uid.value).collection('followers').doc(authController.user.uid).get().then((value) {
      if(value.exists){
        isFollowing = true;
      }else{
        isFollowing = false;
      }
    });

    _user.value = {
      'name' : name,
      'profileImage' : profileImage,
      'thumbnails' : thumbnails,
      'likes' : likes.toString(),
      'isFollowing' : isFollowing,
      'followers' : followers.toString(),
      'following ' : following.toString(),

    };
    update();



  }
}