import 'package:flutter/material.dart';
import 'package:tiktok/controllers/search_controller.dart';
import 'package:get/get.dart';
import 'package:tiktok/view/screens/profile_screen.dart';

class SearchScreen extends StatelessWidget {
  SearchScreen({Key? key}) : super(key: key);
  final SearchController searchController = Get.put(SearchController());

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.red,
          title: TextFormField(
            decoration: InputDecoration(
              hintText: "Search",
              filled: false,
              hintStyle: TextStyle(fontSize: 16, color: Colors.white),
            ),
            onFieldSubmitted: (value) => searchController.searchUser(value),
          ),
        ),
        body: searchController.searchedUsers.isNotEmpty
            ? ListView.builder(
                itemBuilder: (context, index) {
                  var searchItem = searchController.searchedUsers[index];
                  return InkWell(
                    onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => ProfileScreen(uid: searchItem.uid,))),
                    child: ListTile(
                      leading: CircleAvatar(
                        backgroundImage: NetworkImage(searchItem.profileImage),
                      ),
                      title: Text(
                        searchItem.name,
                        style: TextStyle(fontSize: 20),
                      ),
                    ),
                  );
                },
                itemCount: searchController.searchedUsers.length,
              )
            : Center(
                child: Text(
                  "Search For Users + ${searchController.searchedUsers.length}",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                      color: Colors.white),
                ),
              ),
      );
    });
  }
}
