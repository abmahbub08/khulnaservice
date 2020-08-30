import 'package:flutter/cupertino.dart';
import 'package:khulnaservice/models/profiledatamodel.dart';

class ProfileDataProvider extends ChangeNotifier {
  ProfileDataModel profileData = ProfileDataModel();

  addDaa(value) {
    profileData = value;
    notifyListeners();
  }
}
