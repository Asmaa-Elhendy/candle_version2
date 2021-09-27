import 'package:shared_preferences/shared_preferences.dart';
import 'dart:async';

class SaveInShared {

  static const KEY = 'candleList';

  //toJson
  static Future<bool> saveInShared(String candle) async {
    final prefs = await SharedPreferences.getInstance();
    List<String>? listInMemory = prefs.getStringList(KEY);
    List<String> newList = [candle];
    if (listInMemory == null) {
      print('if it nulllllllllll');
      return prefs.setStringList(KEY, newList);

    }
    listInMemory.add(candle);
     print('magood');
    return prefs.setStringList(KEY, listInMemory);
  }

  static Future<List<String>?> getAllData()async{
    final prefs = await SharedPreferences.getInstance();
    return prefs.getStringList(KEY) ?? null;
  }

  static Future<bool> clearAllData()async{
    final prefs = await SharedPreferences.getInstance();
    return prefs.clear(); //delete all files
  }

  static Future<bool> deleteMyList()async{
    final prefs = await SharedPreferences.getInstance();
    return prefs.setStringList(KEY,[]);
  }



}


//[ {}, {}, {}]

//have a list in memory or not ?

// list is null or notll or not
