
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:tiktok/constants.dart';
import 'package:tiktok/model/comment.dart';

class CommentController extends GetxController{
  Rx<List<Comment>> _commentList =  Rx<List<Comment>>([]);
  List<Comment> get commentList => _commentList.value;

  String _postId = "";

  updatePostId(String id){
    _postId = id;
    getComments();

  }

  Future postComment(String commentText)async{
    try{
      if(commentText!= ""){
        DocumentSnapshot userDoc = await firebaseFirestore.collection('users').doc(authController.user.uid).get();
        var allDocs = await firebaseFirestore.collection('videos').doc(_postId).collection('comments').get();
        int len = allDocs.docs.length;
        Comment comment = Comment(username: (userDoc.data()! as dynamic) ['name'], comment: commentText, datePublished: DateTime.now(), likes: [], profilePhoto: (userDoc.data()! as dynamic)['profileImage'], uid: authController.user.uid, id: "Comment $len");
        await firebaseFirestore.collection('videos').doc(_postId).collection('comments').doc("Comment $len").set(comment.toJson());
        DocumentSnapshot doc = await firebaseFirestore.collection('videos').doc(_postId).get();
        await firebaseFirestore.collection('videos').doc(_postId).update({
          //'commentCount' : ((doc.data()! as dynamic )['commentCount'] += 1),
          'commentCount' : ((doc.data()! as dynamic )['commentCount'] += 1),

        });
      }
    }catch(e){
      Get.snackbar("Error Posting Comments", e.toString());
    }
  }
  getComments()async{
    try{
     // var allDocs = await firebaseFirestore.collection('videos').doc(_postId).collection('comments').get();
      _commentList.bindStream(firebaseFirestore.collection('videos').doc(_postId).collection('comments').snapshots().map((QuerySnapshot query){
        List<Comment> retValue = [];
        query.docs.forEach((element) {
          retValue.add(Comment.fromSnap(element));
        });
        return retValue;
      }));


    }catch(e){
      Get.snackbar("Error Posting Comments", e.toString());
    }

  }


  likeComment(String id) async {
    try{

        var uid = authController.user.uid;
        DocumentSnapshot doc = await firebaseFirestore.collection('videos').doc(_postId).collection('comments').doc(id).get();
        //print("doccccc ${doc.data()} $_postId");
        if((doc.data()! as dynamic)['likes'].contains(uid)){
          await firebaseFirestore.collection('videos').doc(_postId).collection('comments').doc(id).update(
            {
              'likes' : FieldValue.arrayRemove([uid]),
            }
          );


        }else{
          await firebaseFirestore.collection('videos').doc(_postId).collection('comments').doc(id).update(
          {
          'likes' : FieldValue.arrayUnion([uid]),
          }
          );
        }

    }catch(e){
      Get.snackbar("Error Posting Comments", e.toString());
    }

  }
}