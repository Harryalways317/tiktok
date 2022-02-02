import 'package:get/get.dart';

class PreferencesController extends GetxController{
  // i'll keep it default by false
  Rx<bool> _isUserSelectedHQ = false.obs;
  bool get isUserSelectedHQ => _isUserSelectedHQ.value;

}