import 'package:flutter/material.dart';
import 'package:tiktok/constants.dart';
import 'package:tiktok/view/widgets/custom_add_icon.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int pageIdx = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        onTap: (idx){
          setState(() {
            pageIdx = idx;
          });
        },
        currentIndex: pageIdx,
        selectedItemColor: buttonColor,
        unselectedItemColor: Colors.white,
        type: BottomNavigationBarType.fixed,
        backgroundColor: backgroundColor,
        items:
      [
        BottomNavigationBarItem(icon: Icon(Icons.home,size: 30,),label: "Home"),
        BottomNavigationBarItem(icon: Icon(Icons.search,size: 30,),label: "Search"),
        BottomNavigationBarItem(icon: CustomAddIcon(),label: "Home"),
        BottomNavigationBarItem(icon: Icon(Icons.message),label: "Message"),
        BottomNavigationBarItem(icon: Icon(Icons.person),label: "Profile"),

      ],

      ),
      body: Center(
        child: pages[pageIdx],
      ),
    );
  }
}
