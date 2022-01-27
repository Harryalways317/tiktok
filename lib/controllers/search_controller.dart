import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:tiktok/constants.dart';
import 'package:tiktok/model/user.dart';

class SearchController extends GetxController{
  final Rx<List<User>>  _searchedUsers = Rx<List<User>> ([]);
  List<User> get searchedUsers => _searchedUsers.value;

  searchUser(String typedUser) async {

    _searchedUsers.bindStream(
      firebaseFirestore.collection('users').where('name',isGreaterThanOrEqualTo: typedUser).snapshots().map((QuerySnapshot query) {
        List<User> retVal = [];
        query.docs.forEach((element) {
          retVal.add(User.fromSnap(element));
        });
        return retVal;
      }),
    );

  }
}