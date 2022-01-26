import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:tiktok/constants.dart';
import 'package:tiktok/view/screens/auth/login_screen.dart';
import 'package:get/get.dart';
import 'package:tiktok/view/screens/home_screen.dart';
import 'controllers/auth_controller.dart';
import 'package:firebase_auth/firebase_auth.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp().then((value) {
    Get.put(AuthController());
  });
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late Rx<User?> _user;

  // This widget is the root of your application.

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _user = Rx<User?>(firebaseAuth.currentUser);
    _user.bindStream(firebaseAuth.authStateChanges());
    ever(_user, _setInitialScreen);
  }

  _setInitialScreen(User? user){
    if(user == null){
     return LoginScreen();
    }else{
      return HomeScreen();

    }

  }


  @override
  Widget build(BuildContext context) {

    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData.dark().copyWith(
        backgroundColor: backgroundColor,
        scaffoldBackgroundColor: backgroundColor
      ),
    //  home: _setInitialScreen(_user.value),
      home: LoginScreen(),
    );
  }
}




///OLD FILE BACKUP
//import 'package:firebase_core/firebase_core.dart';
// import 'package:flutter/material.dart';
// import 'package:tiktok/constants.dart';
// import 'package:tiktok/view/screens/auth/login_screen.dart';
// import 'package:get/get.dart';
// import 'controllers/auth_controller.dart';
//
// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   await Firebase.initializeApp().then((value) {
//     Get.put(AuthController());
//   });
//   runApp(const MyApp());
// }
//
// class MyApp extends StatelessWidget {
//   const MyApp({Key? key}) : super(key: key);
//
//   // This widget is the root of your application.
//   @override
//   Widget build(BuildContext context) {
//
//     return GetMaterialApp(
//       debugShowCheckedModeBanner: false,
//       title: 'Flutter Demo',
//       theme: ThemeData.dark().copyWith(
//         backgroundColor: backgroundColor,
//         scaffoldBackgroundColor: backgroundColor
//       ),
//       home: LoginScreen(),
//     );
//   }
// }
