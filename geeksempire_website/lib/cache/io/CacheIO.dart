import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CacheIO {

  final Future<SharedPreferences> sharedPreferences = SharedPreferences.getInstance();

  Future<String?> retrieveImagePath(String postId) async {

    return (await sharedPreferences).getString(postId);
  }

  Future storeImagePath(String postId, String imagePath) async {

    sharedPreferences.then((value) async => {

      await value.setString(postId, imagePath).then((value) => {
        debugPrint("Cached Successfully: $imagePath")
      })

    });

  }
}