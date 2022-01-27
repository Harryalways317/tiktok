
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:tiktok/controllers/auth_controller.dart';
import 'package:tiktok/view/screens/add_video_screen.dart';
import 'package:tiktok/view/screens/profile_screen.dart';
import 'package:tiktok/view/screens/search_screen.dart';
import 'package:tiktok/view/screens/video_screen.dart';

const backgroundColor = Colors.black;

var buttonColor = Colors.red[400];

const borderColor = Colors.grey;

//FIREBASE
var firebaseAuth = FirebaseAuth.instance;
var firebaseStorage = FirebaseStorage.instance;
var firebaseFirestore = FirebaseFirestore.instance;

//controllers
var authController = AuthController.instance;


//pages
List  pages = [
  VideoScreen(),
  SearchScreen(),
  const AddVideoScreen(),
  Text("Message"),
  ProfileScreen(uid: authController.user.uid),
];