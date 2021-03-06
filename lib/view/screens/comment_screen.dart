import 'package:flutter/material.dart';
import 'package:tiktok/constants.dart';
import 'package:tiktok/controllers/comment_controller.dart';
import 'package:tiktok/model/comment.dart';
import 'package:get/get.dart';
import 'package:timeago/timeago.dart' as tago;
class CommentScreen extends StatelessWidget {
  final String id;
   CommentScreen({Key? key,required this.id}) : super(key: key);
  final TextEditingController commentTextController = TextEditingController();
  CommentController commentController = Get.put(CommentController());

  @override
  Widget build(BuildContext context) {
    commentController.updatePostId(id);
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: SingleChildScrollView(
        child: SizedBox(
          height: size.height,
          width: size.width,
          child: Column(
            children: [
              Expanded(
                child: Obx(() {
                    return ListView.builder(
                      itemCount: commentController.commentList.length,
                        itemBuilder: (context,index){
                        var comment = commentController.commentList[index];
                      return ListTile(
                        leading: CircleAvatar(
                          backgroundColor: Colors.black,
                          backgroundImage: NetworkImage(comment.profilePhoto),
                        ),
                        //Row
                        title: Wrap(
                          children: [
                            Text(comment.username,style: TextStyle(fontSize: 20,color: Colors.red,fontWeight: FontWeight.w700),),
                            SizedBox(width: 5,),
                            Text(comment.comment,style: TextStyle(fontSize: 15,color: Colors.white,fontWeight: FontWeight.w500),),
                          ],
                        ),
                        subtitle: Row(
                          children: [
                            Text(tago.format(comment.datePublished.toDate()),style: TextStyle(fontSize: 12,color: Colors.white,fontWeight: FontWeight.w700),),
                            SizedBox(width: 10,),
                            Text("${comment.likes.length} Likes",style: TextStyle(fontSize: 12,color: Colors.white,fontWeight: FontWeight.w500),),

                          ],
                        ),
                        trailing: InkWell(onTap: () => commentController.likeComment(comment.id),child: Icon(Icons.favorite,size: 25,color: comment.likes.contains(authController.user.uid) ?Colors.red : Colors.white,)),
                      );
                    });
                  }
                ),
              ),
              Divider(),
              ListTile(
                title: TextFormField(
                  controller: commentTextController,
                  style: TextStyle(fontSize: 16,color: Colors.white),
                  decoration: InputDecoration(
                    labelText: "Comment",
                    labelStyle: TextStyle(fontSize: 20,color: Colors.white),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.red),
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.red),
                    ),
                  ),

                ),
                trailing: TextButton(
                  child: Text(
                      "Send",
                      style:TextStyle(fontSize: 16,color: Colors.white),
                  ),
                  onPressed: () => commentController.postComment(commentTextController.text).whenComplete(() => commentTextController.clear()),
                ),

              )
            ],
          ),

        ),
      ),
    );
  }
}
