class Video{
  String userName;
  String uId;
  String id;
  List likes;
  int commentCount;
  int shareCount;
  String songName;
  String caption;
  String videoUrl;
  String thumbnail;
  String profilePhoto;

  Video({required this.thumbnail,required this.id,required this.profilePhoto,required this.videoUrl,required this.caption,required this.commentCount,required this.likes,required this.shareCount,required this.songName,required this.uId,required this.userName})
}