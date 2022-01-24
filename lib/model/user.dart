import 'package:cloud_firestore/cloud_firestore.dart';

class User{
  String name;
  String email;
  String uid;
  String profileImage;

  User({required this.name,required this.email,required this.profileImage , required this.uid});

  Map<String,dynamic> toJson() => {
    'name' : name,
    "profileImage" : profileImage,
    "uid" : uid,
    "email" : email
  };

  static User fromSnap(DocumentSnapshot snap){
    var snapshot = snap.data() as Map<String,dynamic>;
    return User(
      name: snapshot['name'],
      profileImage: snapshot['profileImage'],
      uid: snapshot['uid'],
      email: snapshot['email'],
    );

  }
}