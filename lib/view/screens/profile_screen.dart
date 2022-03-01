import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tiktok/constants.dart';
import '../../controllers/profile_controller.dart';

class ProfileScreen extends StatefulWidget {
  final String uid;

  ProfileScreen({Key? key, required this.uid}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final profileController = Get.put(ProfileController());

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    profileController.updateUserId(widget.uid);
  }

  @override
  Widget build(BuildContext context) {

    return GetBuilder<ProfileController>(
      init: ProfileController(),
      builder: (controller) {
        if(controller.user.isEmpty){
          return CircularProgressIndicator();
        }
        return Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.black12,
            leading: Icon(Icons.person_add_alt_1_sharp),
            title: Text(
              //"username"
              profileController.user['name']??"",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
            actions: [Icon(Icons.more_horiz)],
            centerTitle: true,
          ),
          body: SafeArea(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ClipOval(
                            child: CachedNetworkImage(
                              imageUrl: profileController.user["profileImage"],
                              fit: BoxFit.cover,
                              height: 100,
                              width: 100,
                              placeholder: (context, url) =>
                                  CircularProgressIndicator(),
                              errorWidget: (context, url, error) => Icon(Icons.error),
                            ),
                          )
                        ],
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Column(
                            children: [
                              Text(
                                profileController.user["following"]??"0",
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.bold),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Text("Following"),
                            ],
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          Column(
                            children: [
                              Text(
                          profileController.user["followers"] ?? "0",
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.bold),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Text("Followers"),
                            ],
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          Column(
                            children: [
                              Text(
                          profileController.user["likes"]??"0",
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.bold),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Text("Likes"),
                            ],
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Container(
                        width: 140,
                        height: 47,
                        decoration:
                            BoxDecoration(border: Border.all(color: Colors.black12)),
                        child: Center(
                          child: InkWell(
                              onTap: () {
                                if(widget.uid == authController.user.uid ){
                                  authController.signOut();
                                }else{
                                  profileController.followUser();
                                  setState(() {

                                  });
                                }
                              },
                              child: Text(
                                widget.uid == authController.user.uid ?"Sign Out": controller.user['isFollowing']?"unFollow":"Follow",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 15),
                              )),
                        ),
                      ),

                      //video list
                      GridView.builder(gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2,childAspectRatio: 1,crossAxisSpacing: 5), itemCount: controller.user['thumbnails'].length,physics: NeverScrollableScrollPhysics(),shrinkWrap: true,itemBuilder: (context,index){
                        String thumbnail = controller.user['thumbnails'][index];
                        return CachedNetworkImage(imageUrl: thumbnail,fit: BoxFit.cover,);
                      })
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      }
    );
  }
}
