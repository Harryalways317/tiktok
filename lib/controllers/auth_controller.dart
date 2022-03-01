import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'dart:io';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tiktok/constants.dart';
import 'package:tiktok/model/user.dart' as model;
import 'package:tiktok/view/screens/auth/login_screen.dart';
import 'package:tiktok/view/screens/home_screen.dart';
class AuthController extends GetxController {

  static AuthController instance = Get.find();
  late Rx<User?> _user;
  User get user => _user.value!;
  late Rx<File?> _pickedImage;
  File? get profilePhoto => _pickedImage.value;

  @override
  void onReady() {
    super.onReady();
    // TODO: implement onReady
    _user = Rx<User?>(firebaseAuth.currentUser);
    _user.bindStream(firebaseAuth.authStateChanges());
    ever(_user, _setInitialScreen);

  }

  _setInitialScreen(User? user){
    if(user == null){
      Get.offAll(() => LoginScreen());
    }else{
      Get.offAll(() => HomeScreen());

    }

  }


  //pick image
  void pickImage() async{
    try{
      final pickedImage = await ImagePicker().pickImage(source: ImageSource.gallery);
      if(pickedImage!= null){
        // Fluttertoast.showToast(msg: "Sucessfully Picked Image");
        Get.snackbar("Profile Image"," Image Picked Successfully");

      }
      _pickedImage = Rx<File?>(File(pickedImage!.path));
    }catch(e){
      Get.snackbar("Profile Image","Please Pick an Image");
    }




  }

  //upload file to firebase storage
  Future<String> _uploadToStorage(File image)async{
    Reference ref =  firebaseStorage.ref("profilePics").child(firebaseAuth.currentUser!.uid);
    UploadTask uploadTask = ref.putFile(image);
    TaskSnapshot snap = await uploadTask;
    String downloadUrl = await snap.ref.getDownloadURL();
    return downloadUrl;

  }

  //register user
  void registerUser(String username,String email,String password,File? image)async{
    try{
      if(username.isNotEmpty && email.isNotEmpty && password.isNotEmpty && image != null){
        //save our user
        UserCredential cred = await firebaseAuth.createUserWithEmailAndPassword(email: email, password: password);
        String downloadUrl = await _uploadToStorage(image);
        model.User user = model.User(name: username,email: email,profileImage: downloadUrl,uid: cred.user!.uid);
        await firebaseFirestore.collection('users').doc(cred.user!.uid).set(user.toJson());
        Get.snackbar("Registration"," Registered Successfully");
      }else{
        Get.snackbar("Registration", "Please Fill all the fields");
       // print("Error");
      }
    }catch(e){
      Get.snackbar("Error Creating Account",e.toString());
      print(e);
    }

  }

  void loginUser(String email,String password)async{
    try{
      if(email.isNotEmpty && password.isNotEmpty){

        await firebaseAuth.signInWithEmailAndPassword(email: email, password: password);
        print("Logged IN");



      }else{
        Get.snackbar("Registration", "Please Fill all the fields");
      }


    }catch(e){
      Get.snackbar("Error Creating Account",e.toString());

    }
  }

  void signOut()async{
    await firebaseAuth.signOut();
  }
}
